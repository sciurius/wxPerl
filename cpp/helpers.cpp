/////////////////////////////////////////////////////////////////////////////
// Name:        helpers.cpp
// Purpose:     implementation for helpers.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

// for some strange reason this is not called under MinGW
// so the HMODULE is retrieved from DynaLoader
#ifdef __WXMSW__
/*
BOOL WINAPI DllMain ( HANDLE hModule, DWORD fdwReason, LPVOID lpReserved )
{
    if( fdwReason == DLL_PROCESS_ATTACH )
        wxSetInstance( (HINSTANCE)hModule );
    return TRUE;
}
*/
#endif

inline _wxSelfRef::_wxSelfRef( const char* unused )
{
}

_wxSelfRef::~_wxSelfRef() 
{
    if( m_self )
        SvREFCNT_dec( m_self );
}

_wxUserDataCD::~_wxUserDataCD()
{
    SvREFCNT_dec( m_data );
}

_wxUserDataO::~_wxUserDataO()
{
    SvREFCNT_dec( m_data );
}

int wxCALLBACK ListCtrlCompareFn( long item1, long item2, long comparefn ) {
    dSP;
    SV* func = (SV*)comparefn;

    ENTER;
    SAVETMPS;

    PUSHMARK( SP );
    XPUSHs( sv_2mortal( newSViv( item1 ) ) );
    XPUSHs( sv_2mortal( newSViv( item2 ) ) );
    PUTBACK;

    int count = call_sv( (SV*)func, G_SCALAR );
    SPAGAIN;

    int retval = POPi;

    if( count != 1 )
    {
        croak( "Comparison function returned %d values ( 1 expected )",
               count );
    }
    
    PUTBACK;

    FREETMPS;
    LEAVE;

    return retval;
}

const char* _cpp_class_2_perl( const char* className ) 
{
    static char buffer[128] = "Wx::";

    if( className[0] == '_' )
        ++className;
    if( className[0] == 'w' && className[1] == 'x' )
        strcpy( buffer+4, className+2 );

    return buffer;
}

void _push_args( SV*** psp, const char* argtypes, va_list& args ) 
{
    SV** sp = *psp;

    if( argtypes == 0 )
        return;

    bool bval;
    IV ival;
    long lval;
    char* stval;
    SV* svval;
    wxObject* oval;

    while( *argtypes ) 
    {
        switch( *argtypes ) 
        {
        case 'b':
            bval = va_arg( args, bool );
            XPUSHs( bval ? &PL_sv_yes : &PL_sv_no );
            break;
        case 'i':
            ival = va_arg( args, int );
            XPUSHs( sv_2mortal( newSViv( ival ) ) );
            break;
        case 'l':
            lval = va_arg( args, long );
            XPUSHs( sv_2mortal( newSViv( ival ) ) );
            break;
        case 'p':
            stval = va_arg( args, char* );
            XPUSHs( sv_2mortal( newSVpv( stval, 0 ) ) );
            break;
        case 'S':
            svval = va_arg( args, SV* );
            XPUSHs( sv_2mortal( newSVsv( svval ) ) );
            break;
        case 'O':
            oval = va_arg( args, wxObject* );
            XPUSHs( _object_2_sv( sv_newmortal(), oval ) );
            break;
        default:
            printf( "Internal error: unrecognized type '%c'\n", *argtypes );
            abort();
        }

        ++argtypes;
    }

    *psp = sp;
}

// this use of static is deprecated, but we need to
// cope with C++ compilers
static SV* _key;
static U32 _hash;

// precalculate key and hash value for "_WXTHIS"
class wxHashModule:public wxModule {
    DECLARE_DYNAMIC_CLASS( wxHashModule );
public:
    wxHashModule() {};

    bool OnInit()
    {
        _key = newSVpv( "_WXTHIS", 7 );
        _hash = 0;

        HV* hv = newHV();
        HE* he = hv_store_ent( hv, _key, _key, 0 );

        if( he ) _hash = HeHASH( he );
        hv_undef( hv );
        SvREFCNT_dec( hv );

        return true;
    };

    void OnExit()
    {
        SvREFCNT_dec( _key );
    };
};

IMPLEMENT_DYNAMIC_CLASS( wxHashModule, wxModule );

