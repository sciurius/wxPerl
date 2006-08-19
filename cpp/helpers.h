/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/helpers.h
// Purpose:     some helper functions/classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: helpers.h,v 1.82 2006/08/19 18:24:34 mbarbon Exp $
// Copyright:   (c) 2000-2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef __CPP_HELPERS_H
#define __CPP_HELPERS_H

#include <wx/object.h>
#include <wx/list.h>
#include <wx/gdicmn.h>

#include <wx/dynarray.h>
#include <wx/arrstr.h>

class wxPliUserDataCD;
class wxPliTreeItemData;

// forward declare Wx_*Stream
class WXDLLEXPORT wxInputStream;
class WXDLLEXPORT wxOutputStream;
class WXDLLEXPORT wxEvtHandler;
class WXDLLEXPORT wxClientDataContainer;
typedef wxInputStream Wx_InputStream;
typedef wxOutputStream Wx_OutputStream;
typedef const char* PlClassName; // for typemap

#include <stdarg.h>

I32 my_looks_like_number( pTHX_ SV* sv );

// helpers for UTF8 <-> wxString/wxChar
// because xsubpp does not allow preprocessor commands in typemaps

SV* wxPli_wxChar_2_sv( pTHX_ const wxChar* str, SV* out );
SV* wxPli_wxString_2_sv( pTHX_ const wxString& str, SV* out );

#if wxUSE_UNICODE

inline SV* wxPli_wxChar_2_sv( pTHX_ const wxChar* str, SV* out )
{
    sv_setpv( out, wxConvUTF8.cWC2MB( str ? str : wxEmptyString ) );
    SvUTF8_on( out );

    return out;
}

inline SV* wxPli_wxString_2_sv( pTHX_ const wxString& str, SV* out )
{
    sv_setpv( out, str.mb_str( wxConvUTF8 ) );
    SvUTF8_on( out );

    return out;
}

#define WXCHAR_INPUT( var, type, arg ) \
  const wxString var##_tmp = ( SvUTF8( arg ) ) ? \
            ( wxString( SvPVutf8_nolen( arg ), wxConvUTF8 ) ) \
          : ( wxString( SvPV_nolen( arg ), wxConvLibc ) ); \
  var = (type)var##_tmp.c_str();

#define WXCHAR_OUTPUT( var, arg ) \
  wxPli_wxChar_2_sv( aTHX_ var, arg )

#define WXSTRING_INPUT( var, type, arg ) \
  var =  ( SvUTF8( arg ) ) ? \
           wxString( SvPVutf8_nolen( arg ), wxConvUTF8 ) \
         : wxString( SvPV_nolen( arg ), wxConvLibc );

#define WXSTRING_OUTPUT( var, arg ) \
  wxPli_wxString_2_sv( aTHX_ var, arg )

#else

inline SV* wxPli_wxChar_2_sv( pTHX_ const wxChar* str, SV* out )
{
    sv_setpv( out, str );
    return out;
}

inline SV* wxPli_wxString_2_sv( pTHX_ const wxString& str, SV* out )
{
    sv_setpvn( out, str.c_str(), str.size() );
    return out;
}

#define WXCHAR_INPUT( var, type, arg ) \
  const wxString var##_tmp = ( SvUTF8( arg ) ) ? \
            ( wxString( wxConvUTF8.cMB2WC( SvPVutf8_nolen( arg ) ), wxConvLocal ) ) \
          : ( wxString( SvPV_nolen( arg ) ) ); \
  var = (type)var##_tmp.c_str();

#define WXCHAR_OUTPUT( var, arg ) \
  wxPli_wxChar_2_sv( aTHX_ var, arg )

#define WXSTRING_INPUT( var, type, arg ) \
  var =  ( SvUTF8( arg ) ) ? \
           wxString( wxConvUTF8.cMB2WC( SvPVutf8_nolen( arg ) ), wxConvLocal ) \
         : wxString( SvPV_nolen( arg ) );

#define WXSTRING_OUTPUT( var, arg ) \
  wxPli_wxString_2_sv( aTHX_ var, arg )

#endif

// some utility functions

