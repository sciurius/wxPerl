/////////////////////////////////////////////////////////////////////////////
// Name:        helpers.h
// Purpose:     some helper functions/classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/object.h>
#include <wx/list.h>

// helpers for UTF8 <-> wxString/wxChar
// because xsubpp does not allow #pragmas in typemaps
#if wxUSE_UNICODE

#define WXCHAR_INPUT( var, type, arg ) \
  const wxString var##_tmp = ( SvUTF8( arg ) ) ? \
            ( wxString( SvPVutf8_nolen( arg ), wxConvUTF8 ) ) \
          : ( wxString( SvPV_nolen( arg ), wxConvLibc ) ); \
  var = (type)var##_tmp.c_str();

#define WXCHAR_OUTPUT( var, arg ) \
  sv_setpv((SV*)arg, (const char*)wxConvUTF8.cWC2MB( var ? var : wxEmptyString ) ); \
  SvUTF8_on((SV*)arg);        

#define WXSTRING_INPUT( var, type, arg ) \
  var =  ( SvUTF8( arg ) ) ? \
           wxString( SvPVutf8_nolen( arg ), wxConvUTF8 ) \
         : wxString( SvPV_nolen( arg ) );

#define WXSTRING_OUTPUT( var, arg ) \
  sv_setpv((SV*)arg, (const char*)var.mb_str(wxConvUTF8)); \
  SvUTF8_on((SV*)arg);

#else

#define WXCHAR_INPUT( var, type, arg ) \
  var = (type)SvPV_nolen(arg)

#define WXCHAR_OUTPUT( var, arg ) \
  sv_setpv((SV*)arg, var);

#define WXSTRING_INPUT( var, type, arg ) \
  var = (type)SvPV_nolen(arg)

#define WXSTRING_OUTPUT( var, arg ) \
  sv_setpv((SV*)arg, var);

#endif

WXPLDLL const char* wxPli_cpp_class_2_perl( const wxChar* className );
WXPLDLL void wxPli_push_args( SV*** stack, const char* argtypes,
                              va_list &list );

WXPLDLL void* FUNCPTR( wxPli_sv_2_object )( SV* scalar,
                                            const char* classname );
WXPLDLL SV* FUNCPTR( wxPli_object_2_sv )( SV* var, wxObject* object );
WXPLDLL SV* FUNCPTR( wxPli_non_object_2_sv )( SV* var, void* data,
                                              const char* package );

WXPLDLL SV* FUNCPTR( wxPli_make_object )( void* object,
                                          const char* classname );

WXPLDLL bool FUNCPTR( wxPli_object_is_deleteable )( SV* object );
WXPLDLL void FUNCPTR( wxPli_object_set_deleteable )( SV* object,
                                                     bool deleteable );

WXPLDLL const char* FUNCPTR( wxPli_get_class )( SV* ref );

WXPLDLL wxWindowID FUNCPTR( wxPli_get_wxwindowid )( SV* var );
WXPLDLL int FUNCPTR( wxPli_av_2_stringarray )( SV* avref, wxString** array );
WXPLDLL int wxPli_av_2_charparray( SV* avref, char*** array );
WXPLDLL int wxPli_av_2_uchararray( SV* avref, unsigned char** array );
WXPLDLL int wxPli_av_2_svarray( SV* avref, SV*** array );
WXPLDLL int FUNCPTR( wxPli_av_2_intarray )( SV* avref, int** array );

WXPLDLL AV* wxPli_stringarray_2_av( const wxArrayString& strings );

void wxPli_delete_argv( void* argv, bool unicode );
int wxPli_get_args_argc_argv( void* argv, bool unicode );
WXPLDLL void wxPli_get_args_objectarray( SV** sp, int items, void** array,
                                         const char* package );

WXPLDLL wxPoint FUNCPTR( wxPli_sv_2_wxpoint_test )( SV* scalar, bool* ispoint );
WXPLDLL wxPoint FUNCPTR( wxPli_sv_2_wxpoint )( SV* scalar );
WXPLDLL wxSize FUNCPTR( wxPli_sv_2_wxsize )( SV* scalar );
WXPLDLL Wx_KeyCode wxPli_sv_2_keycode( SV* scalar );

WXPLDLL int wxPli_av_2_pointlist( SV* array, wxList *points, wxPoint** tmp );
WXPLDLL int wxPli_av_2_pointarray( SV* array, wxPoint** points );

