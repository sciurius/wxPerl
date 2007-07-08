/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/helpers.cpp
// Purpose:     implementation for helpers.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2007 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/streams.h"
#include "cpp/streams.cpp"

#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    #include <wx/arrstr.h>
#endif
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
    #include <wx/gbsizer.h>
#endif

#define wxPL_USE_MAGIC 1

// ----------------------------------------------------------------------------
// wxMSW DLL intialisation
// ----------------------------------------------------------------------------

#ifdef __WXMSW__

extern "C" 
BOOL WINAPI DllMain( HANDLE hModule, DWORD fdwReason, LPVOID lpReserved )
{
    if( fdwReason == DLL_PROCESS_ATTACH && !wxGetInstance() )
        wxSetInstance( (HINSTANCE)hModule );
    return TRUE;
}

#endif

// ----------------------------------------------------------------------------
// Utility functions for working with MAGIC
// ----------------------------------------------------------------------------

struct my_magic
{
    my_magic() : object( NULL ), deleteable( true ) { }

    wxObject*  object;
    bool       deleteable;
};

my_magic* wxPli_get_magic( pTHX_ SV* rv )
{
    // check for reference
    if( !SvROK( rv ) )
        return NULL;
    SV* ref = SvRV( rv );

    // if it isn't a SvPVMG, then it can't have MAGIC
    // so it is deleteable
    if( !ref || SvTYPE( ref ) < SVt_PVMG )
        return NULL;

    // search for '~' magic, and check the value
    MAGIC* magic = mg_find( ref, '~' );

    if( !magic )
        return NULL;

    return (my_magic*)magic->mg_ptr;
}

my_magic* wxPli_get_or_create_magic( pTHX_ SV* rv )
{
    // check for reference
    if( !SvROK( rv ) )
        croak( "PANIC: object is not a reference" );
    SV* ref = SvRV( rv );

    // must be at least a PVMG
    if( SvTYPE( ref ) < SVt_PVMG )
        SvUPGRADE( ref, SVt_PVMG );

    // search for '~' magic, and check the value
    MAGIC* magic;

    while( !( magic = mg_find( ref, '~' ) ) )
    {
        my_magic tmp;

        sv_magic( ref, 0, '~', (char*)&tmp, sizeof( tmp ) );
    }

    return (my_magic*)magic->mg_ptr;
}

// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------

void wxPliSelfRef::DeleteSelf( bool fromDestroy )
{
    if( !m_self )
        return;

    dTHX;

    SV* self = m_self;
    m_self = NULL;
    wxPli_detach_object( aTHX_ self );
    if( SvROK( self ) )
    {
        if( fromDestroy )
        {
            SvROK_off( self );
            SvRV( self ) = NULL;
        }
        if( SvREFCNT( self ) > 0 )
            SvREFCNT_dec( self );
    }
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

    PUTBACK;

    FREETMPS;
    LEAVE;

    if( count != 1 )
    {
        croak( "Comparison function returned %d values ( 1 expected )",
               count );
    }

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

void wxPli_push_arguments( pTHX_ SV*** psp, const char* argtypes, ... )
{
    va_list arglist;
    va_start( arglist, argtypes );

    wxPli_push_args( aTHX_ psp, argtypes, arglist );
    
    va_end( arglist );
}

void wxPli_delayed_delete( pTHX_ SV* sv )
{
    wxPli_detach_object( aTHX_ sv );
    SvREFCNT_dec( sv );
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
    unsigned long ulval;
    char* stval;
    wxChar* wstval;
    SV* svval;
    wxObject* oval;
    void* pval;
    wxString* wxsval;
    const char* package;
    double dval;

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
        case 'L':
            ulval = va_arg( args, unsigned long );
            XPUSHs( sv_2mortal( newSVuv( ulval ) ) );
            break;
        case 'd':
            dval = va_arg( args, double );
            XPUSHs( sv_2mortal( newSVnv( dval ) ) );
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
        case 'Q':
        {
            oval = va_arg( args, wxObject* );
            SV* sv = wxPli_object_2_sv( aTHX_ newSViv( 0 ), oval ); 
            if( *argtypes == 'Q' ) {
                SvREFCNT_inc( sv );
                SAVEDESTRUCTOR_X( wxPli_delayed_delete, sv );
            }
            XPUSHs( sv_2mortal( sv ) );
            break;
        }
        case 'o':
        case 'q':
        {
            pval = va_arg( args, void* );
            package = va_arg( args, const char* );
            SV * sv = wxPli_non_object_2_sv( aTHX_ newSViv( 0 ),
                                             pval, package );
            if( *argtypes == 'q' ) {
                SvREFCNT_inc( sv );
                SAVEDESTRUCTOR_X( wxPli_delayed_delete, sv );
            }
            XPUSHs( sv_2mortal( sv ) );
            break;
        }
        default:
            croak( "Internal error: unrecognized type '%c'\n", *argtypes );
        }

        ++argtypes;
    }

    *psp = sp;
}

