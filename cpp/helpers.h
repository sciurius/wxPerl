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

WXPLDLL const char* wxPli_cpp_class_2_perl( const char* className );
WXPLDLL void wxPli_push_args( SV*** stack, const char* argtypes,
                              va_list &list );

WXPLDLL void* FUNCPTR( wxPli_sv_2_object )( SV* scalar,
                                            const char* classname );
WXPLDLL SV* FUNCPTR( wxPli_object_2_sv )( SV* var, wxObject* object );
WXPLDLL SV* FUNCPTR( wxPli_non_object_2_sv )( SV* var, void* data,
                                              const char* package );

WXPLDLL SV* FUNCPTR( wxPli_make_object )( wxObject* object,
                                          const char* classname );

WXPLDLL const char* wxPli_get_class( SV* ref );

WXPLDLL int wxPli_av_2_stringarray( SV* avref, wxString** array );
WXPLDLL int wxPli_av_2_uchararray( SV* avref, unsigned char** array );
WXPLDLL int wxPli_av_2_svarray( SV* avref, SV*** array );
WXPLDLL int FUNCPTR( wxPli_av_2_intarray )( SV* avref, int** array );

int wxPli_get_args_argc_argv( char*** argv );
WXPLDLL void wxPli_get_args_objectarray( SV** sp, int items, void** array,
                                         const char* package );

WXPLDLL wxPoint FUNCPTR( wxPli_sv_2_wxpoint )( SV* scalar );
WXPLDLL wxSize FUNCPTR( wxPli_sv_2_wxsize )( SV* scalar );
WXPLDLL Wx_KeyCode wxPli_sv_2_keycode( SV* scalar );

WXPLDLL int wxPli_av_2_pointarray( SV* array, wxList *points, wxPoint** tmp );

// stream wrappers
class wxPliInputStream;
class wxPliOutputStream;
class wxStreamBase;

WXPLDLL void wxPli_sv_2_istream( SV* scalar, wxPliInputStream& stream );
WXPLDLL void wxPli_sv_2_ostream( SV* scalar, wxPliOutputStream& stream );
WXPLDLL void wxPli_stream_2_sv( SV* scalar, wxStreamBase* stream,
                                const char* package );

// defined in Constants.xs
WXPLDLL void FUNCPTR( wxPli_add_constant_function )
    ( double (**)( const char*, int ) );
WXPLDLL void FUNCPTR( wxPli_remove_constant_function )
    ( double (**)( const char*, int ) );

// defined in v_cback.cpp
class wxPliVirtualCallback;

WXPLDLL bool FUNCPTR( wxPliVirtualCallback_FindCallback )
    ( wxPliVirtualCallback* cb, const char* name );
WXPLDLL SV* FUNCPTR( wxPliVirtualCallback_CallCallback )
    ( wxPliVirtualCallback* cb, I32 flags = G_SCALAR,
      const char* argtypes = 0, ... );

struct wxPliHelpers
{
    void* ( * m_wxPli_sv_2_object )( SV*, const char* );
    SV* ( * m_wxPli_object_2_sv )( SV*, wxObject* );
    SV* ( * m_wxPli_non_object_2_sv )( SV* , void*, const char* );
    SV* ( * m_wxPli_make_object )( wxObject*, const char* );
    wxPoint ( * m_wxPli_sv_2_wxpoint )( SV* );
    wxSize ( * m_wxPli_sv_2_wxsize )( SV* scalar );
    int ( * m_wxPli_av_2_intarray )( SV* avref, int** array );

    void ( * m_wxPli_add_constant_function )
        ( double (**)( const char*, int ) );
    void ( * m_wxPli_remove_constant_function )
        ( double (**)( const char*, int ) );

    bool ( * m_wxPliVirtualCallback_FindCallback )( wxPliVirtualCallback* cb, const char* name );
    SV* ( * m_wxPliVirtualCallback_CallCallback )
        ( wxPliVirtualCallback* cb, I32 flags = G_SCALAR,
          const char* argtypes = 0, ... );
};

#define DEFINE_PLI_HELPERS( name ) \
wxPliHelpers name = { &wxPli_sv_2_object, &wxPli_object_2_sv, \
 &wxPli_non_object_2_sv, &wxPli_make_object, &wxPli_sv_2_wxpoint, \
 &wxPli_sv_2_wxsize, &wxPli_av_2_intarray, \
 &wxPli_add_constant_function, &wxPli_remove_constant_function, \
 &wxPliVirtualCallback_FindCallback, &wxPliVirtualCallback_CallCallback };

#define INIT_PLI_HELPERS( name ) \
  SV* wxpli_tmp = get_sv( "Wx::_exports", 1 ); \
  wxPliHelpers* name = (wxPliHelpers*)(void*)SvIV( wxpli_tmp ); \
  wxPli_sv_2_object = name->m_wxPli_sv_2_object; \
  wxPli_object_2_sv = name->m_wxPli_object_2_sv; \
  wxPli_non_object_2_sv = name->m_wxPli_non_object_2_sv; \
  wxPli_make_object = name->m_wxPli_make_object; \
  wxPli_sv_2_wxpoint = name->m_wxPli_sv_2_wxpoint; \
  wxPli_sv_2_wxsize = name->m_wxPli_sv_2_wxsize; \
  wxPli_av_2_intarray = name->m_wxPli_av_2_intarray; \
  wxPli_add_constant_function = name->m_wxPli_add_constant_function; \
  wxPli_remove_constant_function = name->m_wxPli_remove_constant_function; \
  wxPliVirtualCallback_FindCallback = name->m_wxPliVirtualCallback_FindCallback; \
  wxPliVirtualCallback_CallCallback = name->m_wxPliVirtualCallback_CallCallback;

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
        SvREFCNT_dec( data );
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

// Local variables: //
// mode: c++ //
// End: //