inline AV* wxPli_avref_2_av( SV* sv )
{
    if( SvROK( sv ) )
    {
        SV* rv = SvRV( sv );
        return SvTYPE( rv ) == SVt_PVAV ? (AV*)rv : NULL;
    }

    return NULL;
}

//

const int WXPL_BUF_SIZE = 120;
const char* FUNCPTR( wxPli_cpp_class_2_perl )( const wxChar* className,
                                               char buffer[WXPL_BUF_SIZE] );
// argtypes is a string; each character describes the C++ argument
// type and how it should be used (i.e. a valid string is "ii", assuming
// you pass two integers as additional parameters
// b - a boolean value
// i - an 'int' value
// l - a 'long' value
// L - an 'unsigned long' value
// d - a 'double' value
// p - a char*
// w - a wxChar*
// P - a wxString*
// S - an SV*; a _COPY_ of the SV is passed
// s - an SV*; _the SV_ is passed (any modifications made by the function
//             will affect the SV, unlike in the previous case)
// O - a wxObject*; this will use wxPli_object_2_sv and push the result
// o - a void* followed by a char*; will use wxPli_non_object_2_sv
//     and push the result
void FUNCPTR( wxPli_push_arguments )( pTHX_ SV*** stack,
                                      const char* argtypes, ... );
void wxPli_push_args( pTHX_ SV*** stack, const char* argtypes, va_list &list );

void* FUNCPTR( wxPli_sv_2_object )( pTHX_ SV* scalar, const char* classname );
SV* FUNCPTR( wxPli_object_2_sv )( pTHX_ SV* var, wxObject* object );
SV* FUNCPTR( wxPli_clientdatacontainer_2_sv )( pTHX_ SV* var,
                                               wxClientDataContainer* cdc,
                                               const char* klass );
SV* FUNCPTR( wxPli_evthandler_2_sv )( pTHX_ SV* var, wxEvtHandler* evth );
SV* FUNCPTR( wxPli_non_object_2_sv )( pTHX_ SV* var, void* data,
                                      const char* package );

SV* FUNCPTR( wxPli_make_object )( void* object, const char* cname );
SV* FUNCPTR( wxPli_create_evthandler )( pTHX_ wxEvtHandler* object,
                                        const char* classn );

bool FUNCPTR( wxPli_object_is_deleteable )( pTHX_ SV* object );
void FUNCPTR( wxPli_object_set_deleteable )( pTHX_ SV* object,
                                             bool deleteable );
// in both attach and detach, object is a _reference_ to a
// blessed thing
void FUNCPTR( wxPli_attach_object )( pTHX_ SV* object, void* ptr );
void* FUNCPTR( wxPli_detach_object )( pTHX_ SV* object );

const char* FUNCPTR( wxPli_get_class )( pTHX_ SV* ref );

wxWindowID FUNCPTR( wxPli_get_wxwindowid )( pTHX_ SV* var );
int FUNCPTR( wxPli_av_2_stringarray )( pTHX_ SV* avref, wxString** array );
int wxPli_av_2_charparray( pTHX_ SV* avref, char*** array );
int wxPli_av_2_wxcharparray( pTHX_ SV* avref, wxChar*** array );
int wxPli_av_2_uchararray( pTHX_ SV* avref, unsigned char** array );
int wxPli_av_2_svarray( pTHX_ SV* avref, SV*** array );
int FUNCPTR( wxPli_av_2_intarray )( pTHX_ SV* avref, int** array );
int wxPli_av_2_userdatacdarray( pTHX_ SV* avref, wxPliUserDataCD*** array );
int wxPli_av_2_arraystring( pTHX_ SV* avref, wxArrayString* array );

// pushes the elements of the array into the stack
// the caller _MUST_ call PUTBACK; before the function
// and SPAGAIN; after the function
void wxPli_stringarray_push( pTHX_ const wxArrayString& strings );
void FUNCPTR( wxPli_intarray_push )( pTHX_ const wxArrayInt& ints );
AV* wxPli_stringarray_2_av( pTHX_ const wxArrayString& strings );
AV* wxPli_uchararray_2_av( pTHX_ const unsigned char* array, int count );
AV* FUNCPTR( wxPli_objlist_2_av )( pTHX_ const wxList& objs );

