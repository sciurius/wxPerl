/////////////////////////////////////////////////////////////////////////////
// Name:        helpers.h
// Purpose:     some helper functions/classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/object.h>
#include <wx/list.h>
#include <wx/gdicmn.h>

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
         : wxString( SvPV_nolen( arg ) );

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
  var = (type)SvPV_nolen(arg)

#define WXCHAR_OUTPUT( var, arg ) \
  wxPli_wxChar_2_sv( aTHX_ var, arg )

#define WXSTRING_INPUT( var, type, arg ) \
  var = (type)SvPV_nolen(arg)

#define WXSTRING_OUTPUT( var, arg ) \
  wxPli_wxString_2_sv( aTHX_ var, arg )

#endif

// some utility functions

inline AV* wxPli_avref_2_av( SV* sv )
{
    if( SvROK( sv ) )
    {
        SV* rv = SvRV( sv );
        return SvTYPE( rv ) == SVt_PVAV ? (AV*)rv : (AV*)0;
    }

    return (AV*)0;
}

//

const int WXPL_BUF_SIZE = 120;
WXPLDLL const char* FUNCPTR( wxPli_cpp_class_2_perl )( const wxChar* className,
                                              char buffer[WXPL_BUF_SIZE] );
// argtypes is a string; each character describes the C++ argument
// type and how it should be used (i.e. a valid string is "ii", assuming
// you pass two integers as additional parameters
// b - a boolean value
// i - an 'int' value
// l - a 'long' value
// p - a char*
// w - a wxChar*
// P - a wxString*
// S - an SV*; a _COPY_ of the SV is passed
// s - an SV*; _the SV_ is passed (any modifications made by the function
//             will affect the SV, unlike in the previous case)
// O - a wxObject*; this will use wxPli_object_2_sv and push the result
// o - a void* followed by a char*; will use wxPli_non_object_2_sv
//     and push the result
WXPLDLL void wxPli_push_args( pTHX_ SV*** stack, const char* argtypes,
                              va_list &list );

WXPLDLL void* FUNCPTR( wxPli_sv_2_object )( pTHX_ SV* scalar,
                                            const char* classname );
WXPLDLL SV* FUNCPTR( wxPli_object_2_sv )( pTHX_ SV* var, wxObject* object );
WXPLDLL SV* FUNCPTR( wxPli_non_object_2_sv )( pTHX_ SV* var, void* data,
                                              const char* package );

WXPLDLL SV* FUNCPTR( wxPli_make_object )( void* object, const char* cname );

WXPLDLL bool FUNCPTR( wxPli_object_is_deleteable )( pTHX_ SV* object );
WXPLDLL void FUNCPTR( wxPli_object_set_deleteable )( pTHX_ SV* object,
                                                     bool deleteable );

WXPLDLL const char* FUNCPTR( wxPli_get_class )( pTHX_ SV* ref );

WXPLDLL wxWindowID FUNCPTR( wxPli_get_wxwindowid )( pTHX_ SV* var );
WXPLDLL int FUNCPTR( wxPli_av_2_stringarray )( pTHX_ SV* avref,
                                               wxString** array );
WXPLDLL int wxPli_av_2_charparray( pTHX_ SV* avref, char*** array );
WXPLDLL int wxPli_av_2_wxcharparray( pTHX_ SV* avref, wxChar*** array );
WXPLDLL int wxPli_av_2_uchararray( pTHX_ SV* avref, unsigned char** array );
WXPLDLL int wxPli_av_2_svarray( pTHX_ SV* avref, SV*** array );
WXPLDLL int FUNCPTR( wxPli_av_2_intarray )( pTHX_ SV* avref, int** array );

// pushes the elements of the array into the stack
// the caller _MUST_ call PUTBACK; before the function
// and SPAGAIN; after the function
void wxPli_stringarray_push( pTHX_ const wxArrayString& strings );
WXPLDLL AV* wxPli_stringarray_2_av( pTHX_ const wxArrayString& strings );
AV* wxPli_uchararray_2_av( pTHX_ const unsigned char* array, int count );

void wxPli_delete_argv( void* argv, bool unicode );
int wxPli_get_args_argc_argv( void* argv, bool unicode );
WXPLDLL void wxPli_get_args_objectarray( pTHX_ SV** sp, int items,
                                         void** array, const char* package );

WXPLDLL wxPoint FUNCPTR( wxPli_sv_2_wxpoint_test )( pTHX_ SV* scalar,
                                                    bool* ispoint );