// gets 'this' pointer from a blessed scalar/hash reference
void* _sv_2_object( SV* scalar, const char* classname ) 
{
    // is it correct to use undef as 'NULL'?
    if( !SvTRUE( scalar ) ) 
    {
        return 0;
    }

    if( sv_derived_from( scalar, CHAR_P classname ) ) 
    {
        SV* ref = SvRV( scalar );

        if( SvTYPE( ref ) == SVt_PVHV ) 
        {
            HV* hv = (HV*) ref;
            HE* value;

            if( ( value = hv_fetch_ent( hv, _key, 0, _hash ) ) ) 
            {
                return (void*)SvIV( HeVAL( value ) );
            }
            else 
            {
                croak( "the associative array (hash) does not have a '_WXTHIS' key" );
                return 0;
            }
        }
        else
            return (void*)SvIV( (SV*) ref );
    }
    else 
    {
        croak( "variable is not of type %s", classname );
        return 0;
    }
}

SV* _non_object_2_sv( SV* var, void* data, const char* package ) {
    if( data == 0 ) {
        sv_setsv( var, &PL_sv_undef );
    }
    else {
        sv_setref_pv( var, CHAR_P package, data );
    }

    return var;
}

SV* _object_2_sv( SV* var, wxObject* object ) 
{
    if( object == 0 )
    {
        sv_setsv( var, &PL_sv_undef );
        return var;
    }

    wxClassInfo *ci = object->GetClassInfo();
    const char* classname = ci->GetClassName();

    if( classname[0] == '_' ) 
    {
        _wxClassInfo* cci = (_wxClassInfo*)ci;
        _wxSelfRef* sr = cci->m_func( object );

        if( sr->m_self ) {
            sv_setsv( var, sr->m_self );
            return var;
        }
    }

    const char* CLASS = _cpp_class_2_perl( classname );

    sv_setref_pv( var, CHAR_P CLASS, object );

    return var;
}

SV* _make_object( wxObject* object, const char* classname ) 
{
    SV* ret;
    SV* value;
    HV* hv;
    HV* stash;

    hv = newHV();
    ret = newRV_inc( (SV*) hv );

    stash = gv_stashpv( CHAR_P classname, 0 );
    value = newSViv( (IV) object );
    if( !hv_store_ent( hv, _key, value, _hash ) ) {
        SvREFCNT_dec( value );
        croak( "error storing '_WXTHIS' value" );
    }

    return sv_bless( ret, stash );
}

int _av_2_svarray( SV* avref, SV*** array )
{
    SV** arr;
    int n, i;
    AV* av;
    SV* t;

    if( !SvROK( avref ) || 
        ( SvTYPE( (SV*) ( av = (AV*) SvRV( avref ) ) ) != SVt_PVAV ) )
    {
        croak( "the value is not an array reference" );
        return 0;
    }
    
    n = av_len( av ) + 1;
    arr = new SV*[ n ];

    for( i = 0; i < n; ++i )
    {
        t = *av_fetch( av, i, 0 );
        arr[i] = t;
    }

    *array = arr;

    return n;
}

int _av_2_uchararray( SV* avref, unsigned char** array )
{
    unsigned char* arr;
    int n, i;
    AV* av;
    SV* t;

    if( !SvROK( avref ) || 
        ( SvTYPE( (SV*) ( av = (AV*) SvRV( avref ) ) ) != SVt_PVAV ) )
    {
        croak( "the value is not an array reference" );
        return 0;
    }
    
    n = av_len( av ) + 1;
    arr = new unsigned char[ n ];

    for( i = 0; i < n; ++i )
    {
        t = *av_fetch( av, i, 0 );
        arr[i] = (unsigned char)SvUV( t );
    }

    *array = arr;

    return n;
}

int _av_2_stringarray( SV* avref, wxString** array )
{
    wxString* arr;
    int n, i;
    AV* av;
    SV* t;

    if( !SvROK( avref ) || 
        ( SvTYPE( (SV*) ( av = (AV*) SvRV( avref ) ) ) != SVt_PVAV ) )
    {
        croak( "the value is not an array reference" );
        return 0;
    }
    
    n = av_len( av ) + 1;
    arr = new wxString[ n ];

    for( i = 0; i < n; ++i )
    {
        t = *av_fetch( av, i, 0 );
        arr[i] = SvPV_nolen( t );
    }

    *array = arr;

    return n;
}

