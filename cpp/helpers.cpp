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

#ifdef __WXMSW__

extern "C" 
BOOL WINAPI DllMain( HANDLE hModule, DWORD fdwReason, LPVOID lpReserved )
{
    if( fdwReason == DLL_PROCESS_ATTACH )
        wxSetInstance( (HINSTANCE)hModule );
    return TRUE;
}

#endif

wxPliUserDataCD::~wxPliUserDataCD()
{
    dTHX;
    SvREFCNT_dec( m_data );
}

wxPliUserDataO::~wxPliUserDataO()
{
    dTHX;
    SvREFCNT_dec( m_data );
}

int wxCALLBACK ListCtrlCompareFn( long item1, long item2, long comparefn )
{
    dTHX;
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

const char* wxPli_cpp_class_2_perl( const wxChar* className,
                                    char buffer[WXPL_BUF_SIZE] ) 
{
    strcpy( buffer, "Wx::" );

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
    wxConvUTF8.WC2MB( buffer+4, className, WXPL_BUF_SIZE - 8 );
#else
    strcpy( buffer+4, className );
#endif

    return buffer;
}

void wxPli_push_args( pTHX_ SV*** psp, const char* argtypes, va_list& args ) 
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
    wxChar* wstval;
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
            wxPli_wxString_2_sv( aTHX_ *wxsval, sv );
            XPUSHs( sv );
            break;
        }
        case 'w':
        {
            wstval = va_arg( args, wxChar* );
            SV* sv = sv_newmortal();
            wxPli_wxChar_2_sv( aTHX_ wstval, sv );
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
            break;
        case 'O':
            oval = va_arg( args, wxObject* );
            XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), oval ) );
            break;
        case 'o':
            pval = va_arg( args, void* );
            package = va_arg( args, const char* );
            XPUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                           pval, package ) );
            break;
        default:
            croak( "Internal error: unrecognized type '%c'\n", *argtypes );
        }

        ++argtypes;
    }

    *psp = sp;
}

// this use of static is deprecated, but we need to
// cope with C++ compilers
static SV* _key;
static U32 _hash;

static U32 calc_hash( const char* key, size_t klen )
{
    U32 h;
    PERL_HASH( h, (char*)key, klen );
    return h;
}

// precalculate key and hash value for "_WXTHIS"
class wxHashModule:public wxModule {
    DECLARE_DYNAMIC_CLASS( wxHashModule );
public:
    wxHashModule() {};

    bool OnInit()
    {
        const char* kname = "_WXTHIS";
        const int klen = 7;
        dTHX;

        _key = newSVpvn( CHAR_P kname, klen );
        _hash = calc_hash( kname, klen );

        return TRUE;
    };

    void OnExit()
    {
        dTHX;
        SvREFCNT_dec( _key );
    };
};

IMPLEMENT_DYNAMIC_CLASS( wxHashModule, wxModule );