#if !wxPL_USE_MAGIC

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
class wxHashModule : public wxModule {
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

        return true;
    };

    void OnExit()
    {
        dTHX;
        SvREFCNT_dec( _key );
    };
};

IMPLEMENT_DYNAMIC_CLASS( wxHashModule, wxModule );

#endif // !wxPL_USE_MAGIC

// gets 'this' pointer from a blessed scalar/hash reference
void* wxPli_sv_2_object( pTHX_ SV* scalar, const char* classname ) 
{
    // is it correct to use undef as 'NULL'?
    if( !SvOK( scalar ) ) 
    {
        return NULL;
    }

    if( !SvROK( scalar ) )
        croak( "the invocant must be a reference" );

    if( !classname || sv_derived_from( scalar, CHAR_P classname ) ) 
    {
        SV* ref = SvRV( scalar );

#if wxPL_USE_MAGIC
        my_magic* mg = wxPli_get_magic( aTHX_ scalar );

        // rationale: if this is an hash-ish object, it always
        // has both mg and mg->object; if however this is a
        // scalar-ish object that has been marked/unmarked deletable
        // it has mg, but not mg->object
        if( !mg || !mg->object )
            return INT2PTR( void*, SvOK( ref ) ? SvIV( ref ) : NULL );

        return mg->object;
#else // if !wxPL_USE_MAGIC
        if( SvTYPE( ref ) == SVt_PVHV ) 
        {
            HV* hv = (HV*) ref;
            HE* value = hv_fetch_ent( hv, _key, 0, _hash );

            if( value ) 
            {
                SV* sv = HeVAL( value );
                return (void*)SvIV( sv );
            }
            else 
            {
                croak( "the associative array (hash) "
                       " does not have a '_WXTHIS' key" );
                return NULL; // dummy, for compiler
            }
        }
        else
            return (void*)SvIV( (SV*) ref );
#endif // wxPL_USE_MAGIC / !wxPL_USE_MAGIC
    }
    else 
    {
        croak( "variable is not of type %s", classname );
        return NULL; // dummy, for compiler
    }
}

SV* wxPli_non_object_2_sv( pTHX_ SV* var, const void* data, const char* package )
{
    if( data == NULL )
    {
        sv_setsv( var, &PL_sv_undef );
    }
    else
    {
        sv_setref_pv( var, CHAR_P package, const_cast<void*>(data) );
    }

    return var;
}

SV* wxPli_clientdatacontainer_2_sv( pTHX_ SV* var, wxClientDataContainer* cdc, const char* klass )
{
    if( cdc == NULL )
    {
        sv_setsv( var, &PL_sv_undef );
        return var;
    }

    wxPliUserDataCD* clientData = (wxPliUserDataCD*) cdc->GetClientObject();

    if( clientData != NULL )
    {
        SvSetSV_nosteal( var, clientData->GetData() );
        return var;
    }

    return wxPli_non_object_2_sv( aTHX_ var, cdc, klass );
}