template<class A, class E>
void wxPli_nonobjarray_push( pTHX_ const A& objs, const char* klass )
{
    dSP;

    size_t mx = objs.GetCount();
    EXTEND( SP, IV(mx) );
    for( size_t i = 0; i < mx; ++i )
    {
        PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
               new E( objs[i] ), klass ) );
    }

    PUTBACK;
}


void wxPli_delete_argv( void*** argv, bool unicode );
int wxPli_get_args_argc_argv( void*** argv, bool unicode );
void wxPli_get_args_objectarray( pTHX_ SV** sp, int items,
                                         void** array, const char* package );

wxPoint FUNCPTR( wxPli_sv_2_wxpoint_test )( pTHX_ SV* scalar, bool* ispoint );
wxPoint FUNCPTR( wxPli_sv_2_wxpoint )( pTHX_ SV* scalar );
wxSize FUNCPTR( wxPli_sv_2_wxsize )( pTHX_ SV* scalar );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
class WXDLLEXPORT wxGBPosition; class WXDLLEXPORT wxGBSpan;
wxGBPosition wxPli_sv_2_wxgbposition( pTHX_ SV* scalar );
wxGBSpan wxPli_sv_2_wxgbspan( pTHX_ SV* scalar );
#endif
wxKeyCode wxPli_sv_2_keycode( pTHX_ SV* scalar );

int wxPli_av_2_pointlist( pTHX_ SV* array, wxList *points, wxPoint** tmp );
int wxPli_av_2_pointarray( pTHX_ SV* array, wxPoint** points );

// thread helpers
#if wxPERL_USE_THREADS
typedef void (* wxPliCloneSV)( pTHX_ SV* scalar );
void FUNCPTR( wxPli_thread_sv_register )( pTHX_ const char* package,
                                          void* ptr, SV* sv );
void FUNCPTR( wxPli_thread_sv_unregister )( pTHX_ const char* package,
                                            void* ptr, SV* sv );
void FUNCPTR( wxPli_thread_sv_clone )( pTHX_ const char* package,
                                       wxPliCloneSV clonefn );
#else // if !wxPERL_USE_THREADS
#define wxPli_thread_sv_register( package, ptr, sv )
#define wxPli_thread_sv_unregister( package, ptr, sv )
#define wxPli_thread_sv_clone( package, clonefn )
#endif // !wxPERL_USE_THREADS

// stream wrappers
class wxPliInputStream;
class wxPliOutputStream;
class wxStreamBase;

void wxPli_sv_2_istream( pTHX_ SV* scalar, wxPliInputStream& stream );
void wxPli_sv_2_ostream( pTHX_ SV* scalar, wxPliOutputStream& stream );
void FUNCPTR( wxPli_stream_2_sv )( pTHX_ SV* scalar, wxStreamBase* stream,
                                   const char* package );
wxPliInputStream* FUNCPTR( wxPliInputStream_ctor )( SV* sv );

// defined in Constants.xs
void FUNCPTR( wxPli_add_constant_function )( double (**)( const char*, int ) );
void FUNCPTR( wxPli_remove_constant_function )( double (**)( const char*,
                                                             int ) );

// defined in v_cback.cpp
class wxPliVirtualCallback;

bool FUNCPTR( wxPliVirtualCallback_FindCallback )
    ( pTHX_ const wxPliVirtualCallback* cb, const char* name );
// see wxPli_push_args for a description of argtypes
SV* FUNCPTR( wxPliVirtualCallback_CallCallback )
    ( pTHX_ const wxPliVirtualCallback* cb, I32 flags,
      const char* argtypes, ... );

// defined in overload.cpp
struct wxPliPrototype
{
    const char** tnames;
    const unsigned char* args;
    const size_t count;
};

bool wxPli_match_arguments( pTHX_ const wxPliPrototype& prototype,
                            int required = -1,
                            bool allow_more = false );
bool FUNCPTR( wxPli_match_arguments_skipfirst )( pTHX_ const wxPliPrototype& p,
                                                 int required,
                                                 bool allow_more );

