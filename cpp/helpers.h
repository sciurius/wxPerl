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

WXPLDLL const char* _cpp_class_2_perl( const char* className );
WXPLDLL void _push_args( SV*** stack, const char* argtypes, va_list &list );

WXPLDLL void* FUNCPTR( _sv_2_object )( SV* scalar, const char* classname );
WXPLDLL SV* FUNCPTR( _object_2_sv )( SV* var, wxObject* object );
WXPLDLL SV* FUNCPTR( _non_object_2_sv )( SV* var, void* data,
                                         const char* package );

WXPLDLL SV* FUNCPTR( _make_object )( wxObject* object, const char* classname );
WXPLDLL const char* _get_class( SV* ref );

WXPLDLL int _av_2_stringarray( SV* avref, wxString** array );
WXPLDLL int _av_2_uchararray( SV* avref, unsigned char** array );
WXPLDLL int _av_2_svarray( SV* avref, SV*** array );
WXPLDLL int FUNCPTR( _av_2_intarray )( SV* avref, int** array );

int _get_args_argc_argv( char*** argv );
WXPLDLL void _get_args_objectarray( SV** sp, int items, void** array, const char* package );

WXPLDLL wxPoint FUNCPTR( _sv_2_wxpoint )( SV* scalar );
WXPLDLL wxSize FUNCPTR( _sv_2_wxsize )( SV* scalar );
WXPLDLL Wx_KeyCode _sv_2_keycode( SV* scalar );

WXPLDLL int _get_pointarray( SV* array, wxList *points, wxPoint** tmp );

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
class _wxVirtualCallback;

WXPLDLL bool FUNCPTR( wxPliVirtualCallback_FindCallback )
    ( _wxVirtualCallback* cb, const char* name );
WXPLDLL SV* FUNCPTR( wxPliVirtualCallback_CallCallback )
    ( _wxVirtualCallback* cb, I32 flags = G_SCALAR,
      const char* argtypes = 0, ... );

struct wxPliHelpers
{
    void* ( * m_sv_2_object )( SV*, const char* );
    SV* ( * m_object_2_sv )( SV*, wxObject* );
    SV* ( * m_non_object_2_sv )( SV* , void*, const char* );
    SV* ( * m_make_object )( wxObject*, const char* );
    wxPoint ( * m_sv_2_wxpoint )( SV* );
    wxSize ( * m_sv_2_wxsize )( SV* scalar );
    int ( * m_av_2_intarray )( SV* avref, int** array );

    void ( * m_wxPli_add_constant_function )
        ( double (**)( const char*, int ) );
    void ( * m_wxPli_remove_constant_function )
        ( double (**)( const char*, int ) );

    bool ( * m_wxPliVirtualCallback_FindCallback )( _wxVirtualCallback* cb, const char* name );
    SV* ( * m_wxPliVirtualCallback_CallCallback )
        ( _wxVirtualCallback* cb, I32 flags = G_SCALAR,
          const char* argtypes = 0, ... );
};

#define DEFINE_PLI_HELPERS( name ) \
wxPliHelpers name = { &_sv_2_object, &_object_2_sv, &_non_object_2_sv, \
 &_make_object, &_sv_2_wxpoint, &_sv_2_wxsize, &_av_2_intarray, \
 &wxPli_add_constant_function, &wxPli_remove_constant_function, \
 &wxPliVirtualCallback_FindCallback, &wxPliVirtualCallback_CallCallback };

#define INIT_PLI_HELPERS( name ) \
  SV* wxpli_tmp = get_sv( "Wx::_exports", 1 ); \
  wxPliHelpers* name = (wxPliHelpers*)(void*)SvIV( wxpli_tmp ); \
  _sv_2_object = name->m_sv_2_object; \
  _object_2_sv = name->m_object_2_sv; \
  _non_object_2_sv = name->m_non_object_2_sv; \
  _make_object = name->m_make_object; \
  _sv_2_wxpoint = name->m_sv_2_wxpoint; \
  _sv_2_wxsize = name->m_sv_2_wxsize; \
  _av_2_intarray = name->m_av_2_intarray; \
  wxPli_add_constant_function = name->m_wxPli_add_constant_function; \
  wxPli_remove_constant_function = name->m_wxPli_remove_constant_function; \
  wxPliVirtualCallback_FindCallback = name->m_wxPliVirtualCallback_FindCallback; \
  wxPliVirtualCallback_CallCallback = name->m_wxPliVirtualCallback_CallCallback;

