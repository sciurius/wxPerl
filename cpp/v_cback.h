/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/v_cback.h
// Purpose:     callback helper class for virtual functions
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2007 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_V_CBACK_H
#define _WXPERL_V_CBACK_H

#include <stddef.h>

class wxAutoSV
{
public:
    wxAutoSV( pTHX_ SV* sv )
        : m_sv( sv )
#ifdef MULTIPLICITY
        , vTHX( aTHX )
#endif
    { }
    ~wxAutoSV() { SvREFCNT_dec( m_sv ); }

    operator SV*() { return m_sv; }
    operator const SV*() const { return m_sv; }
    operator bool() const { return m_sv != NULL; }
    bool operator !() const { return m_sv == NULL; }
    SV* operator->() { return m_sv; }
    const SV* operator->() const { return m_sv; }
private:
    SV* m_sv;
#ifdef MULTIPLICITY
    #undef register
    #define register
    pTHX;
    #undef register
#endif
};

#define wxPliFCback wxPliVirtualCallback_FindCallback
#define wxPliCCback wxPliVirtualCallback_CallCallback

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
#define wxPli_VOID

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
        return false;                                                         \
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
        return false;                                                         \
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

// ANY METH(int, int)
#define DEC_V_CBACK_ANY__INT_INT_( RET, METHOD, CONST ) \
    RET METHOD( int, int ) CONST

#define DEF_V_CBACK_ANY__INT_INT_( RET, CVT, CLASS, CALLBASE, METHOD, CONST )\
    RET CLASS::METHOD( int param1, int param2 ) CONST                        \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )\
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,    \
                                        "ii", param1, param2 ) );            \
            return CVT;                                                      \
        } else                                                               \
            CALLBASE;                                                        \
    }

// ANY METH(int, int, int)
#define DEC_V_CBACK_ANY__INT_INT_INT_( RET, METHOD, CONST ) \
    RET METHOD( int, int, int ) CONST

#define DEF_V_CBACK_ANY__INT_INT_INT_( RET, CVT, CLASS, CALLBASE, METHOD, CONST )\
    RET CLASS::METHOD( int param1, int param2, int param3 ) CONST            \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )\
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,    \
                                        "iii", param1, param2, param3 ) );   \
            return CVT;                                                      \
        } else                                                               \
            CALLBASE;                                                        \
    }

// ANY METH(long, long)
#define DEC_V_CBACK_ANY__LONG_LONG_( RET, METHOD, CONST ) \
    RET METHOD( long, long ) CONST

#define DEF_V_CBACK_ANY__LONG_LONG_( RET, CVT, CLASS, CALLBASE, METHOD, CONST )\
    RET CLASS::METHOD( long param1, long param2 ) CONST                      \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )\
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,    \
                                        "ll", param1, param2 ) );            \
            return CVT;                                                      \
        } else                                                               \
            CALLBASE;                                                        \
    }

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
                                                         G_SCALAR, NULL );    \
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

// bool METH(int, int, const wxString&)
#define DEC_V_CBACK_BOOL__INT_INT_WXSTRING_( METHOD, CONST ) \
    bool METHOD( int, int, const wxString& ) CONST

#define DEF_V_CBACK_BOOL__INT_INT_WXSTRING_( CLASS, CALLBASE, METHOD, CONST )\
    bool CLASS::METHOD( int p1, int p2, const wxString& p3 ) CONST           \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,    \
                                             "iiP", p1, p2, &p3 ) );         \
            return SvTRUE( ret );                                            \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_BOOL__INT_INT_WXSTRING( METHOD ) \
    DEC_V_CBACK_BOOL__INT_INT_WXSTRING_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__INT_INT_WXSTRING( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__INT_INT_WXSTRING_( CLASS, return BASE::METHOD(p1, p2, p3), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__INT_INT_WXSTRING_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__INT_INT_WXSTRING_( CLASS, return false, METHOD, wxPli_NOCONST )

// ANY METH(size_t)
#define DEC_V_CBACK_ANY__SIZET_( RET, METHOD, CONST ) \
    RET METHOD( size_t ) CONST

#define DEF_V_CBACK_ANY__SIZET_( RET, CVT, CLASS, CALLBASE, METHOD, CONST )\
    RET CLASS::METHOD( size_t p1 ) CONST                                     \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,    \
                                             "L", p1 ) );                    \
            return CVT;                                                      \
        } else                                                               \
            CALLBASE;                                                        \
    }