#define WXPLI_BOOT_ONCE_( name, xs ) \
bool name##_booted = false; \
extern "C" XS(wxPli_boot_##name); \
extern "C" \
xs(boot_##name) \
{ \
    if( name##_booted ) return; \
    name##_booted = true; \
    wxPli_boot_##name( aTHX_ cv ); \
}

#define WXPLI_BOOT_ONCE( name ) WXPLI_BOOT_ONCE_( name, XS )
#if defined(WIN32) || defined(__CYGWIN__)
#  define WXPLI_BOOT_ONCE_EXP( name ) WXPLI_BOOT_ONCE_( name, WXXS )
#else
#  define WXPLI_BOOT_ONCE_EXP WXPLI_BOOT_ONCE
#endif

#if WXPERL_W_VERSION_GE( 2, 5, 1 )
#define WXPLI_INIT_CLASSINFO()
#else
#define WXPLI_INIT_CLASSINFO() \
  wxClassInfo::CleanUpClasses(); \
  wxClassInfo::InitializeClasses()
#endif

struct wxPliHelpers
{
    void* ( * m_wxPli_sv_2_object )( pTHX_ SV*, const char* );
    SV* ( * m_wxPli_evthandler_2_sv )( pTHX_ SV* var, wxEvtHandler* evth );
    SV* ( * m_wxPli_object_2_sv )( pTHX_ SV*, wxObject* );
    SV* ( * m_wxPli_non_object_2_sv )( pTHX_ SV* , void*, const char* );
    SV* ( * m_wxPli_make_object )( void*, const char* );
    wxPoint ( * m_wxPli_sv_2_wxpoint_test )( pTHX_ SV*, bool* );
    wxPoint ( * m_wxPli_sv_2_wxpoint )( pTHX_ SV* );
    wxSize ( * m_wxPli_sv_2_wxsize )( pTHX_ SV* );
    int ( * m_wxPli_av_2_intarray )( pTHX_ SV*, int** );
    void ( * m_wxPli_stream_2_sv )( pTHX_ SV*, wxStreamBase*, const char* );

    void ( * m_wxPli_add_constant_function )
        ( double (**)( const char*, int ) );
    void ( * m_wxPli_remove_constant_function )
        ( double (**)( const char*, int ) );

    bool ( * m_wxPliVirtualCallback_FindCallback )( pTHX_ 
                                                   const wxPliVirtualCallback*,
                                                    const char* );
    SV* ( * m_wxPliVirtualCallback_CallCallback )
        ( pTHX_ const wxPliVirtualCallback*, I32,
          const char*, ... );
    bool ( * m_wxPli_object_is_deleteable )( pTHX_ SV* );
    void ( * m_wxPli_object_set_deleteable )( pTHX_ SV*, bool );
    const char* ( * m_wxPli_get_class )( pTHX_ SV* );
    wxWindowID ( * m_wxPli_get_wxwindowid )( pTHX_ SV* );
    int ( * m_wxPli_av_2_stringarray )( pTHX_ SV*, wxString** );
    wxPliInputStream* ( * m_wxPliInputStream_ctor )( SV* );
    const char* ( * m_wxPli_cpp_class_2_perl )( const wxChar*,
                                                char buffer[WXPL_BUF_SIZE] );
    void ( * m_wxPli_push_arguments )( pTHX_ SV*** stack,
                                       const char* argtypes, ... );
    void ( * m_wxPli_attach_object )( pTHX_ SV* object, void* ptr );
    void* ( * m_wxPli_detach_object )( pTHX_ SV* object );
    SV* ( * m_wxPli_create_evthandler )( pTHX_ wxEvtHandler* object,
                                         const char* cln );
    bool (* m_wxPli_match_arguments_skipfirst )( pTHX_ const wxPliPrototype&,
                                                 int required,
                                                 bool allow_more );
    AV* (* m_wxPli_objlist_2_av )( pTHX_ const wxList& objs );
    void (* m_wxPli_intarray_push )( pTHX_ const wxArrayInt& );
    SV* (* m_wxPli_clientdatacontainer_2_sv )( pTHX_ SV* var,
                                               wxClientDataContainer* cdc,
                                               const char* klass );
#if wxPERL_USE_THREADS
    void (* m_wxPli_thread_sv_register )( pTHX_ const char* package,
                                          void* ptr, SV* sv );
    void (* m_wxPli_thread_sv_unregister )( pTHX_ const char* package,
                                            void* ptr, SV* sv );
    void (* m_wxPli_thread_sv_clone )( pTHX_ const char* package,
                                       wxPliCloneSV clonefn );
#endif
};

#if wxPERL_USE_THREADS
#   define wxDEFINE_PLI_HELPER_THREADS() \
 &wxPli_thread_sv_register, \
 &wxPli_thread_sv_unregister, &wxPli_thread_sv_clone,
#   define wxINIT_PLI_HELPER_THREADS( name ) \
  wxPli_thread_sv_register = name->m_wxPli_thread_sv_register; \
  wxPli_thread_sv_unregister = name->m_wxPli_thread_sv_unregister; \
  wxPli_thread_sv_clone = name->m_wxPli_thread_sv_clone
#else
#   define wxDEFINE_PLI_HELPER_THREADS()
#   define wxINIT_PLI_HELPER_THREADS( name )
#endif

#define DEFINE_PLI_HELPERS( name ) \
wxPliHelpers name = { &wxPli_sv_2_object, \
 &wxPli_evthandler_2_sv, &wxPli_object_2_sv, \
 &wxPli_non_object_2_sv, &wxPli_make_object, &wxPli_sv_2_wxpoint_test, \
 &wxPli_sv_2_wxpoint, \
 &wxPli_sv_2_wxsize, &wxPli_av_2_intarray, wxPli_stream_2_sv, \
 &wxPli_add_constant_function, &wxPli_remove_constant_function, \
 &wxPliVirtualCallback_FindCallback, &wxPliVirtualCallback_CallCallback, \
 &wxPli_object_is_deleteable, &wxPli_object_set_deleteable, &wxPli_get_class, \
 &wxPli_get_wxwindowid, &wxPli_av_2_stringarray, &wxPliInputStream_ctor, \
 &wxPli_cpp_class_2_perl, &wxPli_push_arguments, &wxPli_attach_object, \
 &wxPli_detach_object, &wxPli_create_evthandler, \
 &wxPli_match_arguments_skipfirst, &wxPli_objlist_2_av, &wxPli_intarray_push, \
 &wxPli_clientdatacontainer_2_sv, \
 wxDEFINE_PLI_HELPER_THREADS() \
 }

#if defined( WXPL_EXT ) && !defined( WXPL_STATIC ) && !defined(__WXMAC__)

#define INIT_PLI_HELPERS( name ) \
  SV* wxpli_tmp = get_sv( "Wx::_exports", 1 ); \
  wxPliHelpers* name = INT2PTR( wxPliHelpers*, SvIV( wxpli_tmp ) ); \
  wxPli_sv_2_object = name->m_wxPli_sv_2_object; \
  wxPli_evthandler_2_sv = name->m_wxPli_evthandler_2_sv; \
  wxPli_object_2_sv = name->m_wxPli_object_2_sv; \
  wxPli_non_object_2_sv = name->m_wxPli_non_object_2_sv; \
  wxPli_make_object = name->m_wxPli_make_object; \
  wxPli_sv_2_wxpoint_test = name->m_wxPli_sv_2_wxpoint_test; \
  wxPli_sv_2_wxpoint = name->m_wxPli_sv_2_wxpoint; \
  wxPli_sv_2_wxsize = name->m_wxPli_sv_2_wxsize; \
  wxPli_av_2_intarray = name->m_wxPli_av_2_intarray; \
  wxPli_stream_2_sv = name->m_wxPli_stream_2_sv; \
  wxPli_add_constant_function = name->m_wxPli_add_constant_function; \
  wxPli_remove_constant_function = name->m_wxPli_remove_constant_function; \
  wxPliVirtualCallback_FindCallback = name->m_wxPliVirtualCallback_FindCallback; \
  wxPliVirtualCallback_CallCallback = name->m_wxPliVirtualCallback_CallCallback; \
  wxPli_object_is_deleteable = name->m_wxPli_object_is_deleteable; \
  wxPli_object_set_deleteable = name->m_wxPli_object_set_deleteable; \
  wxPli_get_class = name->m_wxPli_get_class; \
  wxPli_get_wxwindowid = name->m_wxPli_get_wxwindowid; \
  wxPli_av_2_stringarray = name->m_wxPli_av_2_stringarray; \
  wxPliInputStream_ctor = name->m_wxPliInputStream_ctor; \
  wxPli_cpp_class_2_perl = name->m_wxPli_cpp_class_2_perl; \
  wxPli_push_arguments = name->m_wxPli_push_arguments; \
  wxPli_attach_object = name->m_wxPli_attach_object; \
  wxPli_detach_object = name->m_wxPli_detach_object; \
  wxPli_create_evthandler = name->m_wxPli_create_evthandler; \
  wxPli_match_arguments_skipfirst = name->m_wxPli_match_arguments_skipfirst; \
  wxPli_objlist_2_av = name->m_wxPli_objlist_2_av; \
  wxPli_intarray_push = name->m_wxPli_intarray_push; \
  wxPli_clientdatacontainer_2_sv = name->m_wxPli_clientdatacontainer_2_sv; \
  wxINIT_PLI_HELPER_THREADS( name ); \
  \
  WXPLI_INIT_CLASSINFO();

#else

#define INIT_PLI_HELPERS( name )

#endif

int wxCALLBACK ListCtrlCompareFn( long item1, long item2, long comparefn );

class wxPliUserDataO : public wxObject
{
public:
    wxPliUserDataO( SV* data )
    {
        dTHX;
        m_data = data ? newSVsv( data ) : NULL;
    }

    ~wxPliUserDataO()
    {
        dTHX;
        SvREFCNT_dec( m_data );
    }

    SV* GetData() { return m_data; }
private:
    SV* m_data;
};
typedef wxPliUserDataO   Wx_UserDataO;

class wxPliSelfRef
{
public:
    wxPliSelfRef( const char* unused = 0 ) {}
    virtual ~wxPliSelfRef()
        { dTHX; if( m_self ) SvREFCNT_dec( m_self ); }

    void SetSelf( SV* self, bool increment = true )
    {
        dTHX;
        m_self = self;
        if( increment )       
            SvREFCNT_inc( m_self );
    }

    SV* GetSelf() { return m_self; }
public:
    SV* m_self;
};

typedef wxPliSelfRef* (* wxPliGetCallbackObjectFn)(wxObject* object);

class wxPliClassInfo : public wxClassInfo
{
public:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    wxPliClassInfo( wxChar *cName, const wxClassInfo *baseInfo1,
                    const wxClassInfo *baseInfo2, 
                    int sz, wxPliGetCallbackObjectFn fn )
        :wxClassInfo( cName, baseInfo1, baseInfo2, sz, 0)
    {
        m_func = fn;
    }
#else
    wxPliClassInfo( wxChar *cName, wxChar *baseName1, wxChar *baseName2, 
                    int sz, wxPliGetCallbackObjectFn fn )
        :wxClassInfo( cName, baseName1, baseName2, sz, 0)
        {
            m_func = fn;
            //FIXME//
            m_baseInfo1 = wxClassInfo::FindClass( baseName1 );
            //FIXME// this is an ugly hack!
#if 0 && !defined( __WXMAC__ )
            if( m_baseInfo1 == 0 )
                croak( "ClassInfo initialization failed '%s'", baseName1 );
#endif
        }
#endif
public:
    wxPliGetCallbackObjectFn m_func;
};

#if WXPERL_W_VERSION_GE( 2, 5, 1 )
#define WXPLI_DECLARE_DYNAMIC_CLASS(name) \
public:\
  static wxPliClassInfo ms_classInfo;\
  virtual wxClassInfo *GetClassInfo() const \
   { return &ms_classInfo; }
#else
#define WXPLI_DECLARE_DYNAMIC_CLASS(name) \
public:\
  static wxPliClassInfo sm_class##name;\
  virtual wxClassInfo *GetClassInfo() const \
   { return &sm_class##name; }
#endif

#define WXPLI_DECLARE_SELFREF() \
public:\
  wxPliSelfRef m_callback

#define WXPLI_DECLARE_V_CBACK() \
public:\
  wxPliVirtualCallback m_callback

#if WXPERL_W_VERSION_GE( 2, 5, 1 )
#define WXPLI_IMPLEMENT_DYNAMIC_CLASS(name, basename)                        \
    wxPliSelfRef* wxPliGetSelfFor##name(wxObject* object)                    \
        { return &((name *)object)->m_callback; }                            \
    wxPliClassInfo name::ms_classInfo((wxChar *) wxT(#name),                 \
        &basename::ms_classInfo, NULL, (int) sizeof(name),                   \
        (wxPliGetCallbackObjectFn) wxPliGetSelfFor##name);
#else
#define WXPLI_IMPLEMENT_DYNAMIC_CLASS(name, basename) \
wxPliSelfRef* wxPliGetSelfFor##name(wxObject* object) \
  { return &((name *)object)->m_callback; }\
wxPliClassInfo name::sm_class##name((wxChar *) wxT(#name), \
  (wxChar *) wxT(#basename), (wxChar *) NULL, (int) sizeof(name), \
  (wxPliGetCallbackObjectFn) wxPliGetSelfFor##name);
#endif

#define WXPLI_DEFAULT_CONSTRUCTOR_NC( name, packagename, incref ) \
    name( const char* package )                                   \
        : m_callback( packagename )                               \
    {                                                             \
        m_callback.SetSelf( wxPli_make_object( this, package ), incref );\
    }

#define WXPLI_DEFAULT_CONSTRUCTOR( name, packagename, incref ) \
    name( const char* package )                                \
        :m_callback( packagename )                             \
    {                                                          \
        m_callback.SetSelf( wxPli_make_object( this, package ), incref );\
    }

#define WXPLI_CONSTRUCTOR_1_NC( name, base, packagename, incref, argt1 ) \
    name( const char* package, argt1 _arg1 )                       \
        : base( _arg1 ),                                           \
          m_callback( packagename )                                \
    {                                                              \
        m_callback.SetSelf( wxPli_make_object( this, package ), incref );\
    }

#define WXPLI_CONSTRUCTOR_2( name, packagename, incref, argt1, argt2 )     \
     name( const char* package, argt1 _arg1, argt2 _arg2 )                 \
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2 );                                           \
     }

#define WXPLI_CONSTRUCTOR_5( name, packagename, incref, argt1, argt2, argt3, argt4, argt5 ) \
     name( const char* package, argt1 _arg1, argt2 _arg2, argt3 _arg3,     \
           argt4 _arg4, argt5 _arg5 )                                      \
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2, _arg3, _arg4, _arg5 );                      \
     }

#define WXPLI_CONSTRUCTOR_6( name, packagename, incref, argt1, argt2, argt3, argt4, argt5, argt6 ) \
     name( const char* package, argt1 _arg1, argt2 _arg2, argt3 _arg3,     \
           argt4 _arg4, argt5 _arg5, argt6 _arg6 )                          \
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6 );               \
     }

#define WXPLI_CONSTRUCTOR_7( name, packagename, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7 ) \
     name( const char* package, argt1 _arg1, argt2 _arg2, argt3 _arg3,     \
           argt4 _arg4, argt5 _arg5, argt6 _arg6, argt7 _arg7)             \
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7 );        \
     }