SV* wxPli_evthandler_2_sv( pTHX_ SV* var, wxEvtHandler* cdc )
{
    if( cdc == NULL )
    {
        sv_setsv( var, &PL_sv_undef );
        return var;
    }

    wxPliUserDataCD* clientData = (wxPliUserDataCD*)cdc->GetClientObject();

    if( clientData )
    {     
        SvSetSV_nosteal( var, clientData->GetData() );
        return var;
    }

    // blech, duplicated code
    wxClassInfo *ci = cdc->GetClassInfo();
    const wxChar* classname = ci->GetClassName();

    char buffer[WXPL_BUF_SIZE];
    const char* CLASS = wxPli_cpp_class_2_perl( classname, buffer );

    sv_setref_pv( var, CHAR_P CLASS, cdc );

    return var;
}

SV* wxPli_object_2_sv( pTHX_ SV* var, const wxObject* object ) 
{
    if( object == NULL )
    {
        sv_setsv( var, &PL_sv_undef );
        return var;
    }

    wxClassInfo *ci = object->GetClassInfo();
    const wxChar* classname = ci->GetClassName();
    wxEvtHandler* evtHandler = wxDynamicCast( object, wxEvtHandler );

    if( evtHandler && evtHandler->GetClientObject() )
        return wxPli_evthandler_2_sv( aTHX_ var, evtHandler );

#if wxUSE_UNICODE
    if( wcsncmp( classname, wxT("wxPl"), 4 ) == 0 ) 
#else
    if( strnEQ( classname, "wxPl", 4 ) ) 
#endif
    {
        wxPliClassInfo* cci = (wxPliClassInfo*)ci;
        wxPliSelfRef* sr = cci->m_func( const_cast<wxObject*>(object) );

        if( sr && sr->m_self )
        {
            SvSetSV_nosteal( var, sr->m_self );
            return var;
        }
    }

    char buffer[WXPL_BUF_SIZE];
    const char* CLASS = wxPli_cpp_class_2_perl( classname, buffer );

    sv_setref_pv( var, CHAR_P CLASS, const_cast<wxObject*>(object) );

    return var;
}

void wxPli_attach_object( pTHX_ SV* object, void* ptr )
{
    SV* ref = SvRV( object );

    if( SvTYPE( ref ) >= SVt_PVHV )
    {
#if wxPL_USE_MAGIC
        my_magic* mg = wxPli_get_or_create_magic( aTHX_ object );

        mg->object = (wxObject*)ptr;
#else
        SV* value = newSViv( (IV)ptr );
        if( !hv_store_ent( (HV*)ref, _key, value, _hash ) )
        {
            SvREFCNT_dec( value );
            croak( "error storing '_WXTHIS' value" );
        }
#endif
    }
    else
    {
        sv_setiv( ref, PTR2IV( ptr ) );
    }
}

void* wxPli_detach_object( pTHX_ SV* object )
{
    if( !SvROK( object ) )
        return NULL;
    SV* ref = SvRV( object );

    if( SvTYPE( ref ) >= SVt_PVHV )
    {
#if wxPL_USE_MAGIC
        my_magic* mg = wxPli_get_magic( aTHX_ object );

        if( mg )
        {
            void* tmp = mg->object;

            mg->object = NULL;
            return tmp;
        }

        return NULL;
#else
        HE* value = hv_fetch_ent( (HV*)ref, _key, 0, _hash );

        if( value ) 
        {
            SV* sv = HeVAL( value );
            void* tmp = (void*)SvIV( sv );

            sv_setiv( sv, 0 );
            return tmp;
        }

        return NULL;
#endif
    }
    else
    {
        void* tmp = INT2PTR( void*, SvIV( ref ) );

        sv_setiv( ref, 0 );
        return tmp;
    }
}