// stream wrappers
class wxPliInputStream;
class wxPliOutputStream;
class wxStreamBase;

WXPLDLL void wxPli_sv_2_istream( SV* scalar, wxPliInputStream& stream );
WXPLDLL void wxPli_sv_2_ostream( SV* scalar, wxPliOutputStream& stream );
WXPLDLL void FUNCPTR( wxPli_stream_2_sv )( SV* scalar, wxStreamBase* stream,
                                const char* package );

// defined in Constants.xs
WXPLDLL void FUNCPTR( wxPli_add_constant_function )
    ( double (**)( const char*, int ) );
WXPLDLL void FUNCPTR( wxPli_remove_constant_function )
    ( double (**)( const char*, int ) );

// defined in v_cback.cpp
class wxPliVirtualCallback;

WXPLDLL bool FUNCPTR( wxPliVirtualCallback_FindCallback )
    ( const wxPliVirtualCallback* cb, const char* name );
WXPLDLL SV* FUNCPTR( wxPliVirtualCallback_CallCallback )
    ( const wxPliVirtualCallback* cb, I32 flags = G_SCALAR,
      const char* argtypes = 0, ... );

struct wxPliHelpers
{
    void* ( * m_wxPli_sv_2_object )( SV*, const char* );
    SV* ( * m_wxPli_object_2_sv )( SV*, wxObject* );
    SV* ( * m_wxPli_non_object_2_sv )( SV* , void*, const char* );
    SV* ( * m_wxPli_make_object )( void*, const char* );
    wxPoint ( * m_wxPli_sv_2_wxpoint_test )( SV*, bool* );
    wxPoint ( * m_wxPli_sv_2_wxpoint )( SV* );
    wxSize ( * m_wxPli_sv_2_wxsize )( SV* scalar );
    int ( * m_wxPli_av_2_intarray )( SV* avref, int** array );
    void ( * m_wxPli_stream_2_sv )( SV* scalar, wxStreamBase* stream, const char* package );

    void ( * m_wxPli_add_constant_function )
        ( double (**)( const char*, int ) );
    void ( * m_wxPli_remove_constant_function )
        ( double (**)( const char*, int ) );

    bool ( * m_wxPliVirtualCallback_FindCallback )( const wxPliVirtualCallback* cb, const char* name );
    SV* ( * m_wxPliVirtualCallback_CallCallback )
        ( const wxPliVirtualCallback* cb, I32 flags = G_SCALAR,
          const char* argtypes = 0, ... );
    bool ( * m_wxPli_object_is_deleteable )( SV* object );
    void ( * m_wxPli_object_set_deleteable )( SV* object, bool deleteable );
    const char* ( * m_wxPli_get_class )( SV* ref );
    wxWindowID ( * m_wxPli_get_wxwindowid )( SV* var );
    int ( * m_wxPli_av_2_stringarray )( SV* avref, wxString** array );
};

#define DEFINE_PLI_HELPERS( name ) \
wxPliHelpers name = { &wxPli_sv_2_object, &wxPli_object_2_sv, \
 &wxPli_non_object_2_sv, &wxPli_make_object, &wxPli_sv_2_wxpoint_test, \
 &wxPli_sv_2_wxpoint, \
 &wxPli_sv_2_wxsize, &wxPli_av_2_intarray, wxPli_stream_2_sv, \
 &wxPli_add_constant_function, &wxPli_remove_constant_function, \
 &wxPliVirtualCallback_FindCallback, &wxPliVirtualCallback_CallCallback, \
 &wxPli_object_is_deleteable, &wxPli_object_set_deleteable, &wxPli_get_class, \
 &wxPli_get_wxwindowid, &wxPli_av_2_stringarray };

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
  wxPli_av_2_stringarray = name->m_wxPli_av_2_stringarray;

int wxCALLBACK ListCtrlCompareFn( long item1, long item2, long comparefn );

#ifdef _WX_WINDOW_H_BASE_

class WXPLDLL wxPliUserDataCD:public wxClientData
{
public:
    wxPliUserDataCD( SV* data );
    ~wxPliUserDataCD();
public:
    SV* m_data;
};

inline wxPliUserDataCD::wxPliUserDataCD( SV* data )
{
    m_data = data ? newSVsv( data ) : 0;
}

#else

class wxPliUserDataCD;

#endif

#if defined( _WX_TREEBASE_H_ ) || defined( _WX_TREECTRL_H_BASE_ )

