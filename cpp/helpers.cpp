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

#if __WXMSW__

BOOL WINAPI DllMain ( HANDLE hModule, DWORD fdwReason, LPVOID lpReserved )
{
    if( fdwReason == DLL_PROCESS_ATTACH )
        wxSetInstance( (HINSTANCE)hModule );
    // printf( "%x\n", hModule );
    return TRUE;
}

#endif

_wxSelfRef::_wxSelfRef( const char* unused )
{
}

_wxSelfRef::~_wxSelfRef() 
{
    if( m_self )
        SvREFCNT_dec( m_self );
}

void _wxSelfRef::SetSelf( SV* self, bool increment ) 
{
    m_self = self;
    if( increment )       
        SvREFCNT_inc( m_self );
}

_wxUserDataCD::_wxUserDataCD( SV* data )
{
    m_data = data;
    SvREFCNT_inc( m_data );
}

_wxUserDataCD::~_wxUserDataCD()
{
    SvREFCNT_dec( m_data );
}

_wxUserDataO::_wxUserDataO( SV* data )
{
    m_data = data;
    SvREFCNT_inc( m_data );
}

_wxUserDataO::~_wxUserDataO()
{
    SvREFCNT_dec( m_data );
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

void _push_args( SV** sp, const char* argtypes, va_list& args ) 
{
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
            XPUSHs( &PL_sv_undef );
        }

        ++argtypes;
    }
}

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
            SV** value;
            //FIXME// precalculate key/hash
            if( ( value = hv_fetch( hv, "_WXTHIS", 7, 0 ) ) ) 
            {
                return (void*)SvIV( *value );
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
    if( !hv_store( hv, "_WXTHIS", 7, value, 0 ) )
        croak( "error storing '_WXTHIS' value" );

    return sv_bless( ret, stash );
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
#if WXP_VERSION < 5006
        arr[i] = SvPV( t, PL_na );
#else
        arr[i] = SvPV_nolen( t );
#endif
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
#if WXP_VERSION < 5006
        argv[0] = SvPV( progname, PL_na );
#else
        argv[0] = SvPV_nolen( progname );
#endif

        for( i=0; i < arg_num; ++i )
        {
#if WXP_VERSION < 5006
            argv[i + 1] = SvPV( *av_fetch( args, i, 0 ), PL_na );
#else
            argv[i + 1] = SvPV_nolen( *av_fetch( args, i, 0 ) );
#endif
        }
        argv[arg_num + 1] = 0;
        argc = arg_num + 1;
    } 
    else 
    {
        argc = 1;
        argv = new char* [2];
#if WXP_VERSION < 5006
        argv[0] = SvPV( progname, PL_na );
#else
        argv[0] = SvPV_nolen( progname );
#endif
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
#if WXP_VERSION < 5006
        ret = SvPV( ref, PL_na );
#else
        ret = SvPV_nolen( ref );
#endif
    }

    return ret;
}

void _get_args_objectarray( SV** sp, int items, void** array, const char* package )
{
    int i;

    for( i = 0; i < items; ++i )
    {
        array[i] = _sv_2_object( sp[i], package );
    }
}

wxPoint _sv_2_wxpoint( SV* scalar )
{
    if( SvROK( scalar ) ) 
    {
        SV* ref = SvRV( scalar );
        
        if( sv_derived_from( scalar, CHAR_P wxPlPointName ) ) 
        {
            return *(wxPoint*)SvIV( (SV*) SvRV( scalar ) );
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

// Local variables: //
// mode: c++ //
// End: //