/*
SV* wxPli_create_clientdatacontainer( pTHX_ wxClientDataContainer* object,
                                      const char* classname )
{
    SV* sv = wxPli_make_object( object, classname );
    wxPliUserDataCD* clientData = new wxPliUserDataCD( sv );

    object->SetClientObject( clientData );

    return sv;
}
*/

SV* wxPli_create_evthandler( pTHX_ wxEvtHandler* object,
                             const char* classname )
{
    SV* sv = wxPli_make_object( object, classname );
    wxPliUserDataCD* clientData = new wxPliUserDataCD( sv );

    object->SetClientObject( clientData );

    return sv;
}

SV* wxPli_make_object( void* object, const char* classname ) 
{
    dTHX;
    SV* ret;
    HV* hv;
    HV* stash = gv_stashpv( CHAR_P classname, 0 );

    hv = newHV();
    ret = newRV_noinc( (SV*) hv );
    // OK: if you want to keep it, just use SetSelf( sv, true );
    sv_2mortal( ret ); 

    wxPli_attach_object( aTHX_ ret, object );

    return sv_bless( ret, stash );
}

bool wxPli_object_is_deleteable( pTHX_ SV* object )
{
    my_magic* mg = wxPli_get_magic( aTHX_ object );

    return mg             ? mg->deleteable :
           SvRV( object ) ? true           :
                            false;
}

void wxPli_object_set_deleteable( pTHX_ SV* object, bool deleteable )
{
    // check for reference
    if( !SvROK( object ) )
        return;
    SV* rv = SvRV( object );

    // non-PVMG are always deletable
    if( deleteable && SvTYPE( rv ) < SVt_PVMG )
        return;

    my_magic* mg = wxPli_get_or_create_magic( aTHX_ object );

    mg->deleteable = deleteable;
}

void wxPli_stringarray_push( pTHX_ const wxArrayString& strings )
{
    dSP;

    size_t mx = strings.GetCount();
    EXTEND( SP, int(mx) );
    for( size_t i = 0; i < mx; ++i )
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

void wxPli_intarray_push( pTHX_ const wxArrayInt& ints )
{
    dSP;

    size_t mx = ints.GetCount();
    EXTEND( SP, int(mx) );
    for( size_t i = 0; i < mx; ++i )
    {
        PUSHs( sv_2mortal( newSViv( ints[i] ) ) );
    }

    PUTBACK;
}

AV* wxPli_objlist_2_av( pTHX_ const wxList& objs )
{
    AV* av = newAV();
    size_t i;
    wxList::compatibility_iterator node;

    av_extend( av, objs.GetCount() );
    for( node = objs.GetFirst(), i = 0; node; ++i, node = node->GetNext() )
    {
        SV* tmp = wxPli_object_2_sv( aTHX_ sv_newmortal(), node->GetData() ); 
        SvREFCNT_inc( tmp );
        av_store( av, i, tmp );
    }

    return av;
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

template<class A> class array_thingy
{
public:
    typedef A** lvalue;
    typedef A* rvalue;

    rvalue create( size_t n ) const { return new A[n]; }
    void assign( lvalue lv, rvalue rv ) const { *lv = rv; }
};

template<class F, class C>
int wxPli_av_2_thingarray( pTHX_ SV* avref, typename C::lvalue array,
                           const F& convertf, const C& thingy )
{
    AV* av;

    if( !SvROK( avref ) || 
        ( SvTYPE( (SV*) ( av = (AV*) SvRV( avref ) ) ) != SVt_PVAV ) )
    {
        croak( "the value is not an array reference" );
        return 0;
    }
    
    int n = av_len( av ) + 1;
    typename C::rvalue arr = thingy.create( n );

    for( int i = 0; i < n; ++i )
    {
        SV* t = *av_fetch( av, i, 0 );
        convertf( aTHX_ arr[i], t );
    }

    thingy.assign( array, arr );

    return n;
}

class convert_sv
{
public:
    void operator()( pTHX_ SV*& dest, SV* src ) const { dest = src; }
};

int wxPli_av_2_svarray( pTHX_ SV* avref, SV*** array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_sv(),
                                  array_thingy<SV*>() );
}

class convert_udatacd
{
public:
    void operator()( pTHX_ wxPliUserDataCD*& dest, SV* src ) const
    {
        dest = SvOK( src ) ? new wxPliUserDataCD( src ) : NULL;
    }
};

int wxPli_av_2_userdatacdarray( pTHX_ SV* avref, wxPliUserDataCD*** array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_udatacd(),
                                  array_thingy<wxPliUserDataCD*>() );
}