int _get_args_argc_argv( char*** argvp ) 
{
    AV* args = get_av( "main::ARGV" , 0 );
    SV* progname = get_sv( "main::0", 0 );
    I32 argc;
    char** argv;

    if( args != 0 ) 
    {
        I32 i;
        int arg_num = av_len( args ) + 1;

        argv = new char* [arg_num + 1 + 1];
        argv[0] = SvPV_nolen( progname );

        for( i=0; i < arg_num; ++i )
        {
            argv[i + 1] = SvPV_nolen( *av_fetch( args, i, 0 ) );
        }
        argv[arg_num + 1] = 0;
        argc = arg_num + 1;
    } 
    else 
    {
        argc = 1;
        argv = new char* [2];
        argv[0] = SvPV_nolen( progname );
        argv[1] = 0;
    }

    *argvp = argv;
    return argc;
}

const char* _get_class( SV* ref )
{
    const char* ret;

    if( sv_isobject( ref ) )
    {
        ret = HvNAME( SvSTASH( ref ) );
    }
    else
    {
        ret = SvPV_nolen( ref );
    }

    return ret;
}

#if 0

void _get_args_objectarray( SV** sp, int items, void** array, const char* package )
{
    int i;

    for( i = 0; i < items; ++i )
    {
        array[i] = _sv_2_object( sp[i], package );
    }
}

#endif

wxPoint _sv_2_wxpoint( SV* scalar )
{
    if( SvROK( scalar ) ) 
    {
        SV* ref = SvRV( scalar );
        
        if( sv_derived_from( scalar, CHAR_P wxPlPointName ) ) 
        {
            return *(wxPoint*)SvIV( ref );
        }
        else if( SvTYPE( ref ) == SVt_PVAV )
        {
            AV* av = (AV*) ref;
            
            if( av_len( av ) != 1 )
            {
                croak( "the array reference must have 2 elements" );
            }
            else
            {
                int x = SvIV( *av_fetch( av, 0, 0 ) );
                int y = SvIV( *av_fetch( av, 1, 0 ) );
                
                return wxPoint( x, y );
            }
        }
    }
    
    croak( "variable is not of type Wx::Point" );
    return wxPoint();
}

wxSize _sv_2_wxsize( SV* scalar )
{
    if( SvROK( scalar ) ) 
    {
        SV* ref = SvRV( scalar );
        
        if( sv_derived_from( scalar, CHAR_P wxPlSizeName ) ) 
        {
            return *(wxSize*)SvIV( ref );
        }
        else if( SvTYPE( ref ) == SVt_PVAV )
        {
            AV* av = (AV*) ref;
            
            if( av_len( av ) != 1 )
            {
                croak( "the array reference must have 2 elements" );
            }
            else
            {
                int x = SvIV( *av_fetch( av, 0, 0 ) );
                int y = SvIV( *av_fetch( av, 1, 0 ) );
                
                return wxSize( x, y );
            }
        }
    }
    
    croak( "variable is not of type Wx::Size" );
    return wxSize();
}

int _get_pointarray( SV* arr, wxList *points, wxPoint** tmp )
{
    *tmp = 0;

    if( !SvROK( arr ) || SvTYPE( SvRV( arr ) ) != SVt_PVAV )
    {
        croak( "variable is not an array reference" );
    }

    AV* array = (AV*) SvRV( arr );
    int itm = av_len( array ) + 1, i;

    if( itm == 0 )
        return 0;

    *tmp = new wxPoint[ itm ];
    int used = 0;

    for( i = 0; i < itm; ++i )
    {
        SV* scalar = *av_fetch( array, i, 0 );

        if( SvROK( scalar ) ) 
        {
            SV* ref = SvRV( scalar );
        
            if( sv_derived_from( scalar, CHAR_P wxPlPointName ) ) 
            {
                points->Append( (wxObject*)SvIV( ref ) );
                continue;
            }
            else if( SvTYPE( ref ) == SVt_PVAV )
            {
                AV* av = (AV*) ref;
            
                if( av_len( av ) != 1 )
                {
                    croak( "the array reference must have 2 elements" );
                    delete [] *tmp;
                    return 0;
                }
                else
                {
                    int x = SvIV( *av_fetch( av, 0, 0 ) );
                    int y = SvIV( *av_fetch( av, 1, 0 ) );

                    (*tmp)[ used ] = wxPoint( x, y );
                    points->Append( (wxObject*)(*tmp) + used );
                    ++used;
                    continue;
                }
            }
        }

        croak( "variable is not of type Wx::Point" );
        delete [] *tmp;
        return 0;
    }

    return itm;
}

// Local variables: //
// mode: c++ //
// End: //

