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

const char* _cpp_class_2_perl( const char* className );
void _push_args( SV** stack, const char* argtypes, va_list &list );

void* _sv_2_object( SV* scalar, const char* classname );
SV* _object_2_sv( SV* var, wxObject* object );
SV* _non_object_2_sv( SV* var, void* data, const char* package );
SV* _make_object( wxObject* object, const char* classname );
const char* _get_class( SV* ref );

int _av_2_stringarray( SV* avref, wxString** array );
int _av_2_uchararray( SV* avref, unsigned char** array );
int _av_2_svarray( SV* avref, SV*** array );

int _get_args_argc_argv( char*** argv );
void _get_args_objectarray( SV** sp, int items, void** array, const char* package );

wxPoint _sv_2_wxpoint( SV* scalar );
wxSize _sv_2_wxsize( SV* scalar );

int _get_pointarray( SV* array, wxList *points, wxPoint** tmp );

class _wxUserDataCD:public wxClientData
{
public:
    _wxUserDataCD( SV* data );
    ~_wxUserDataCD();
public:
    SV* m_data;
};

inline _wxUserDataCD::_wxUserDataCD( SV* data )
{
    m_data = data;
    SvREFCNT_inc( m_data );
}

class _wxUserDataO:public wxObject
{
public:
    _wxUserDataO( SV* data );
    ~_wxUserDataO();
public:
    SV* m_data;
};

inline _wxUserDataO::_wxUserDataO( SV* data )
{
    m_data = data;
    SvREFCNT_inc( m_data );
}

class _wxSelfRef
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

class _wxClassInfo:public wxClassInfo
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
_wxSelfRef* WXDLLEXPORT _wxGetSelfFor##name(wxObject* object) \
  { return &((name *)object)->m_callback; }\
_wxClassInfo name::sm_class##name((wxChar *) wxT(#name), \
  (wxChar *) wxT(#basename), (wxChar *) NULL, (int) sizeof(name), \
  (_wxGetCallbackObjectFn) _wxGetSelfFor##name);

// Local variables: //
// mode: c++ //
// End: //
