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

WXPLDLL void* _sv_2_object( SV* scalar, const char* classname );
WXPLDLL SV* _object_2_sv( SV* var, wxObject* object );
WXPLDLL SV* _non_object_2_sv( SV* var, void* data, const char* package );

WXPLDLL SV* _make_object( wxObject* object, const char* classname );
WXPLDLL const char* _get_class( SV* ref );

WXPLDLL int _av_2_stringarray( SV* avref, wxString** array );
WXPLDLL int _av_2_uchararray( SV* avref, unsigned char** array );
WXPLDLL int _av_2_svarray( SV* avref, SV*** array );

int _get_args_argc_argv( char*** argv );
WXPLDLL void _get_args_objectarray( SV** sp, int items, void** array, const char* package );

WXPLDLL wxPoint _sv_2_wxpoint( SV* scalar );
WXPLDLL wxSize _sv_2_wxsize( SV* scalar );
WXPLDLL Wx_KeyCode _sv_2_keycode( SV* scalar );

WXPLDLL int _get_pointarray( SV* array, wxList *points, wxPoint** tmp );

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