WXPLDLL wxPoint FUNCPTR( wxPli_sv_2_wxpoint )( pTHX_ SV* scalar );
WXPLDLL wxSize FUNCPTR( wxPli_sv_2_wxsize )( pTHX_ SV* scalar );
// avoid dependency
#ifdef _WXPERL_TYPEDEF_H
WXPLDLL Wx_KeyCode wxPli_sv_2_keycode( pTHX_ SV* scalar );
#endif

WXPLDLL int wxPli_av_2_pointlist( pTHX_ SV* array, wxList *points,
                                  wxPoint** tmp );
WXPLDLL int wxPli_av_2_pointarray( pTHX_ SV* array, wxPoint** points );

// stream wrappers
class wxPliInputStream;
class wxPliOutputStream;
class wxStreamBase;

WXPLDLL void wxPli_sv_2_istream( pTHX_ SV* scalar, wxPliInputStream& stream );
WXPLDLL void wxPli_sv_2_ostream( pTHX_ SV* scalar, wxPliOutputStream& stream );
WXPLDLL void FUNCPTR( wxPli_stream_2_sv )( pTHX_ SV* scalar,
                                           wxStreamBase* stream,
                                           const char* package );
WXPLDLL wxPliInputStream* FUNCPTR( wxPliInputStream_ctor )( SV* sv );

// defined in Constants.xs
WXPLDLL void FUNCPTR( wxPli_add_constant_function )
    ( double (**)( const char*, int ) );
WXPLDLL void FUNCPTR( wxPli_remove_constant_function )
    ( double (**)( const char*, int ) );

// defined in v_cback.cpp
class wxPliVirtualCallback;

WXPLDLL bool FUNCPTR( wxPliVirtualCallback_FindCallback )
    ( pTHX_ const wxPliVirtualCallback* cb, const char* name );
// see wxPli_push_args for a description of argtypes
WXPLDLL SV* FUNCPTR( wxPliVirtualCallback_CallCallback )
    ( pTHX_ const wxPliVirtualCallback* cb, I32 flags = G_SCALAR,
      const char* argtypes = 0, ... );

// defined in overload.cpp
bool wxPli_match_arguments( pTHX_ const unsigned char prototype[],
                            size_t nproto, int required = -1,
                            bool allow_more = FALSE );
bool wxPli_match_arguments_skipfirst(  pTHX_ const unsigned char prototype[],
                                       size_t nproto, int required = -1,
                                       bool allow_more = FALSE );