// gets 'this' pointer from a blessed scalar/hash reference
void* wxPli_sv_2_object( pTHX_ SV* scalar, const char* classname ) 
{
    // is it correct to use undef as 'NULL'?
    if( !SvOK( scalar ) ) 
    {
        return 0;
    }

    if( /* 1 || */ sv_derived_from( scalar, CHAR_P classname ) ) 
    {
        SV* ref = SvRV( scalar );

        if( SvTYPE( ref ) == SVt_PVHV ) 
        {
            HV* hv = (HV*) ref;
            HE* value = hv_fetch_ent( hv, _key, 0, _hash );

            if( value ) 
            {
                SV* sv = HeVAL( value );
                /*
                if( SvGMAGICAL( sv ) )
                {
                    wxTrap();
                    mg_get( sv );
                }
                */
                return (void*)SvIV( sv );
            }
            else 
            {
                croak( "the associative array (hash) "
                       " does not have a '_WXTHIS' key" );
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

SV* wxPli_non_object_2_sv( pTHX_ SV* var, void* data, const char* package ) {
    if( data == 0 ) {
        sv_setsv( var, &PL_sv_undef );
    }
    else {
        sv_setref_pv( var, CHAR_P package, data );
    }

    return var;
}

SV* wxPli_object_2_sv( pTHX_ SV* var, wxObject* object ) 
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

        if( sr && sr->m_self ) {
            SvSetSV_nosteal( var, sr->m_self );
            return var;
        }
    }

    char buffer[WXPL_BUF_SIZE];
    const char* CLASS = wxPli_cpp_class_2_perl( classname, buffer );

    sv_setref_pv( var, CHAR_P CLASS, object );

    return var;
}

SV* wxPli_make_object( void* object, const char* classname ) 
{
    dTHX;
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

bool wxPli_object_is_deleteable( pTHX_ SV* object )
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

void wxPli_object_set_deleteable( pTHX_ SV* object, bool deleteable )
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

void wxPli_stringarray_push( pTHX_ const wxArrayString& strings )
{
    dSP;

    size_t max = strings.GetCount();
    EXTEND( SP, max );
    for( size_t i = 0; i < max; ++i )
    {
#if wxUSE_UNICODE
        SV* tmp = sv_2mortal( newSVpv( strings[i].mb_str(wxConvUTF8), 0 ) );
        SvUTF8_on( tmp );
        PUSHs( tmp );
#else
        PUSHs( sv_2mortal( newSVpvn( CHAR_P strings[i].c_str(),
                                     strings[i].size() ) ) );
#endif
    }

    PUTBACK;
}

AV* wxPli_stringarray_2_av( pTHX_ const wxArrayString& strings )
{
    AV* av = newAV();
    size_t i, n = strings.GetCount();
    SV* tmp;

    av_extend( av, n );
    for( i = 0; i < n; ++i )
    {
#if wxUSE_UNICODE
        tmp = newSVpv( strings[i].mb_str(wxConvUTF8), 0 );
        SvUTF8_on( tmp );
#else
        tmp = newSVpv( CHAR_P strings[i].c_str(), 0 );
#endif
        av_store( av, i, tmp );
    }

    return av;
}

AV* wxPli_uchararray_2_av( pTHX_ const unsigned char* array, int count )
{
    AV* av = newAV();

    av_extend( av, count );
    for( int i = 0; i < count; ++i )
    {
        av_store( av, i, newSViv( array[i] ) );
    }

    return av;
}

int wxPli_av_2_svarray( pTHX_ SV* avref, SV*** array )
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

int wxPli_av_2_uchararray( pTHX_ SV* avref, unsigned char** array )
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

int wxPli_av_2_intarray( pTHX_ SV* avref, int** array )
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

#include <wx/menu.h>

wxWindowID wxPli_get_wxwindowid( pTHX_ SV* var )
{
    if( sv_isobject( var ) )
    {
        if( sv_derived_from( var, "Wx::Window" ) ) {
            wxWindow* window = (wxWindow*)
                wxPli_sv_2_object( aTHX_ var, "Wx::Window" );

            return window->GetId();
        }
        else if( sv_derived_from( var, "Wx::MenuItem" ) )
        {
            wxMenuItem* item = (wxMenuItem*)
                wxPli_sv_2_object( aTHX_ var, "Wx::MenuItem" );

            return item->GetId();
        }
    }

    return SvIV( var );
}

int wxPli_av_2_stringarray( pTHX_ SV* avref, wxString** array )
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
wxChar* my_strdup( const wxChar* s, size_t len )
{
    wxChar* t = (wxChar*)malloc( (len + 1) * sizeof(wxChar) );

    t[len] = 0;
    memcpy( t, s, len * sizeof(wxChar) );

    return t;
}
#endif

char* my_strdup( const char* s, size_t len )
{
    char* t = (char*)malloc( len + 1 );

    t[len] = 0;
    memcpy( t, s, len );

    return t;
}

int wxPli_av_2_charparray( pTHX_ SV* avref, char*** array )
{
    char** arr;
    int n, i;
    AV* av;

    if( !SvROK( avref ) || 
        ( SvTYPE( (SV*) ( av = (AV*) SvRV( avref ) ) ) != SVt_PVAV ) )
    {
        croak( "the value is not an array reference" );
        return 0;
    }
    
    n = av_len( av ) + 1;
    arr = new char*[ n ];

    for( i = 0; i < n; ++i )
    {
        SV* tmp = *av_fetch( av, i, 0 );
        STRLEN len;
        char* t = SvPV( tmp, len );
        arr[i] = my_strdup( t, len );
    }

    *array = arr;

    return n;
}

int wxPli_av_2_wxcharparray( pTHX_ SV* avref, wxChar*** array )
{
    wxChar** arr;
    int n, i;
    AV* av;

    if( !SvROK( avref ) || 
        ( SvTYPE( (SV*) ( av = (AV*) SvRV( avref ) ) ) != SVt_PVAV ) )
    {
        croak( "the value is not an array reference" );
        return 0;
    }
    
    n = av_len( av ) + 1;
    arr = new wxChar*[ n ];

    for( i = 0; i < n; ++i )
    {
        SV* tmp = *av_fetch( av, i, 0 );
        wxString str;
        WXSTRING_INPUT( str, wxString, tmp );
        arr[i] = my_strdup( str.c_str(), str.length() );
    }

    *array = arr;

    return n;
}

#if wxUSE_UNICODE
wxChar* wxPli_copy_string( SV* scalar, wxChar** )
{
    dTHX;
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
    dTHX;
    STRLEN length;
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
    dTHX;
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

const char* wxPli_get_class( pTHX_ SV* ref )
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

wxPoint wxPli_sv_2_wxpoint( pTHX_ SV* scalar )
{
    return wxPli_sv_2_wxpoint_test( aTHX_ scalar, 0 );
}

wxPoint wxPli_sv_2_wxpoint_test( pTHX_ SV* scalar, bool* ispoint )
{
    static wxPoint dummy;

    if( ispoint )
        *ispoint = TRUE;

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
                if( ispoint )
                {
                    *ispoint = FALSE;
                    return dummy;
                }
                else
                {
                    croak( "the array reference must have 2 elements" );
                }
            }
            else
            {
                int x = SvIV( *av_fetch( av, 0, 0 ) );
                int y = SvIV( *av_fetch( av, 1, 0 ) );
                
                return wxPoint( x, y );
            }
        }
    }
    
    if( ispoint )
    {
        *ispoint = FALSE;
        return dummy;
    }
    else
    {
        croak( "variable is not of type Wx::Point" );
    }

    return dummy;
}

wxSize wxPli_sv_2_wxsize( pTHX_ SV* scalar )
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

Wx_KeyCode wxPli_sv_2_keycode( pTHX_ SV* sv )
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

int wxPli_av_2_pointarray( pTHX_ SV* arr, wxPoint** points )
{
    *points = 0;

    if( !SvROK( arr ) || SvTYPE( SvRV( arr ) ) != SVt_PVAV )
    {
        croak( "variable is not an array reference" );
    }

    AV* array = (AV*) SvRV( arr );
    size_t items = av_len( array ) + 1, i;

    if( items == 0 )
        return 0;

    wxPoint* tmp = new wxPoint[ items ];
    for( i = 0; i < items; ++i )
    {
        SV* scalar = *av_fetch( array, i, 0 );

        if( SvROK( scalar ) ) 
        {
            bool isPoint;

            tmp[ i ] = wxPli_sv_2_wxpoint_test( aTHX_ scalar, &isPoint );
            if( !isPoint )
            {
                delete [] tmp;
                croak( "variable is not of type Wx::Point" );
                return 0;
            }
        }
    }

    *points = tmp;
    return items;
}

int wxPli_av_2_pointlist( pTHX_ SV* arr, wxList *points, wxPoint** tmp )
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

void wxPli_sv_2_istream( pTHX_ SV* scalar, wxPliInputStream& stream )
{
    stream = wxPliInputStream( scalar );
}

void wxPli_sv_2_ostream( pTHX_ SV* scalar, wxPliOutputStream& stream )
{
    stream = wxPliOutputStream( scalar );
}

void wxPli_stream_2_sv( pTHX_ SV* scalar, wxStreamBase* stream,
                        const char* package )
{
    if( !stream )
    {
        SvSetSV_nosteal( scalar, &PL_sv_undef );
        return;
    }

    static SV* tie = eval_pv
        ( "sub { local *o; my $c = shift; tie *o, $c, @_; return *o }", 1 );
    static SV* dummy = SvREFCNT_inc( tie );

    dSP;

    PUSHMARK( SP );
    XPUSHs( newSVpv( CHAR_P package, 0 ) );
    XPUSHs( newSViv( (IV)stream ) );
    PUTBACK;

    call_sv( tie, G_SCALAR );

    SPAGAIN;
    SV* ret = POPs;
    SV* tmp = newSViv( 0 );
    SvSetSV_nosteal( tmp, ret );
    SV* rv = newRV_noinc( tmp );
    SvSetSV_nosteal( scalar, rv );
    SvREFCNT_dec( rv );
    PUTBACK;
}

I32 my_looks_like_number( pTHX_ SV* sv )
{
    if( SvROK( sv ) || !SvOK( sv ) ) return 0;
    if( SvIOK( sv ) || SvNOK( sv ) ) return 1;
    return looks_like_number( sv );
}

// Local variables: //
// mode: c++ //
// End: //