class convert_uchar
{
public:
    void operator()( pTHX_ unsigned char& dest, SV* src ) const
    {
        dest = (unsigned char) SvUV( src );
    }
};

int wxPli_av_2_uchararray( pTHX_ SV* avref, unsigned char** array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_uchar(),
                                  array_thingy<unsigned char>() );
}

class convert_int
{
public:
    void operator()( pTHX_ int& dest, SV* src ) const
    {
        dest = (int) SvIV( src );
    }
};

int wxPli_av_2_intarray( pTHX_ SV* avref, int** array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_int(),
                                  array_thingy<int>() );
}

#include <wx/menu.h>
#include <wx/timer.h>

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
        else if( sv_derived_from( var, "Wx::Timer" ) )
        {
            wxTimer* timer = (wxTimer*)
                wxPli_sv_2_object( aTHX_ var, "Wx::Timer" );

            return timer->GetId();
        }
    }

    return SvIV( var );
}

class convert_wxstring
{
public:
    void operator()( pTHX_ wxString& dest, SV* src ) const
    {
        WXSTRING_INPUT( dest, const char*, src );
    }
};

int wxPli_av_2_stringarray( pTHX_ SV* avref, wxString** array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_wxstring(),
                                  array_thingy<wxString>() );
}

template<class A, class B, B init>
class wxarray_thingy
{
public:
    typedef A* lvalue;
    typedef A& rvalue;

    wxarray_thingy( lvalue lv ) : m_value( lv ) { }
    rvalue create( size_t n ) const
    {
        m_value->Alloc( n );
        for( size_t i = 0; i < n; ++i )
            m_value->Add( init );
        return *m_value;
    }
    void assign( lvalue, rvalue ) const { }
private:
    A* m_value;
};

extern const wxChar wxPliEmptyString[];

int wxPli_av_2_arraystring( pTHX_ SV* avref, wxArrayString* array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_wxstring(),
                                  wxarray_thingy<wxArrayString, const wxChar*, wxPliEmptyString>( array ) );
}

int wxPli_av_2_arrayint( pTHX_ SV* avref, wxArrayInt* array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_int(),
                                  wxarray_thingy<wxArrayInt, int, 0>( array ) );
}

const wxChar wxPliEmptyString[] = wxT("");

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

class convert_charp
{
public:
    void operator()( pTHX_ char*& dest, SV* src ) const
    {
        STRLEN len;
        char* t = SvPV( src, len );
        dest = my_strdup( t, len );
    }
};

int wxPli_av_2_charparray( pTHX_ SV* avref, char*** array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_charp(),
                                  array_thingy<char*>() );
}

class convert_wxcharp
{
public:
    void operator()( pTHX_ wxChar*& dest, SV* src ) const
    {
        wxString str;
        WXSTRING_INPUT( str, wxString, src );
        dest = my_strdup( (const wxChar*)str.c_str(), str.length() );
    }
};

int wxPli_av_2_wxcharparray( pTHX_ SV* avref, wxChar*** array )
{
    return wxPli_av_2_thingarray( aTHX_ avref, array, convert_wxcharp(),
                                  array_thingy<wxChar*>() );
}

