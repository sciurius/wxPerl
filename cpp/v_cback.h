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

#define wxPli_NOCONST
#define wxPli_CONST const

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
        return BASE::METHOD( param1 );                                        \
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

#define DEC_V_CBACK_SIZET__VOID_const( METHOD ) \
  size_t METHOD() const

#define DEF_V_CBACK_SIZET__VOID_const( CLASS, BASE, METHOD ) \
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

#define DEC_V_CBACK_BOOL__VOIDP_const( METHOD ) \
  bool METHOD( void* ) const

#define DEF_V_CBACK_BOOL__VOIDP_const( CLASS, BASE, METHOD ) \
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
        SV* n = newSVpvn( CHAR_P (const char*)param2, param1 );               \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                               "s", n );                                      \
        bool val = SvTRUE( ret );                                             \
        SvREFCNT_dec( ret );                                                  \
        SvREFCNT_dec( n );                                                    \
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

// bool METH(const wxString&)
#define DEC_V_CBACK_BOOL__WXSTRING_( METHOD, CONST )                          \
    bool METHOD(const wxString&) CONST

#define DEF_V_CBACK_BOOL__WXSTRING_( CLASS, CALLBASE, METHOD, CONST )         \
    bool CLASS::METHOD(const wxString& param1) CONST                          \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback,             \
                                               #METHOD ) )                    \
        {                                                                     \
            SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,   \
                                                         G_SCALAR, "P",       \
                                                         &param1 );           \
            bool val = SvTRUE( ret );                                         \
            SvREFCNT_dec( ret );                                              \
            return val;                                                       \
        }                                                                     \
        else                                                                  \
            CALLBASE;                                                         \
    }

#define DEC_V_CBACK_BOOL__WXSTRING( METHOD ) \
    DEC_V_CBACK_BOOL__WXSTRING_( METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_BOOL__WXSTRING_const( METHOD ) \
    DEC_V_CBACK_BOOL__WXSTRING_( METHOD, wxPli_CONST )

#define DEF_V_CBACK_BOOL__WXSTRING( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__WXSTRING_( CLASS, return BASE::METHOD(param1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__WXSTRING_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__WXSTRING_( CLASS, return false, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__WXSTRING_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__WXSTRING_( CLASS, return BASE::METHOD(param1), METHOD, wxPli_CONST )

// bool METH(wxString&)
#define DEC_V_CBACK_BOOL__mWXSTRING_( METHOD, CONST )                         \
    bool METHOD(wxString&) CONST

#define DEF_V_CBACK_BOOL__mWXSTRING_( CLASS, CALLBASE, METHOD, CONST )        \
    bool CLASS::METHOD(wxString& param1) CONST                                \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback,             \
                                               #METHOD ) )                    \
        {                                                                     \
            SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,   \
                                                         G_SCALAR, "P",       \
                                                         &param1 );           \
            bool val = SvTRUE( ret );                                         \
            SvREFCNT_dec( ret );                                              \
            return val;                                                       \
        }                                                                     \
        else                                                                  \
            CALLBASE;                                                         \
    }

#define DEC_V_CBACK_BOOL__mWXSTRING( METHOD ) \
    DEC_V_CBACK_BOOL__mWXSTRING_( METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_BOOL__mWXSTRING_const( METHOD ) \
    DEC_V_CBACK_BOOL__mWXSTRING_( METHOD, wxPli_CONST )

#define DEF_V_CBACK_BOOL__mWXSTRING( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__mWXSTRING_( CLASS, return BASE::METHOD(param1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__mWXSTRING_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__mWXSTRING_( CLASS, return false, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__mWXSTRING_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__mWXSTRING_( CLASS, return BASE::METHOD(param1), METHOD, wxPli_CONST )

// bool METH(int, int)
#define DEC_V_CBACK_BOOL__INT_INT_( METHOD, CONST ) \
    bool METHOD( int, int ) CONST

#define DEF_V_CBACK_BOOL__INT_INT_( CLASS, CALLBASE, METHOD, CONST )         \
    bool CLASS::METHOD( int param1, int param2 ) CONST                       \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )\
        {                                                                    \
            SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,  \
                                           G_SCALAR, "ii", param1, param2 ); \
            bool val = SvTRUE( ret );                                        \
            SvREFCNT_dec( ret );                                             \
            return val;                                                      \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_BOOL__INT_INT( METHOD ) \
    DEC_V_CBACK_BOOL__INT_INT_( METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_BOOL__INT_INT_const( METHOD ) \
    DEC_V_CBACK_BOOL__INT_INT_( METHOD, wxPli_CONST )

#define DEF_V_CBACK_BOOL__INT_INT( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__INT_INT_( CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__INT_INT_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__INT_INT_( CLASS, return false, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__INT_INT_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__INT_INT_( CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_CONST )

// bool METH()
#define DEC_V_CBACK_BOOL__VOID_( METHOD, CONST ) \
    bool METHOD() CONST

#define DEF_V_CBACK_BOOL__VOID_( CLASS, CALLBASE, METHOD, CONST )             \
    bool CLASS::METHOD() CONST                                                \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) ) \
        {                                                                     \
            SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,   \
                                                         G_SCALAR );          \
            bool val = SvTRUE( ret );                                         \
            SvREFCNT_dec( ret );                                              \
            return val;                                                       \
        } else                                                                \
            CALLBASE;                                                         \
    }

