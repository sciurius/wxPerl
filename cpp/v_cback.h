/////////////////////////////////////////////////////////////////////////////
// Name:        v_cback.h
// Purpose:     callback helper class for virtual functions
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_V_CBACK_H
#define _WXPERL_V_CBACK_H

#include <stddef.h>

class wxPliVirtualCallback : public wxPliSelfRef
{
public:
    wxPliVirtualCallback( const char* package );

    // these aren't really const functions, but we will need
    // to declare m_method mutable...
    bool FindCallback( pTHX_ const char* name ) const;
    SV* CallCallback( pTHX_ I32 flags, const char* argtypes,
                      va_list& arglist ) const;
    CV* GetMethod() const { return m_method; }
public:
    const char* m_package;
    HV* m_stash;
    CV* m_method;
};

inline wxPliVirtualCallback::wxPliVirtualCallback( const char* package )
{
    m_package = package;
    m_self = 0;
    m_stash = 0;
}

// declare/define callbacks for commonly used signatures

#define DEC_V_CBACK_BOOL__VOID( METHOD ) \
  bool METHOD()

#define DEF_V_CBACK_BOOL__VOID( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD()                                                        \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR );              \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD();                                                \
  }

#define DEC_V_CBACK_BOOL__BOOL( METHOD ) \
  bool METHOD( bool )

#define DEF_V_CBACK_BOOL__BOOL( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( bool param1 )                                           \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                                                     "b", param1 );           \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD();                                                \
  }

#define DEC_V_CBACK_VOID__VOID( METHOD ) \
  void METHOD()

#define DEF_V_CBACK_VOID__VOID( CLASS, BASE, METHOD ) \
  void CLASS::METHOD()                                                        \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,                 \
                                           G_SCALAR|G_DISCARD );              \
    } else                                                                    \
        BASE::METHOD();                                                \
  }

#define DEC_V_CBACK_BOOL__INT( METHOD ) \
  bool METHOD( int )

#define DEF_V_CBACK_BOOL__INT( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( int parameter )                                         \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                                                     "i", parameter );        \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( parameter );                                     \
  }

#define DEF_V_CBACK_BOOL__INT_pure( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( int parameter )                                         \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                                                     "i", parameter );        \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    }                                                                         \
    return false;                                                             \
  }

#define DEC_V_CBACK_BOOL__INT_INT( METHOD ) \
  bool METHOD( int, int )

#define DEF_V_CBACK_BOOL__INT_INT( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( int param1, int param2 )                                \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                                                     "ii", param1, param2 );  \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( param1, param2 );                                \
  }

#define DEC_V_CBACK_SIZET__VOID__CONST( METHOD ) \
  size_t METHOD() const

#define DEF_V_CBACK_SIZET__VOID__CONST( CLASS, BASE, METHOD ) \
  size_t CLASS::METHOD() const                                                \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR );              \
        size_t val = SvUV( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD();                                                \
  }

#define DEC_V_CBACK_BOOL__VOIDP__CONST( METHOD ) \
  bool METHOD( void* ) const

#define DEF_V_CBACK_BOOL__VOIDP__CONST( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( void* param1 ) const                                    \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* buf = newSViv( 0 );                                               \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                                                     "s", buf );              \
        STRLEN len;                                                           \
        char* val = SvPV( buf, len );                                         \
        memcpy( param1, val, len );                                           \
        bool retv = SvTRUE( ret );                                            \
        SvREFCNT_dec( buf );                                                  \
        SvREFCNT_dec( ret );                                                  \
        return retv;                                                          \
    } else                                                                    \
        return BASE::METHOD( param1 );                                        \
  }

#define DEC_V_CBACK_BOOL__SIZET_CVOIDP( METHOD ) \
  bool METHOD( size_t, const void* )

#define DEF_V_CBACK_BOOL__SIZET_CVOIDP( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( size_t param1, const void* param2 )                     \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                               "s", newSVpvn( CHAR_P (const char*)param2,     \
                                              param1 ) );                     \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( param1, param2 );                                \
  }

#define DEC_V_CBACK_BOOL__WXDRAGRESULT( METHOD ) \
  bool METHOD( wxDragResult )

#define DEF_V_CBACK_BOOL__WXDRAGRESULT( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( wxDragResult param1 )                                   \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                               "i", param1 );                                 \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( param1 );                                        \
  }

#define DEC_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT( METHOD ) \
  wxDragResult METHOD( wxCoord, wxCoord, wxDragResult )