#if wxUSE_UNICODE
static wxChar* wxPli_copy_string( SV* scalar, wxChar** )
{
    dTHX;
    STRLEN length;
    wxWCharBuffer tmp = ( SvUTF8( scalar ) ) ?
      wxConvUTF8.cMB2WX( SvPVutf8( scalar, length ) ) :
      wxWCharBuffer( wxString( SvPV( scalar, length ),
                               wxConvLocal ).wc_str() );
    
    wxChar* buffer = new wxChar[length + 1];
    memcpy( buffer, tmp.data(), length * sizeof(wxChar) );
    buffer[length] = wxT('\0');
    return buffer;
}
#endif

static char* wxPli_copy_string( SV* scalar, char** )
{
    dTHX;
    STRLEN length;
    const char* tmp = SvPV( scalar, length );

    char* buffer = new char[length + 1];
    memcpy( buffer, tmp, length * sizeof(char) );
    buffer[length] = 0;
    return buffer;
}

void wxPli_delete_argv( void*** argv, bool unicode )
{
#if wxUSE_UNICODE
    if( unicode )
    {
        wxChar** arg = *(wxChar***)argv;
        if( arg != NULL )
            for( wxChar** i = arg; *i; ++i ) delete[] *i;
        delete[] arg;
        *(wxChar***)argv = NULL;
    }
    else
    {
#endif
        char** arg = *(char***)argv;
        if( arg != NULL )
            for( char** i = arg; *i; ++i ) delete[] *i;
        delete[] arg;
        *(char***)argv = NULL;
#if wxUSE_UNICODE
    }
#endif
}