#define WXPLI_CONSTRUCTOR_8( name, packagename, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8 ) \
     name( const char* package, argt1 _arg1, argt2 _arg2, argt3 _arg3,     \
           argt4 _arg4, argt5 _arg5, argt6 _arg6, argt7 _arg7, argt8 _arg8)\
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7, _arg8 ); \
     }

#define WXPLI_CONSTRUCTOR_9( name, packagename, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8, argt9 ) \
     name( const char* package, argt1 _arg1, argt2 _arg2, argt3 _arg3,     \
           argt4 _arg4, argt5 _arg5, argt6 _arg6, argt7 _arg7,             \
           argt8 _arg8, argt9 _arg9 )                                      \
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7, _arg8,   \
                 _arg9 );                                                  \
     }

#define WXPLI_CONSTRUCTOR_10( name, packagename, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8, argt9, argt10 ) \
     name( const char* package, argt1 _arg1, argt2 _arg2, argt3 _arg3,     \
           argt4 _arg4, argt5 _arg5, argt6 _arg6, argt7 _arg7,             \
           argt8 _arg8, argt9 _arg9, argt10 _arg10 )                       \
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7, _arg8,   \
                 _arg9, _arg10 );                                          \
     }

#define WXPLI_CONSTRUCTOR_11( name, packagename, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8, argt9, argt10, argt11 ) \
     name( const char* package, argt1 _arg1, argt2 _arg2, argt3 _arg3,     \
           argt4 _arg4, argt5 _arg5, argt6 _arg6, argt7 _arg7,             \
           argt8 _arg8, argt9 _arg9, argt10 _arg10, argt11 _arg11 )        \
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7, _arg8,   \
                 _arg9, _arg10, _arg11 );                                  \
     }