#define DEC_V_CBACK_BOOL__VOID( METHOD ) \
    DEC_V_CBACK_BOOL__VOID_( METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_BOOL__VOID_const( METHOD ) \
    DEC_V_CBACK_BOOL__VOID_( METHOD, wxPli_CONST )

#define DEF_V_CBACK_BOOL__VOID( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__VOID_( CLASS, return BASE::METHOD(), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__VOID_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__VOID_( CLASS, return BASE::METHOD(), METHOD, wxPli_CONST )

// int METH()
#define DEC_V_CBACK_INT__VOID_( METHOD, CONST )                               \
    int METHOD() CONST

#define DEF_V_CBACK_INT__VOID_( CLASS, CALLBASE, METHOD, CONST )              \
    int CLASS::METHOD() CONST                                                 \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) ) \
        {                                                                     \
            SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,   \
                                                         G_SCALAR );          \
            int val = SvOK( ret ) ? SvIV( ret ) : 0;                          \
            SvREFCNT_dec( ret );                                              \
            return val;                                                       \
        }                                                                     \
        else                                                                  \
            CALLBASE;                                                         \
    }

#define DEC_V_CBACK_INT__VOID( METHOD ) \
    DEC_V_CBACK_INT__VOID_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_INT__VOID( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_INT__VOID_( CLASS, return BASE::METHOD(), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_INT__VOID_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_INT__VOID_( CLASS, return 0, METHOD, wxPli_NOCONST )

// void METH()
#define DEC_V_CBACK_VOID__VOID_( METHOD, CONST ) \
    void METHOD() CONST

#define DEF_V_CBACK_VOID__VOID_( CLASS, CALLBASE, METHOD, CONST )             \
    void CLASS::METHOD() CONST                                                \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) ) \
        {                                                                     \
              wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,           \
                                                 G_SCALAR|G_DISCARD );        \
        } else                                                                \
            CALLBASE;                                                         \
    }

#define DEC_V_CBACK_VOID__VOID( METHOD ) \
    DEC_V_CBACK_VOID__VOID_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__VOID( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__VOID_( CLASS, BASE::METHOD(), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__VOID_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__VOID_( CLASS, return, METHOD, wxPli_NOCONST )

// void METH(int, int, wxString)
#define DEC_V_CBACK_VOID__INT_INT_WXSTRING_( METHOD, CONST ) \
    void METHOD( int, int, const wxString& ) CONST

#define DEF_V_CBACK_VOID__INT_INT_WXSTRING_( CLASS, CALLBASE, METHOD, CONST )\
    void CLASS::METHOD( int p1, int p2, const wxString& p3 ) CONST           \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )\
        {                                                                    \
              wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,          \
                                                 G_SCALAR|G_DISCARD, "iiP",  \
                                                 p1, p2, &p3 );              \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_VOID__INT_INT_WXSTRING( METHOD ) \
    DEC_V_CBACK_VOID__INT_INT_WXSTRING_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_INT_WXSTRING( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_INT_WXSTRING_( CLASS, BASE::METHOD(p1, p2, p3), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_INT_WXSTRING_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_INT_WXSTRING_( CLASS, return, METHOD, wxPli_NOCONST )

// wxString METH(int, int)
#define DEC_V_CBACK_WXSTRING__INT_INT_( METHOD, CONST ) \
    wxString METHOD( int, int ) CONST

#define DEF_V_CBACK_WXSTRING__INT_INT_( CLASS, CALLBASE, METHOD, CONST )     \
    wxString CLASS::METHOD( int param1, int param2 ) CONST                   \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )\
        {                                                                    \
            SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,  \
                                                         G_SCALAR, "ii",     \
                                                         param1, param2 );   \
            wxString val;                                                    \
            WXSTRING_INPUT( val, wxString, ret );                            \
            SvREFCNT_dec( ret );                                             \
            return val;                                                      \
        }                                                                    \
        else                                                                 \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_WXSTRING__INT_INT( METHOD ) \
    DEC_V_CBACK_WXSTRING__INT_INT_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_WXSTRING__INT_INT( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXSTRING__INT_INT_( CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_WXSTRING__INT_INT_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXSTRING__INT_INT_( CLASS, return wxEmptyString, METHOD, wxPli_NOCONST )

// wxString METH()
#define DEC_V_CBACK_WXSTRING__VOID_( METHOD, CONST ) \
    wxString METHOD() CONST

#define DEF_V_CBACK_WXSTRING__VOID_( CLASS, CALLBASE, METHOD, CONST )         \
    wxString CLASS::METHOD() CONST                                            \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) ) \
        {                                                                     \
            SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,   \
                                                         G_SCALAR );          \
            wxString val;                                                     \
            WXSTRING_INPUT( val, wxString, ret );                             \
            SvREFCNT_dec( ret );                                              \
            return val;                                                       \
        }                                                                     \
        else                                                                  \
            CALLBASE;                                                         \
    }

#define DEC_V_CBACK_WXSTRING__VOID( METHOD ) \
    DEC_V_CBACK_WXSTRING__VOID_( METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_WXSTRING__VOID_const( METHOD ) \
    DEC_V_CBACK_WXSTRING__VOID_( METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXSTRING__VOID( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXSTRING__VOID_( CLASS, return BASE::METHOD(), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_WXSTRING__VOID_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXSTRING__VOID_( CLASS, return BASE::METHOD(), METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXSTRING__VOID_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXSTRING__VOID_( CLASS, return wxEmptyString, METHOD, wxPli_NOCONST )

#endif // _WXPERL_V_CBACK_H

// Local variables: //
// mode: c++ //
// End: //