#define DEF_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT( CLASS, BASE, METHOD ) \
  wxDragResult CLASS::METHOD( wxCoord param1, wxCoord param2,                 \
                              wxDragResult param3 )                           \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                               "lli", param1, param2, param3 );               \
        wxDragResult val = (wxDragResult)SvIV( ret );                         \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( param1, param2, param3 );                        \
  }

#define DEF_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT_pure( CLASS, BASE, METHOD ) \
  wxDragResult CLASS::METHOD( wxCoord param1, wxCoord param2,                 \
                              wxDragResult param3 )                           \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                               "lli", param1, param2, param3 );               \
        wxDragResult val = (wxDragResult)SvIV( ret );                         \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return wxDragNone;                                                    \
  }

#define DEC_V_CBACK_BOOL__WXCOORD_WXCOORD( METHOD ) \
  bool METHOD( wxCoord, wxCoord )

#define DEF_V_CBACK_BOOL__WXCOORD_WXCOORD( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( wxCoord param1, wxCoord param2 )                        \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                               "ll", param1, param2 );                        \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( param1, param2 );                                \
  }

#define DEC_V_CBACK_BOOL__WXCOORD_WXCOORD_WXSTRING( METHOD ) \
  bool METHOD( wxCoord, wxCoord, const wxString& )

#define DEF_V_CBACK_BOOL__WXCOORD_WXCOORD_WXSTRING_pure( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( wxCoord param1, wxCoord param2, const wxString& param3 )\
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                               "llP", param1, param2, &param3 );              \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return FALSE;                                                         \
  }

#define DEC_V_CBACK_BOOL__WXCOORD_WXCOORD_WXARRAYSTRING( METHOD ) \
  bool METHOD( wxCoord, wxCoord, const wxArrayString& )

#define DEF_V_CBACK_BOOL__WXCOORD_WXCOORD_WXARRAYSTRING_pure( CLASS, BASE, METHOD )\
  bool CLASS::METHOD( wxCoord param1, wxCoord param2, const wxArrayString& param3 ) \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        AV* av = newAV();                                                     \
        size_t i, max = param3.GetCount();                                    \
                                                                              \
        for( i = 0; i < max; ++i )                                            \
        {                                                                     \
            SV* sv = newSViv( 0 );                                            \
            const wxString& tmp = param3[ i ];                                \
            WXSTRING_OUTPUT( tmp, sv );                                       \
            av_store( av, i, sv );                                            \
        }                                                                     \
        SV* rv = newRV_noinc( (SV*) av );                                     \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                               "lls", param1, param2, rv );                   \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return FALSE;                                                         \
  }

#define DEC_V_CBACK_WXSTRING__VOID( METHOD ) \
  wxString METHOD()

#define DEF_V_CBACK_WXSTRING__VOID_pure( CLASS, BASE, METHOD )\
  wxString CLASS::METHOD()                                                    \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR );              \
        wxString val;                                                         \
        WXSTRING_INPUT( val, wxString, ret );                                 \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    }                                                                         \
    return wxEmptyString;                                                     \
  }

#define DEC_V_CBACK_BOOL__WXSTRING( METHOD ) \
  bool METHOD( const wxString& )

#define DEC_V_CBACK_WXSTRING__WXSTRING_INT( METHOD ) \
  wxString METHOD( const wxString&, int )

#define DEC_V_CBACK_WXFSFILEP__WXFILESYSTEM_WXSTRING( METHOD ) \
  wxFSFile* METHOD( wxFileSystem&, const wxString& )

#define DEC_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( METHOD ) \
  void METHOD( wxLogLevel, const wxChar*, time_t )

#define DEF_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( CLASS, BASE, METHOD )\
  void CLASS::METHOD( wxLogLevel param1, const wxChar* param2, time_t param3 )\
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback, G_VOID,         \
                                           "iwl", int(param1), param2,        \
                                           long(param3) );                    \
    }                                                                         \
    BASE::METHOD( param1, param2, param3 );                                   \
  }

#define DEC_V_CBACK_VOID__CWXCHARP_TIMET( METHOD ) \
  void METHOD( const wxChar*, time_t )

#define DEF_V_CBACK_VOID__CWXCHARP_TIMET( CLASS, BASE, METHOD )\
  void CLASS::METHOD( const wxChar* param1, time_t param2 )                   \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback, G_VOID,         \
                                           "wl", param1, long(param2) );      \
    }                                                                         \
    BASE::METHOD( param1, param2 );                                           \
  }

#endif // _WXPERL_V_CBACK_H

// Local variables: //
// mode: c++ //
// End: //