#define WXPLI_BOOT_ONCE_( name, xs ) \
extern "C" XS(wxPli_boot_##name); \
extern "C" \
xs(boot_##name) \
{ \
    static bool booted = false; \
    if( booted ) return; \
    booted = true; \
    wxPli_boot_##name( aTHX_ cv ); \
}

#define WXPLI_BOOT_ONCE( name ) WXPLI_BOOT_ONCE_( name, XS )
#if defined(WIN32) || defined(__CYGWIN__)
#  define WXPLI_BOOT_ONCE_EXP( name ) WXPLI_BOOT_ONCE_( name, WXXS )
#else
#  define WXPLI_BOOT_ONCE_EXP WXPLI_BOOT_ONCE
#endif

struct wxPliHelpers
{
    void* ( * m_wxPli_sv_2_object )( pTHX_ SV*, const char* );
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
        ( pTHX_ const wxPliVirtualCallback*, I32 = G_SCALAR,
          const char* = 0, ... );
    bool ( * m_wxPli_object_is_deleteable )( pTHX_ SV* );
    void ( * m_wxPli_object_set_deleteable )( pTHX_ SV*, bool );
    const char* ( * m_wxPli_get_class )( pTHX_ SV* );
    wxWindowID ( * m_wxPli_get_wxwindowid )( pTHX_ SV* );
    int ( * m_wxPli_av_2_stringarray )( pTHX_ SV*, wxString** );
    wxPliInputStream* ( * m_wxPliInputStream_ctor )( SV* );
    const char* ( * m_wxPli_cpp_class_2_perl )( const wxChar*,
                                                char buffer[WXPL_BUF_SIZE] );
};

#define DEFINE_PLI_HELPERS( name ) \
wxPliHelpers name = { &wxPli_sv_2_object, &wxPli_object_2_sv, \
 &wxPli_non_object_2_sv, &wxPli_make_object, &wxPli_sv_2_wxpoint_test, \
 &wxPli_sv_2_wxpoint, \
 &wxPli_sv_2_wxsize, &wxPli_av_2_intarray, wxPli_stream_2_sv, \
 &wxPli_add_constant_function, &wxPli_remove_constant_function, \
 &wxPliVirtualCallback_FindCallback, &wxPliVirtualCallback_CallCallback, \
 &wxPli_object_is_deleteable, &wxPli_object_set_deleteable, &wxPli_get_class, \
 &wxPli_get_wxwindowid, &wxPli_av_2_stringarray, &wxPliInputStream_ctor, \
 &wxPli_cpp_class_2_perl };

#if !defined( WXPL_STATIC ) || !defined( WXPL_EXT )

#define INIT_PLI_HELPERS( name ) \
  SV* wxpli_tmp = get_sv( "Wx::_exports", 1 ); \
  wxPliHelpers* name = (wxPliHelpers*)(void*)SvIV( wxpli_tmp ); \
  wxPli_sv_2_object = name->m_wxPli_sv_2_object; \
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
  wxPli_cpp_class_2_perl = name->m_wxPli_cpp_class_2_perl;

#else

#define INIT_PLI_HELPERS( name )

#endif

int wxCALLBACK ListCtrlCompareFn( long item1, long item2, long comparefn );

class wxPliUserDataCD;
#if defined( _WX_WINDOW_H_BASE_ ) || defined( _WX_CLNTDATAH__ )

class WXPLDLL wxPliUserDataCD:public wxClientData
{
public:
    wxPliUserDataCD( SV* data )
        { dTHX; m_data = data ? newSVsv( data ) : 0; }
    ~wxPliUserDataCD();
public:
    SV* m_data;
};

#endif

class wxPliTreeItemData;
#if defined( _WX_TREEBASE_H_ ) || defined( _WX_TREECTRL_H_BASE_ )

class wxPliTreeItemData:public wxTreeItemData
{
public:
    wxPliTreeItemData( SV* data )
        { dTHX; m_data = data ? newSVsv( data ) : 0; }
    ~wxPliTreeItemData()
        { dTHX; if( m_data ) SvREFCNT_dec( m_data ); }

    void SetData( SV* data )
    {
        dTHX;
        if( m_data )
            SvREFCNT_dec( m_data );
        m_data = data ? newSVsv( data ) : 0;
    }
public:
    SV* m_data;
};

#endif

class WXPLDLL wxPliUserDataO:public wxObject
{
public:
    wxPliUserDataO( SV* data )
        { dTHX; m_data = data ? newSVsv( data ) : 0; }
    ~wxPliUserDataO();
public:
    SV* m_data;
};

class WXPLDLL wxPliSelfRef
{
public:
    wxPliSelfRef( const char* unused = 0 ) {}
    virtual ~wxPliSelfRef()
        { dTHX; if( m_self ) SvREFCNT_dec( m_self ); }

    void SetSelf( SV* self, bool increment = TRUE )
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

class WXPLDLL wxPliClassInfo:public wxClassInfo
{
public:
    wxPliClassInfo( wxChar *cName, wxChar *baseName1, wxChar *baseName2, 
                    int sz, wxPliGetCallbackObjectFn fn )
        :wxClassInfo( cName, baseName1, baseName2, sz, 0)
        {
            m_func = fn;
            //FIXME//
            m_baseInfo1 = wxClassInfo::FindClass( baseName1 );
            //FIXME// this is an ugly hack!
#if !defined( __WXMAC__ )
            if( m_baseInfo1 == 0 )
                croak( "ClassInfo initialization failed '%s'", baseName1 );
#endif
        }
public:
    wxPliGetCallbackObjectFn m_func;
};

#define WXPLI_DECLARE_DYNAMIC_CLASS(name) \
public:\
  static wxPliClassInfo sm_class##name;\
  virtual wxClassInfo *GetClassInfo() const \
   { return &name::sm_class##name; }

#define WXPLI_DECLARE_SELFREF() \
public:\
  wxPliSelfRef m_callback

#define WXPLI_DECLARE_V_CBACK() \
public:\
  wxPliVirtualCallback m_callback

#define WXPLI_IMPLEMENT_DYNAMIC_CLASS(name, basename) \
wxPliSelfRef* wxPliGetSelfFor##name(wxObject* object) \
  { return &((name *)object)->m_callback; }\
wxPliClassInfo name::sm_class##name((wxChar *) wxT(#name), \
  (wxChar *) wxT(#basename), (wxChar *) NULL, (int) sizeof(name), \
  (wxPliGetCallbackObjectFn) wxPliGetSelfFor##name);

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

// this should really, really, really be in compat.h,
// but requires perl.h to be included
#if WXPERL_P_VERSION_GE( 5, 4, 0 ) && !WXPERL_P_VERSION_GE( 5, 4, 5 )

inline SV* newSVpvn( const char* sxx, size_t len )
{
    if( len > 0 )
        return newSVpv( CHAR_P sxx, len );
    else
    {
        SV* sv = newSViv( 0 );
        sv_setpvn( sv, sxx, len );
        return sv;
    }
}

#endif

// Local variables: //
// mode: c++ //
// End: //