int wxCALLBACK ListCtrlCompareFn( long item1, long item2, long comparefn );

#ifdef _WX_WINDOW_H_BASE_

class WXPLDLL _wxUserDataCD:public wxClientData
{
public:
    _wxUserDataCD( SV* data );
    ~_wxUserDataCD();
public:
    SV* m_data;
};

inline _wxUserDataCD::_wxUserDataCD( SV* data )
{
    m_data = data ? newSVsv( data ) : 0;
}

#else

class _wxUserDataCD;

#endif

#if defined( _WX_TREEBASE_H_ ) || defined( _WX_TREECTRL_H_BASE_ )

class WXPLDLL _wxTreeItemData:public wxTreeItemData
{
public:
    _wxTreeItemData( SV* data );
    ~_wxTreeItemData();

    void SetData( SV* data );
public:
    SV* m_data;
};

inline _wxTreeItemData::_wxTreeItemData( SV* data )
{
    m_data = data ? newSVsv( data ) : 0;
}

inline _wxTreeItemData::~_wxTreeItemData()
{
    if( m_data )
        SvREFCNT_dec( m_data );
}

inline void _wxTreeItemData::SetData( SV* data )
{
    if( m_data )
        SvREFCNT_dec( data );
    m_data = data ? newSVsv( data ) : 0;
}

#else

class _wxTreeItemData;

#endif

class WXPLDLL _wxUserDataO:public wxObject
{
public:
    _wxUserDataO( SV* data );
    ~_wxUserDataO();
public:
    SV* m_data;
};

inline _wxUserDataO::_wxUserDataO( SV* data )
{
    m_data = data ? newSVsv( data ) : 0;
}

class WXPLDLL _wxSelfRef
{
public:
    _wxSelfRef( const char* unused = 0 );
    virtual ~_wxSelfRef();

    void SetSelf( SV* self, bool increment = TRUE );
    SV* GetSelf();
public:
    SV* m_self;
};

inline void _wxSelfRef::SetSelf( SV* self, bool increment ) 
{
    m_self = self;
    if( increment )       
        SvREFCNT_inc( m_self );
}

inline SV* _wxSelfRef::GetSelf() {
    return m_self;
}

inline _wxSelfRef::_wxSelfRef( const char* unused )
{
}

inline _wxSelfRef::~_wxSelfRef() 
{
    if( m_self )
        SvREFCNT_dec( m_self );
}

typedef _wxSelfRef* (* _wxGetCallbackObjectFn)(wxObject* object);

class WXPLDLL _wxClassInfo:public wxClassInfo
{
public:
    _wxClassInfo( wxChar *cName, wxChar *baseName1, wxChar *baseName2, 
                  int sz, _wxGetCallbackObjectFn fn )
        :wxClassInfo( cName, baseName1, baseName2, sz, 0)
        {
            m_func = fn;
        }
public:
    _wxGetCallbackObjectFn m_func;
};

#define _DECLARE_DYNAMIC_CLASS(name) \
public:\
  static _wxClassInfo sm_class##name;\
  virtual wxClassInfo *GetClassInfo() const \
   { return &name::sm_class##name; }

#define _DECLARE_SELFREF() \
public:\
  _wxSelfRef m_callback;

#define _DECLARE_V_CBACK() \
public:\
  _wxVirtualCallback m_callback;

#define _IMPLEMENT_DYNAMIC_CLASS(name, basename) \
_wxSelfRef* _wxGetSelfFor##name(wxObject* object) \
  { return &((name *)object)->m_callback; }\
_wxClassInfo name::sm_class##name((wxChar *) wxT(#name), \
  (wxChar *) wxT(#basename), (wxChar *) NULL, (int) sizeof(name), \
  (_wxGetCallbackObjectFn) _wxGetSelfFor##name);

// Local variables: //
// mode: c++ //
// End: //