int wxPli_get_args_argc_argv( void*** argvp, bool unicode ) 
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

        for( i = 0; i < arg_num; ++i )
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

        for( i = 0; i < arg_num; ++i )
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
        ret = HvNAME( SvSTASH( SvRV( ref ) ) );
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
        *ispoint = true;

    if( SvROK( scalar ) ) 
    {
        SV* ref = SvRV( scalar );
        
        if( sv_derived_from( scalar, CHAR_P "Wx::Point" ) ) 
        {
            return *INT2PTR( wxPoint*, SvIV( ref ) );
        }
        else if( SvTYPE( ref ) == SVt_PVAV )
        {
            AV* av = (AV*) ref;
            
            if( av_len( av ) != 1 )
            {
                if( ispoint )
                {
                    *ispoint = false;
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
        *ispoint = false;
        return dummy;
    }
    else
    {
        croak( "variable is not of type Wx::Point" );
    }

    return dummy;
}

template<class T>
inline T wxPli_sv_2_wxthing( pTHX_ SV* scalar, const char* name )
{
    if( SvROK( scalar ) ) 
    {
        SV* ref = SvRV( scalar );
        
        if( sv_derived_from( scalar, CHAR_P name ) ) 
            return *INT2PTR( T*, SvIV( ref ) );
        else if( SvTYPE( ref ) == SVt_PVAV )
        {
            AV* av = (AV*) ref;
            
            if( av_len( av ) != 1 )
                croak( "the array reference must have 2 elements" );
            else
                return T( SvIV( *av_fetch( av, 0, 0 ) ),
                          SvIV( *av_fetch( av, 1, 0 ) ) );
        }
    }
    
    croak( "variable is not of type %s", name );
    return T(); // to appease the compilers
}

wxSize wxPli_sv_2_wxsize( pTHX_ SV* scalar )
{
    return wxPli_sv_2_wxthing<wxSize>( aTHX_ scalar, "Wx::Size" );
}

#if WXPERL_W_VERSION_GE( 2, 6, 0 )

wxGBPosition wxPli_sv_2_wxgbposition( pTHX_ SV* scalar )
{
    return wxPli_sv_2_wxthing<wxGBPosition>( aTHX_ scalar, "Wx::GBPosition" );
}

wxGBSpan wxPli_sv_2_wxgbspan( pTHX_ SV* scalar )
{
    return wxPli_sv_2_wxthing<wxGBSpan>( aTHX_ scalar, "Wx::GBSpan" );
}

#endif

wxKeyCode wxPli_sv_2_keycode( pTHX_ SV* sv )
{
    if( SvIOK( sv ) || SvNOK( sv ) )
    {
        return (wxKeyCode) SvIV( sv );
    }
    else if( SvPOK( sv ) && SvCUR( sv ) == 1 )
    {
        return (wxKeyCode) ( SvPV_nolen( sv ) )[0];
    }
    else
    {
        croak( "You must supply either a number or a 1-character string" );
    }

    return wxKeyCode( 0 ); // yust to silence a possible warning
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
        
            if( sv_derived_from( scalar, CHAR_P "Wx::Point" ) ) 
            {
                points->Append( INT2PTR( wxObject*, SvIV( ref ) ) );
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
        ( "require Symbol; sub { my $x = Symbol::gensym(); my $c = shift; tie *$x, $c, @_; return $x }", 1 );
    static SV* dummy = SvREFCNT_inc( tie );

    dSP;

    PUSHMARK( SP );
    XPUSHs( newSVpv( CHAR_P package, 0 ) );
    XPUSHs( newSViv( PTR2IV( stream ) ) );
    PUTBACK;

    call_sv( tie, G_SCALAR );

    SPAGAIN;
    SV* ret = POPs;
    SvSetSV_nosteal( scalar, ret );
    PUTBACK;
}

I32 my_looks_like_number( pTHX_ SV* sv )
{
    if( SvROK( sv ) || !SvOK( sv ) ) return 0;
    if( SvIOK( sv ) || SvNOK( sv ) ) return 1;
    return looks_like_number( sv );
}

#if wxPERL_USE_THREADS

#define dwxHash( package, create )             \
    char wxrbuffer[512];                       \
    strcpy( wxrbuffer, (package) );            \
    strcat( wxrbuffer, "::_thr_register" );    \
    HV* wxhash = get_hv( wxrbuffer, (create) ) \

#define dwxKey( ptr )              \
    char wxkey[50];                \
    sprintf( wxkey, "%x", (ptr) ); \

void wxPli_thread_sv_register( pTHX_ const char* package,
                               const void* ptr, SV* sv )
{
    if( !SvROK( sv ) )
        croak( "PANIC: no sense in registering a non-reference" );

    dwxHash( package, 1 );
    dwxKey( ptr );

    SV* nsv = newRV( SvRV( sv ) );
    hv_store( wxhash, wxkey, strlen(wxkey), nsv, 0 );

    sv_rvweaken( nsv );
}

void wxPli_thread_sv_unregister( pTHX_ const char* package,
                                 const void* ptr, SV* sv )
{
    if( !ptr )
        return;

    dwxHash( package, 0 );
    if( !wxhash )
      return;
    dwxKey( ptr );

    hv_delete( wxhash, wxkey, strlen(wxkey), 0 );   
}

void wxPli_thread_sv_clone( pTHX_ const char* package, wxPliCloneSV clonefn )
{
    dwxHash( package, 0 );
    if( !wxhash )
      return;

    hv_iterinit( wxhash );
    HE* he;
    while( ( he = hv_iternext( wxhash ) ) != NULL ) {
        SV* val = hv_iterval( wxhash, he );
        clonefn( aTHX_ val );

        // hack around Scalar::Util::weaken() producing warnings
        if( MAGIC* magic = mg_find( SvRV( val ), '<' ) )
        {
            SvREFCNT_inc( magic->mg_obj );
            mg_free( SvRV( val ) );
        }
    }

    hv_undef( wxhash );
}

#endif // wxPERL_USE_THREADS

// helpers for declaring event macros
#include "cpp/e_cback.h"

// THIS, function
XS(Connect2);
XS(Connect2)
{
    dXSARGS;
    assert( items == 2 );
    SV* THISs = ST(0);
    wxEvtHandler *THISo =
        (wxEvtHandler*)wxPli_sv_2_object( aTHX_ THISs, "Wx::EvtHandler" );
    SV* func = ST(1);
    I32 evtID = CvXSUBANY(cv).any_i32;

    if( SvOK( func ) )
    {

        THISo->Connect( wxID_ANY, wxID_ANY, evtID,
                        wxPliCastEvtHandler( &wxPliEventCallback::Handler ),
                        new wxPliEventCallback( func, THISs ) );
    }
    else
    {
        THISo->Disconnect( wxID_ANY, wxID_ANY, evtID,
                           wxPliCastEvtHandler( &wxPliEventCallback::Handler ),
                           0 );
    }
}

// THIS, ID, function
XS(Connect3);
XS(Connect3)
{
    dXSARGS;
    assert( items == 3 );
    SV* THISs = ST(0);
    wxEvtHandler *THISo =
        (wxEvtHandler*)wxPli_sv_2_object( aTHX_ THISs, "Wx::EvtHandler" );
    wxWindowID id = wxPli_get_wxwindowid( aTHX_ ST(1) );
    SV* func = ST(2);
    I32 evtID = CvXSUBANY(cv).any_i32;

    if( SvOK( func ) )
    {
        THISo->Connect( id, wxID_ANY, evtID,
                        wxPliCastEvtHandler( &wxPliEventCallback::Handler ),
                        new wxPliEventCallback( func, THISs ) );
    }
    else
    {
        THISo->Disconnect( id, wxID_ANY, evtID,
                           wxPliCastEvtHandler( &wxPliEventCallback::Handler ),
                           0 );
    }
}

// THIS, ID, wxEventId, function
XS(Connect4);
XS(Connect4)
{
    dXSARGS;
    assert( items == 4 );
    SV* THISs = ST(0);
    wxEvtHandler *THISo =
        (wxEvtHandler*)wxPli_sv_2_object( aTHX_ THISs, "Wx::EvtHandler" );
    wxWindowID id = wxPli_get_wxwindowid( aTHX_ ST(1) );
    wxEventType evtID = SvIV( ST(2) );
    SV* func = ST(3);

    if( SvOK( func ) )
    {
        THISo->Connect( id, wxID_ANY, evtID,
                        wxPliCastEvtHandler( &wxPliEventCallback::Handler ),
                        new wxPliEventCallback( func, THISs ) );
    }
    else
    {
        THISo->Disconnect( id, wxID_ANY, evtID,
                           wxPliCastEvtHandler( &wxPliEventCallback::Handler ),
                           0 );
    }
}

void CreateEventMacro( const char* name, unsigned char args, int id )
{
    char buffer[1024];
    CV* cv;
    dTHX;

    strcpy( buffer, "Wx::Event::" );
    strcat( buffer, name );

    switch( args )
    {
    case 2:
        cv = (CV*)newXS( buffer, Connect2, "Constants.xs" );
        sv_setpv((SV*)cv, "$$");
        break;
    case 3:
        cv = (CV*)newXS( buffer, Connect3, "Constants.xs" );
        sv_setpv((SV*)cv, "$$$");
        break;
    case 4:
        cv = (CV*)newXS( buffer, Connect4, "Constants.xs" );
        sv_setpv((SV*)cv, "$$$$");
        break;
    default:
        return;
    }

    CvXSUBANY(cv).any_i32 = id;
}

void wxPli_set_events( const struct wxPliEventDescription* events )
{
    for( size_t i = 0; events[i].name != 0; ++i )
        CreateEventMacro( events[i].name, events[i].args, events[i].evtID );
}

// Local variables: //
// mode: c++ //
// End: //
