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

#include "cpp/streams.h"
#include "cpp/streams.cpp"

// for some strange reason this is not called under MinGW
// so the HMODULE is retrieved from DynaLoader
// ( BTW this is bad since NOTHING guarantees that the handle from
//   DynaLoader is the HMODULE of the library: it happens to work... )
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

wxPliUserDataCD::~wxPliUserDataCD()
{
    SvREFCNT_dec( m_data );
}

wxPliUserDataO::~wxPliUserDataO()
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
        PUTBACK;
        FREETMPS;
        LEAVE;

        croak( "Comparison function returned %d values ( 1 expected )",
               count );
    }
    
    PUTBACK;

    FREETMPS;
    LEAVE;

    return retval;
}

const char* wxPli_cpp_class_2_perl( const wxChar* className ) 
{
    static char buffer[128] = "Wx::";

    if( className[0] == wxT('w') && className[1] == wxT('x') )
        className += 2;
    if( className[0] == wxT('P') && className[1] == wxT('l') )
    {
        if( className[2] == wxT('i') )
            className += 3;
        else
            className += 2;
    }
#if wxUSE_UNICODE
    wxConvUTF8.WC2MB( buffer+4, className, 120 );
#else
    strcpy( buffer+4, className );
#endif

    return buffer;
}

void wxPli_push_args( SV*** psp, const char* argtypes, va_list& args ) 
{
    SV** sp = *psp;
#if WXPERL_P_VERSION_GE( 5, 5, 0 )
    dTHR;
#endif

    if( argtypes == 0 )
        return;

    bool bval;
    IV ival;
    long lval;
    char* stval;
    SV* svval;
    wxObject* oval;
    void* pval;
    wxString* wxsval;
    const char* package;

    while( *argtypes ) 
    {
        switch( *argtypes ) 
        {
        case 'b':
            bval = va_arg( args, int );
            XPUSHs( bval ? &PL_sv_yes : &PL_sv_no );
            break;
        case 'i':
            ival = va_arg( args, int );
            XPUSHs( sv_2mortal( newSViv( ival ) ) );
            break;
        case 'l':
            lval = va_arg( args, long );
            XPUSHs( sv_2mortal( newSViv( lval ) ) );
            break;
        case 'p':
            stval = va_arg( args, char* );
            XPUSHs( sv_2mortal( newSVpv( stval, 0 ) ) );
            break;
        case 'P':
        {
            wxsval = va_arg( args, wxString* );
            SV* sv = sv_newmortal();
            WXSTRING_OUTPUT( (*wxsval), sv );
            XPUSHs( sv );
            break;
        }
        case 'S':
            svval = va_arg( args, SV* );
            XPUSHs( sv_2mortal( newSVsv( svval ) ) );
            break;
        case 's':
            svval = va_arg( args, SV* );
            XPUSHs( svval );
        case 'O':
            oval = va_arg( args, wxObject* );
            XPUSHs( wxPli_object_2_sv( sv_newmortal(), oval ) );
            break;
        case 'o':
            pval = va_arg( args, void* );
            package = va_arg( args, const char* );
            XPUSHs( wxPli_non_object_2_sv( sv_newmortal(), pval, package ) );
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
void* wxPli_sv_2_object( SV* scalar, const char* classname ) 
{
    // is it correct to use undef as 'NULL'?
    if( !SvOK( scalar ) ) 
    {
        return 0;
    }

    if( sv_derived_from( scalar, CHAR_P classname ) ) 
    {
        SV* ref = SvRV( scalar );

        if( SvTYPE( ref ) == SVt_PVHV ) 
        {
            HV* hv = (HV*) ref;
            HE* value = hv_fetch_ent( hv, _key, 0, _hash );

            if( value ) 
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

SV* wxPli_non_object_2_sv( SV* var, void* data, const char* package ) {
    if( data == 0 ) {
        sv_setsv( var, &PL_sv_undef );
    }
    else {
        sv_setref_pv( var, CHAR_P package, data );
    }

    return var;
}

SV* wxPli_object_2_sv( SV* var, wxObject* object ) 
{
    if( object == 0 )
    {
        sv_setsv( var, &PL_sv_undef );
        return var;
    }

    wxClassInfo *ci = object->GetClassInfo();
    const wxChar* classname = ci->GetClassName();

#if wxUSE_UNICODE
    if( wcsncmp( classname, wxT("wxPl"), 4 ) == 0 ) 
#else
    if( strnEQ( classname, "wxPl", 4 ) ) 
#endif
    {
        wxPliClassInfo* cci = (wxPliClassInfo*)ci;
        wxPliSelfRef* sr = cci->m_func( object );

        if( sr->m_self ) {
            SvSetSV_nosteal( var, sr->m_self );
            return var;
        }
    }

    const char* CLASS = wxPli_cpp_class_2_perl( classname );

    sv_setref_pv( var, CHAR_P CLASS, object );

    return var;
}

SV* wxPli_make_object( void* object, const char* classname ) 
{
    SV* ret;
    SV* value;
    HV* hv;
    HV* stash;

    hv = newHV();
    ret = newRV_noinc( (SV*) hv );
    // OK: if you want to keep it, just use SetSelf( sv, TRUE );
    sv_2mortal( ret ); 

    stash = gv_stashpv( CHAR_P classname, 0 );
    value = newSViv( (IV) object );
    if( !hv_store_ent( hv, _key, value, _hash ) ) {
        SvREFCNT_dec( value );
        croak( "error storing '_WXTHIS' value" );
    }

    return sv_bless( ret, stash );
}

struct my_magic {
    bool deleteable;
};

bool wxPli_object_is_deleteable( SV* object )
{
    // check for reference
    if( !SvROK( object ) )
        return FALSE;
    SV* rv = SvRV( object );

    // if it isn't a SvPVMG, then it can't have MAGIC
    // so it is deleteable
    if( SvTYPE( rv ) < SVt_PVMG )
        return TRUE;

    // search for '~' magic, and check the value
    MAGIC* magic = mg_find( rv, '~' );
    if( !magic )
        return TRUE;
    
    return ((my_magic*)( magic->mg_ptr ))->deleteable;
}

void wxPli_object_set_deleteable( SV* object, bool deleteable )
{
    // check for reference
    if( !SvROK( object ) )
        return;
    SV* rv = SvRV( object );

    // if it isn't a SvPVMG, then it might need to be upgraded
    if( SvTYPE( rv ) < SVt_PVMG )
    {
        // if it isn't magic, then it is deleteable
        if( !deleteable ) {
            static my_magic magic = { TRUE };
          
            sv_magic( rv, 0, '~', (char*)&magic, sizeof( my_magic ) );
        }
    }
    else
    {
        MAGIC* magic = mg_find( rv, '~' );

        if( magic )
            ((my_magic*)magic->mg_ptr)->deleteable = deleteable;
        else
        {
            my_magic magic;
            magic.deleteable = deleteable;

            sv_magic( rv, 0, '~', (char*)&magic, sizeof( my_magic ) );
        }
    }
}

int wxPli_av_2_svarray( SV* avref, SV*** array )
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

int wxPli_av_2_uchararray( SV* avref, unsigned char** array )
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

int wxPli_av_2_intarray( SV* avref, int** array )
{
    int* arr;
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
    arr = new int[ n ];

    for( i = 0; i < n; ++i )
    {
        t = *av_fetch( av, i, 0 );
        arr[i] = (int)SvIV( t );
    }

    *array = arr;

    return n;
}

wxWindowID wxPli_get_wxwindowid( SV* var )
{
    if( sv_isobject( var ) && sv_derived_from( var, "Wx::Window" ) )
    {
        wxWindow* window = (wxWindow*)wxPli_sv_2_object( var, "Wx::Window" );

        return window->GetId();
    }
    else
    {
        return SvIV( var );
    }
}

int wxPli_av_2_stringarray( SV* avref, wxString** array )
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
        WXSTRING_INPUT( arr[i], const char*, t );
    }

    *array = arr;

    return n;
}

#if wxUSE_UNICODE
wxChar* wxPli_copy_string( SV* scalar, wxChar** )
{
    STRLEN length;
    wxWCharBuffer tmp = ( SvUTF8( scalar ) ) ?
      wxConvUTF8.cMB2WX( SvPVutf8( scalar, length ) ) :
      wxWCharBuffer( wxString( SvPV( scalar, length ) ).wc_str() );
    
    wxChar* buffer = new wxChar[length + 1];
    memcpy( buffer, tmp.data(), length * sizeof(wxChar) );
    buffer[length] = wxT('\0');
    return buffer;
}
#endif

char* wxPli_copy_string( SV* scalar, char** )
{
    unsigned int length;
    const char* tmp = SvPV( scalar, length );

    char* buffer = new char[length + 1];
    memcpy( buffer, tmp, length * sizeof(char) );
    buffer[length] = 0;
    return buffer;
}

void wxPli_delete_argv( void* argv, bool unicode )
{
#if wxUSE_UNICODE
    if( unicode )
    {
        wxChar** arg = (wxChar**)argv;
        wxChar** i;
        for( i = arg; *i; ++i ) { /*delete[] ( *arg );*/ }
        delete[] arg;
    }
    else
    {
#endif
        char** arg = (char**)argv;
        char** i;
        for( i = arg; *i; ++i ) { /*delete[] ( *arg );*/ }
        delete[] arg;
#if wxUSE_UNICODE
    }
#endif
}

int wxPli_get_args_argc_argv( void* argvp, bool unicode ) 
{
#if wxUSE_UNICODE
    wxChar** argv_w;
#endif
    char ** argv_a;
    AV* args = get_av( "main::ARGV" , 0 );
    SV* progname = get_sv( "main::0", 0 );
    int arg_num = args ? av_len( args ) + 1 : 0;
    I32 argc = arg_num + 1;
    I32 i;

    if( !progname ) progname = &PL_sv_undef;

#if wxUSE_UNICODE
    if( unicode )
    {
        argv_w = new wxChar*[ arg_num + 2 ];
        argv_w[argc] = 0;
        argv_w[0] = wxPli_copy_string( progname, argv_w );

        for( i=0; i < arg_num; ++i )
        {
            argv_w[i + 1] = wxPli_copy_string( *av_fetch( args, i, 0 ), argv_w );
        }

        *(wxChar***)argvp = argv_w;
    }
    else
    {
#endif
        argv_a = new char*[ arg_num + 2 ];
        argv_a[argc] = 0;
        argv_a[0] = wxPli_copy_string( progname, argv_a );

        for( i=0; i < arg_num; ++i )
        {
            argv_a[i + 1] = wxPli_copy_string( *av_fetch( args, i, 0 ), argv_a );
        }

        *(char***)argvp = argv_a;
#if wxUSE_UNICODE
    }
#endif

    return argc;
}

const char* wxPli_get_class( SV* ref )
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

wxPoint wxPli_sv_2_wxpoint( SV* scalar )
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

wxSize wxPli_sv_2_wxsize( SV* scalar )
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

Wx_KeyCode wxPli_sv_2_keycode( SV* sv )
{
    if( SvIOK( sv ) || SvNOK( sv ) )
    {
        return SvIV( sv );
    }
    else if( SvPOK( sv ) && SvLEN( sv ) == 2 )
    {
        return ( SvPV_nolen( sv ) )[0];
    }
    else
    {
        croak( "You must supply either a number or a 1-character string" );
    }

    return 0; // yust to silence a possible warning
}

int wxPli_av_2_pointarray( SV* arr, wxList *points, wxPoint** tmp )
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

void wxPli_sv_2_istream( SV* scalar, wxPliInputStream& stream )
{
    stream = wxPliInputStream( scalar );
}

void wxPli_sv_2_ostream( SV* scalar, wxPliOutputStream& stream )
{
    stream = wxPliOutputStream( scalar );
}

void wxPli_stream_2_sv( SV* scalar, wxStreamBase* stream, const char* package )
{
    static SV* tie = eval_pv
        ( "sub { local *o; my $c = shift; tie *o, $c, @_; return \\*o }", 1 );
    static SV* dummy = SvREFCNT_inc( tie );

    dSP;

    PUSHMARK( SP );
//    XPUSHs( scalar );
    XPUSHs( newSVpv( CHAR_P package, 0 ) );
    XPUSHs( newSViv( (IV)stream ) );
    PUTBACK;

    call_sv( tie, G_SCALAR );

    SPAGAIN;
    SV* ret = POPs;
    SvSetSV_nosteal( scalar, ret );
    PUTBACK;
}

// Local variables: //
// mode: c++ //
// End: //