#define WXPLI_DECLARE_CLASS_6( name, incref, argt1, argt2, argt3, argt4, argt5, argt6 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, "Wx::" #name, incref );     \
    WXPLI_CONSTRUCTOR_6( wxPli##name, "Wx::" #name, incref,             \
                         argt1, argt2, argt3, argt4, argt5, argt6 );    \
};

#define WXPLI_DECLARE_CLASS_7( name, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, "Wx::" #name, incref );     \
    WXPLI_CONSTRUCTOR_7( wxPli##name, "Wx::" #name, incref,             \
                         argt1, argt2, argt3, argt4, argt5, argt6,      \
                         argt7 );                                       \
};

#define WXPLI_DECLARE_CLASS_8( name, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, "Wx::" #name, incref );     \
    WXPLI_CONSTRUCTOR_8( wxPli##name, "Wx::" #name, incref,             \
                         argt1, argt2, argt3, argt4, argt5, argt6,      \
                         argt7, argt8 );                                \
};

#define WXPLI_DECLARE_CLASS_9( name, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8, argt9 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, "Wx::" #name, incref );     \
    WXPLI_CONSTRUCTOR_9( wxPli##name, "Wx::" #name, incref,             \
                         argt1, argt2, argt3, argt4, argt5, argt6,      \
                         argt7, argt8, argt9 );                         \
};