// bool METH(size_t)
#define DEC_V_CBACK_BOOL__SIZET( METHOD ) \
    DEC_V_CBACK_ANY__SIZET_( bool, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__SIZET( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__SIZET_( bool, SvTRUE( ret ), CLASS, return BASE::METHOD(p1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__SIZET_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__SIZET_( bool, SvTRUE( ret ), CLASS, return false, METHOD, wxPli_NOCONST )

// wxCoord METH(size_t)
#define DEC_V_CBACK_WXCOORD__SIZET( METHOD ) \
    DEC_V_CBACK_ANY__SIZET_( wxCoord, METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_WXCOORD__SIZET_const( METHOD ) \
    DEC_V_CBACK_ANY__SIZET_( wxCoord, METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXCOORD__SIZET( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__SIZET_( wxCoord, SvIV( ret ), CLASS, return BASE::METHOD(p1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_WXCOORD__SIZET_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__SIZET_( wxCoord, SvIV( ret ), CLASS, return BASE::METHOD(p1), METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXCOORD__SIZET_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__SIZET_( wxCoord, SvIV( ret ), CLASS, return 0, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_WXCOORD__SIZET_const_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__SIZET_( wxCoord, SvIV( ret ), CLASS, return 0, METHOD, wxPli_CONST )

// bool METH(size_t, size_t)
#define DEC_V_CBACK_BOOL__SIZET_SIZET_( METHOD, CONST ) \
    bool METHOD( size_t, size_t ) CONST

#define DEF_V_CBACK_BOOL__SIZET_SIZET_( CLASS, CALLBASE, METHOD, CONST )\
    bool CLASS::METHOD( size_t p1, size_t p2 ) CONST                         \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,    \
                                             "LL", p1, p2 ) );               \
            return SvTRUE( ret );                                            \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_BOOL__SIZET_SIZET( METHOD ) \
    DEC_V_CBACK_BOOL__SIZET_SIZET_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__SIZET_SIZET( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__SIZET_SIZET_( CLASS, return BASE::METHOD(p1, p2), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__SIZET_SIZET_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__SIZET_SIZET_( CLASS, return false, METHOD, wxPli_NOCONST )

// ANY METH(const wxString&)
#define DEC_V_CBACK_ANY__WXSTRING_( RET, METHOD, CONST )                      \
    RET METHOD(const wxString&) CONST

#define DEF_V_CBACK_ANY__WXSTRING_( RET, CVT, CLASS, CALLBASE, METHOD, CONST )\
    RET CLASS::METHOD(const wxString& param1) CONST                           \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) ) \
        {                                                                     \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,     \
                                             "P", &param1 ) );                \
            return CVT;                                                       \
        }                                                                     \
        else                                                                  \
            CALLBASE;                                                         \
    }

// void METH(const wxString&)
#define DEC_V_CBACK_VOID__WXSTRING( METHOD )                                  \
    DEC_V_CBACK_ANY__WXSTRING_( void, METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_VOID__WXSTRING_const( METHOD ) \
    DEC_V_CBACK_ANY__WXSTRING_( void, METHOD, wxPli_CONST )

#define DEF_V_CBACK_VOID__WXSTRING( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__WXSTRING_( void, ;, CLASS, BASE::METHOD(param1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__WXSTRING_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__WXSTRING_( void, ;, CLASS, return, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__WXSTRING_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__WXSTRING_( void, ;, CLASS, BASE::METHOD(param1), METHOD, wxPli_CONST )

// bool METH(const wxString&)
#define DEC_V_CBACK_BOOL__WXSTRING( METHOD )                                  \
    DEC_V_CBACK_ANY__WXSTRING_( bool, METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_BOOL__WXSTRING_const( METHOD ) \
    DEC_V_CBACK_ANY__WXSTRING_( bool, METHOD, wxPli_CONST )

#define DEF_V_CBACK_BOOL__WXSTRING( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__WXSTRING_( bool, SvTRUE( ret ), CLASS, return BASE::METHOD(param1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__WXSTRING_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__WXSTRING_( bool, SvTRUE( ret ), CLASS, return false, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__WXSTRING_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__WXSTRING_( bool, SvTRUE( ret ), CLASS, return BASE::METHOD(param1), METHOD, wxPli_CONST )

// bool METH(wxObject*)
#define DEF_V_CBACK_BOOL__WXOBJECTs_( T1, CLASS, CALLBASE, METHOD, CONST )   \
    bool CLASS::METHOD( T1 p1 ) CONST                                        \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback,              \
                          G_SCALAR, "O", &p1 ) );                            \
            return SvTRUE( ret );                                            \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEF_V_CBACK_BOOL__WXOBJECTsP_( T1, CLASS, CALLBASE, METHOD, CONST )  \
    bool CLASS::METHOD( T1 p1 ) CONST                                        \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback,              \
                          G_SCALAR, "O", p1 ) );                             \
            return SvTRUE( ret );                                            \
        } else                                                               \
            CALLBASE;                                                        \
    }

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
                                                                              \
            wxString tmp; 	                                              \
            WXSTRING_INPUT( tmp, const char *, ret ); 	                      \
            param1 = tmp; 	                                              \
                                                                              \
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

// int METH(long, long)
#define DEC_V_CBACK_INT__LONG_LONG( METHOD ) \
    DEC_V_CBACK_ANY__LONG_LONG_( int, METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_INT__LONG_LONG_const( METHOD ) \
    DEC_V_CBACK_ANY__LONG_LONG_( int, METHOD, wxPli_CONST )

#define DEF_V_CBACK_INT__LONG_LONG( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__LONG_LONG_( int, SvIV( ret ), CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_INT__LONG_LONG_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__LONG_LONG_( int, SvIV( ret ), CLASS, return 0, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_INT__LONG_LONG_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__LONG_LONG_( int, SvIV( ret ), CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_CONST )

// double METH(int, int)
#define DEC_V_CBACK_DOUBLE__INT_INT( METHOD ) \
    DEC_V_CBACK_ANY__INT_INT_( double, METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_DOUBLE__INT_INT_const( METHOD ) \
    DEC_V_CBACK_ANY__INT_INT_( double, METHOD, wxPli_CONST )

#define DEF_V_CBACK_DOUBLE__INT_INT( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__INT_INT_( double, SvNV( ret ), CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_DOUBLE__INT_INT_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__INT_INT_( double, SvNV( ret ), CLASS, return 0, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_DOUBLE__INT_INT_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__INT_INT_( double, SvNV( ret ), CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_CONST )

// ANY METH()
#define DEC_V_CBACK_ANY__VOID_( RET, METHOD, CONST )                          \
    RET METHOD() CONST

#define DEF_V_CBACK_ANY__VOID_( RET, CVT, CLASS, CALLBASE, METHOD, CONST ) \
    RET CLASS::METHOD() CONST                                                 \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                       \
        {                                                                     \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,     \
                                             NULL ) );                        \
            return CVT;                                                       \
        }                                                                     \
        else                                                                  \
            CALLBASE;                                                         \
    }

// int METH()
#define DEC_V_CBACK_INT__VOID( METHOD ) \
    DEC_V_CBACK_ANY__VOID_( int, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_INT__VOID( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__VOID_( int, SvIV( ret ), CLASS, return BASE::METHOD(), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_INT__VOID_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__VOID_( int, SvIV( ret ), CLASS, return 0, METHOD, wxPli_NOCONST )

// wxCoord METH()
#define DEC_V_CBACK_WXCOORD__VOID_const( METHOD ) \
    DEC_V_CBACK_ANY__VOID_( wxCoord, METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXCOORD__VOID_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__VOID_( wxCoord, SvIV( ret ), CLASS, return BASE::METHOD(), METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXCOORD__VOID_const_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__VOID_( wxCoord, SvIV( ret ), CLASS, return 0, METHOD, wxPli_CONST )

// long METH(int, int)
#define DEC_V_CBACK_LONG__INT_INT( METHOD ) \
    DEC_V_CBACK_ANY__INT_INT_( long, METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_LONG__INT_INT_const( METHOD ) \
    DEC_V_CBACK_ANY__INT_INT_( long, METHOD, wxPli_CONST )

#define DEF_V_CBACK_LONG__INT_INT( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__INT_INT_( long, SvIV( ret ), CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_LONG__INT_INT_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__INT_INT_( long, SvIV( ret ), CLASS, return false, METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_LONG__INT_INT_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__INT_INT_( long, SvIV( ret ), CLASS, return BASE::METHOD(param1, param2), METHOD, wxPli_CONST )

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
                                                 G_SCALAR|G_DISCARD, NULL );  \
        } else                                                                \
            CALLBASE;                                                         \
    }

#define DEC_V_CBACK_VOID__VOID( METHOD ) \
    DEC_V_CBACK_VOID__VOID_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__VOID( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__VOID_( CLASS, BASE::METHOD(), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__VOID_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__VOID_( CLASS, return, METHOD, wxPli_NOCONST )

// void METH(int, int, bool)
#define DEC_V_CBACK_VOID__INT_INT_BOOL_( METHOD, CONST ) \
    void METHOD( int, int, bool ) CONST

#define DEF_V_CBACK_VOID__INT_INT_BOOL_( CLASS, CALLBASE, METHOD, CONST )\
    void CLASS::METHOD( int p1, int p2, bool p3 ) CONST                      \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxPliCCback( aTHX_ &m_callback, G_SCALAR|G_DISCARD, "iib",       \
                         p1, p2, p3 );                                       \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_VOID__INT_INT_BOOL( METHOD ) \
    DEC_V_CBACK_VOID__INT_INT_BOOL_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_INT_BOOL( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_INT_BOOL_( CLASS, BASE::METHOD(p1, p2, p3), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_INT_BOOL_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_INT_BOOL_( CLASS, return, METHOD, wxPli_NOCONST )

// void METH(int, int, double)
#define DEC_V_CBACK_VOID__INT_INT_DOUBLE_( METHOD, CONST ) \
    void METHOD( int, int, double ) CONST

#define DEF_V_CBACK_VOID__INT_INT_DOUBLE_( CLASS, CALLBASE, METHOD, CONST )\
    void CLASS::METHOD( int p1, int p2, double p3 ) CONST                    \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxPliCCback( aTHX_ &m_callback, G_SCALAR|G_DISCARD, "iid",       \
                         p1, p2, p3 );                                       \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_VOID__INT_INT_DOUBLE( METHOD ) \
    DEC_V_CBACK_VOID__INT_INT_DOUBLE_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_INT_DOUBLE( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_INT_DOUBLE_( CLASS, BASE::METHOD(p1, p2, p3), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_INT_DOUBLE_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_INT_DOUBLE_( CLASS, return, METHOD, wxPli_NOCONST )

// void METH(int, int, long)
#define DEC_V_CBACK_VOID__INT_INT_LONG_( METHOD, CONST ) \
    void METHOD( int, int, long ) CONST

#define DEF_V_CBACK_VOID__INT_INT_LONG_( CLASS, CALLBASE, METHOD, CONST )\
    void CLASS::METHOD( int p1, int p2, long p3 ) CONST                      \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxPliCCback( aTHX_ &m_callback, G_SCALAR|G_DISCARD, "iil",       \
                         p1, p2, p3 );                                       \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_VOID__INT_INT_LONG( METHOD ) \
    DEC_V_CBACK_VOID__INT_INT_LONG_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_INT_LONG( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_INT_LONG_( CLASS, BASE::METHOD(p1, p2, p3), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_INT_LONG_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_INT_LONG_( CLASS, return, METHOD, wxPli_NOCONST )

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

// void METH(int, const wxString&)
#define DEC_V_CBACK_VOID__INT_WXSTRING_( METHOD, CONST ) \
    void METHOD( int, const wxString& ) CONST

#define DEF_V_CBACK_VOID__INT_WXSTRING_( CLASS, CALLBASE, METHOD, CONST )\
    void CLASS::METHOD( int p1, const wxString& p2 ) CONST                   \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxPliCCback( aTHX_ &m_callback, G_SCALAR|G_DISCARD,              \
                         "iP", p1, &p2 );                                    \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_VOID__INT_WXSTRING( METHOD ) \
    DEC_V_CBACK_VOID__INT_WXSTRING_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_WXSTRING( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_WXSTRING_( CLASS, BASE::METHOD(p1, p2), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_WXSTRING_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_WXSTRING_( CLASS, return, METHOD, wxPli_NOCONST )

// void METH(wxGrid*)
#define DEC_V_CBACK_VOID__WXGRID_( METHOD, CONST ) \
    void METHOD( wxGrid* ) CONST

#define DEF_V_CBACK_VOID__WXGRID_( CLASS, CALLBASE, METHOD, CONST ) \
    DEF_V_CBACK_VOID__WXOBJECTsP_( wxGrid*, CLASS, CALLBASE, METHOD, CONST )

#define DEC_V_CBACK_VOID__WXGRID( METHOD ) \
    DEC_V_CBACK_VOID__WXGRID_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__WXGRID( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__WXOBJECTsP_( wxGrid*, CLASS, BASE::METHOD(p1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__WXGRID_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__WXOBJECTsP_( wxGrid*, CLASS, return, METHOD, wxPli_NOCONST )

// void METH(wxWindow*)
#define DEC_V_CBACK_VOID__WXWINDOW_( METHOD, CONST ) \
    void METHOD( wxWindow* ) CONST

#define DEF_V_CBACK_VOID__WXWINDOW_( CLASS, CALLBASE, METHOD, CONST ) \
    DEF_V_CBACK_VOID__WXOBJECTsP_( wxWindow*, CLASS, CALLBASE, METHOD, CONST )

#define DEC_V_CBACK_VOID__WXWINDOW( METHOD ) \
    DEC_V_CBACK_VOID__WXWINDOW_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__WXWINDOW( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__WXOBJECTsP_( wxWindow*, CLASS, BASE::METHOD(p1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__WXWINDOW_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__WXOBJECTsP_( wxWindow*, CLASS, return, METHOD, wxPli_NOCONST )

// bool METH(wxWindow*)
#define DEC_V_CBACK_BOOL__WXWINDOW_( METHOD, CONST ) \
    bool METHOD( wxWindow* ) CONST

#define DEF_V_CBACK_BOOL__WXWINDOW_( CLASS, CALLBASE, METHOD, CONST ) \
    DEF_V_CBACK_BOOL__WXOBJECTsP_( wxWindow*, CLASS, CALLBASE, METHOD, CONST )

#define DEC_V_CBACK_BOOL__WXWINDOW( METHOD ) \
    DEC_V_CBACK_BOOL__WXWINDOW_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__WXWINDOW( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__WXOBJECTsP_( wxWindow*, CLASS, BASE::METHOD(p1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_BOOL__WXWINDOW_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_BOOL__WXOBJECTsP_( wxWindow*, CLASS, return false, METHOD, wxPli_NOCONST )

// void METH(wxObject*)
#define DEF_V_CBACK_VOID__WXOBJECTsP_( T1, CLASS, CALLBASE, METHOD, CONST )  \
    void CLASS::METHOD( T1 p1 ) CONST                                        \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxPliCCback( aTHX_ &m_callback, G_SCALAR|G_DISCARD, "O", p1 );   \
        } else                                                               \
            CALLBASE;                                                        \
    }

// wxGrid* METH()
#define DEC_V_CBACK_WXGRID__VOID_( METHOD, CONST ) \
    wxGrid* METHOD() CONST

#define DEF_V_CBACK_WXGRID__VOID_( CLASS, CALLBASE, METHOD, CONST ) \
    DEF_V_CBACK_WXOBJECTsP__VOID_( wxGrid*, Wx::Grid, CLASS, CALLBASE, METHOD, CONST )

#define DEC_V_CBACK_WXGRID__VOID_const( METHOD ) \
    DEC_V_CBACK_WXGRID__VOID_( METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXGRID__VOID_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXGRID__VOID_( CLASS, return BASE::METHOD(), METHOD, wxPli_CONST )

// wxWindow* METH()
#define DEC_V_CBACK_WXWINDOW__VOID_( METHOD, CONST ) \
    wxWindow* METHOD() CONST

#define DEF_V_CBACK_WXWINDOW__VOID_( CLASS, CALLBASE, METHOD, CONST ) \
    DEF_V_CBACK_WXOBJECTsP__VOID_( wxWindow*, Wx::Window, CLASS, CALLBASE, METHOD, CONST )

#define DEC_V_CBACK_WXWINDOW__VOID( METHOD ) \
    DEC_V_CBACK_WXWINDOW__VOID_( METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_WXWINDOW__VOID_const( METHOD ) \
    DEC_V_CBACK_WXWINDOW__VOID_( METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXWINDOW__VOID_const( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXWINDOW__VOID_( CLASS, return BASE::METHOD(), METHOD, wxPli_CONST )

#define DEF_V_CBACK_WXWINDOW__VOID_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXWINDOW__VOID_( CLASS, return NULL, METHOD, wxPli_NOCONST )

// wxObject* METH()
#define DEF_V_CBACK_WXOBJECTsP__VOID_( TR, TRC, CLASS, CALLBASE, METHOD, CONST )\
    TR CLASS::METHOD() CONST                                                 \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,    \
                                             NULL ) );                       \
            return (TR)wxPli_sv_2_object( aTHX_ ret, #TRC );                 \
        } else                                                               \
            CALLBASE;                                                        \
    }

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
                                                         G_SCALAR, NULL );    \
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

#define DEF_V_CBACK_WXSTRING__VOID_const_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXSTRING__VOID_( CLASS, return wxEmptyString, METHOD, wxPli_CONST )

// wxString METH(int)
#define DEC_V_CBACK_WXSTRING__INT_( METHOD, CONST ) \
    wxString METHOD( int ) CONST

#define DEF_V_CBACK_WXSTRING__INT_( CLASS, CALLBASE, METHOD, CONST )         \
    wxString CLASS::METHOD( int p1 ) CONST                                   \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,    \
                                             "i", p1 ) );                    \
            wxString val;                                                    \
            WXSTRING_INPUT( val, wxString, ret );                            \
            return val;                                                      \
        }                                                                    \
        else                                                                 \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_WXSTRING__INT( METHOD ) \
    DEC_V_CBACK_WXSTRING__INT_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_WXSTRING__INT( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXSTRING__INT_( CLASS, return BASE::METHOD(p1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_WXSTRING__INT_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_WXSTRING__INT_( CLASS, return wxEmptyString, METHOD, wxPli_NOCONST )

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

// ANY METH( wxKeyEvent& )
#define DEC_V_CBACK_ANY__WXKEYEVENT_( RET, METHOD, CONST ) \
  RET METHOD( wxKeyEvent& event ) CONST

#define DEF_V_CBACK_ANY__WXKEYEVENT_( RET, CVT, CLASS, CALLBASE, METHOD, CONST )\
    RET CLASS::METHOD( wxKeyEvent& param1 ) CONST                             \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) ) \
        {                                                                     \
            SV* evt = wxPli_object_2_sv( aTHX_ newSViv( 0 ), &param1 );       \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,     \
                                             "S", evt ) );                    \
            sv_setiv( SvRV( evt ), 0 );                                       \
            SvREFCNT_dec( evt );                                              \
            return CVT;                                                       \
        } else                                                                \
            CALLBASE;                                                         \
    }


#endif // _WXPERL_V_CBACK_H

// Local variables: //
// mode: c++ //
// End: //