class wxPliTreeItemData:public wxTreeItemData
{
public:
    wxPliTreeItemData( SV* data );
    ~wxPliTreeItemData();

    void SetData( SV* data );
public:
    SV* m_data;
};

inline wxPliTreeItemData::wxPliTreeItemData( SV* data )
{
    m_data = data ? newSVsv( data ) : 0;
}

inline wxPliTreeItemData::~wxPliTreeItemData()
{
    if( m_data )
        SvREFCNT_dec( m_data );
}

inline void wxPliTreeItemData::SetData( SV* data )
{
    if( m_data )
        SvREFCNT_dec( m_data );
    m_data = data ? newSVsv( data ) : 0;
}

#else

class wxPliTreeItemData;

#endif

class WXPLDLL wxPliUserDataO:public wxObject
{
public:
    wxPliUserDataO( SV* data );
    ~wxPliUserDataO();
public:
    SV* m_data;
};

inline wxPliUserDataO::wxPliUserDataO( SV* data )
{
    m_data = data ? newSVsv( data ) : 0;
}

class WXPLDLL wxPliSelfRef
{
public:
    wxPliSelfRef( const char* unused = 0 );
    virtual ~wxPliSelfRef();

    void SetSelf( SV* self, bool increment = TRUE );
    SV* GetSelf();
public:
    SV* m_self;
};

inline void wxPliSelfRef::SetSelf( SV* self, bool increment ) 
{
    m_self = self;
    if( increment )       
        SvREFCNT_inc( m_self );
}

inline SV* wxPliSelfRef::GetSelf() {
    return m_self;
}

inline wxPliSelfRef::wxPliSelfRef( const char* unused )
{
}

inline wxPliSelfRef::~wxPliSelfRef() 
{
    if( m_self )
        SvREFCNT_dec( m_self );
}

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
#ifdef __WXMAC__
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
  wxPliSelfRef m_callback;

#define WXPLI_DECLARE_V_CBACK() \
public:\
  wxPliVirtualCallback m_callback;

#define WXPLI_IMPLEMENT_DYNAMIC_CLASS(name, basename) \
wxPliSelfRef* wxPliGetSelfFor##name(wxObject* object) \
  { return &((name *)object)->m_callback; }\
wxPliClassInfo name::sm_class##name((wxChar *) wxT(#name), \
  (wxChar *) wxT(#basename), (wxChar *) NULL, (int) sizeof(name), \
  (wxPliGetCallbackObjectFn) wxPliGetSelfFor##name);

#define WXPLI_DEFAULT_CONSTRUCTOR( name, packagename, incref ) \
    name( const char* package )                                \
        :m_callback( packagename )                             \
    {                                                          \
        m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
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
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, wxPl##name##Name, incref ); \
    WXPLI_CONSTRUCTOR_6( wxPli##name, wxPl##name##Name, incref,         \
                         argt1, argt2, argt3, argt4, argt5, argt6 );    \
};

#define WXPLI_DECLARE_CLASS_7( name, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, wxPl##name##Name, incref ); \
    WXPLI_CONSTRUCTOR_7( wxPli##name, wxPl##name##Name, incref,         \
                         argt1, argt2, argt3, argt4, argt5, argt6,      \
                         argt7 );                                       \
};

#define WXPLI_DECLARE_CLASS_8( name, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, wxPl##name##Name, incref ); \
    WXPLI_CONSTRUCTOR_8( wxPli##name, wxPl##name##Name, incref,         \
                         argt1, argt2, argt3, argt4, argt5, argt6,      \
                         argt7, argt8 );                                \
};

#define WXPLI_DECLARE_CLASS_9( name, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8, argt9 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, wxPl##name##Name, incref ); \
    WXPLI_CONSTRUCTOR_9( wxPli##name, wxPl##name##Name, incref,         \
                         argt1, argt2, argt3, argt4, argt5, argt6,      \
                         argt7, argt8, argt9 );                                \
};

#define WXPLI_DECLARE_CLASS_10( name, incref, argt1, argt2, argt3, argt4, argt5, argt6, argt7, argt8, argt9, argt10 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, wxPl##name##Name, incref ); \
    WXPLI_CONSTRUCTOR_10( wxPli##name, wxPl##name##Name, incref,        \
                         argt1, argt2, argt3, argt4, argt5, argt6,      \
                         argt7, argt8, argt9, argt10 );                 \
};


#define WXPLI_DEFINE_CLASS( name ) \
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPli##name, wx##name );

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