#define WXPLI_DECLARE_CLASS_10( name, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8, argt9, argt10 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, "Wx::" #name, incref );     \
    WXPLI_CONSTRUCTOR_10( wxPli##name, "Wx::" #name, incref,            \
                         argt1, argt2, argt3, argt4, argt5, argt6,      \
                         argt7, argt8, argt9, argt10 );                 \
};


#define WXPLI_DEFINE_CLASS( name ) \
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPli##name, wx##name );

typedef SV SV_null; // equal to SV except that maps C++ 0 <-> Perl undef

#endif // __CPP_HELPERS_H

#if defined( _WX_CLNTDATAH__ )
#ifndef __CPP_HELPERS_H_UDCD
#define __CPP_HELPERS_H_UDCD

class wxPliUserDataCD : public wxClientData
{
public:
    wxPliUserDataCD( SV* data )
    {
        dTHX;
        m_data = data ? newSVsv( data ) : NULL;
    }

    ~wxPliUserDataCD()
    {
        dTHX;
        SvREFCNT_dec( m_data );
    }

    SV* GetData() { return m_data; }
private:
    SV* m_data;
};
typedef wxPliUserDataCD  Wx_UserDataCD;

#endif // __CPP_HELPERS_H_UDCD
#endif

#if defined( _WX_TREEBASE_H_ ) || defined( _WX_TREECTRL_H_BASE_ )
#ifndef __CPP_HELPERS_H_TID
#define __CPP_HELPERS_H_TID

class wxPliTreeItemData:public wxTreeItemData
{
public:
    wxPliTreeItemData( SV* data )
        : m_data( NULL )
    {
        SetData( data );
    }

    ~wxPliTreeItemData()
    {
        SetData( NULL );
    }

    void SetData( SV* data )
    {
        dTHX;
        if( m_data )
            SvREFCNT_dec( m_data );
        m_data = data ? newSVsv( data ) : NULL;
    }
public:
    SV* m_data;
};

#endif // __CPP_HELPERS_H_TID
#endif

// Local variables:
// mode: c++
// End:
