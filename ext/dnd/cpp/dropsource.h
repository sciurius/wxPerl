/////////////////////////////////////////////////////////////////////////////
// Name:        ext/dnd/cpp/dropsource.h
// Purpose:     c++ wrapper for wxPliDropSource
// Author:      Mattia Barbon
// Modified by:
// Created:     16/08/2001
// RCS-ID:      $Id: dropsource.h,v 1.5 2004/12/21 21:12:48 mbarbon Exp $
// Copyright:   (c) 2001, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/dnd.h>
#include "cpp/v_cback.h"

class wxPliDropSource:public wxDropSource
{
    WXPLI_DECLARE_V_CBACK();
public:
#if defined( __WXMSW__ ) || defined( __WXMAC__ )
    wxPliDropSource( const char* package, wxWindow* win,
                     const wxCursor& c1, const wxCursor& c2,
                     const wxCursor& c3 )
        :wxDropSource( win, c1, c2, c3 ),
         m_callback( "Wx::DropSource" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ) );
    }

    wxPliDropSource( const char* package, wxDataObject& data, wxWindow* win,
                     const wxCursor& c1, const wxCursor& c2,
                     const wxCursor& c3 )
        :wxDropSource( data, win, c1, c2, c3 ),
         m_callback( "Wx::DropSource" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ) );
    }
#else
    wxPliDropSource( const char* package, wxWindow* win,
                     const wxIcon& c1, const wxIcon& c2,
                     const wxIcon& c3 )
        :wxDropSource( win, c1, c2, c3 ),
         m_callback( "Wx::DropSource" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ) );
    }

    wxPliDropSource( const char* package, wxDataObject& data, wxWindow* win,
                     const wxIcon& c1, const wxIcon& c2,
                     const wxIcon& c3 )
        :wxDropSource( data, win, c1, c2, c3 ),
         m_callback( "Wx::DropSource" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ) );
    }
#endif

    DEC_V_CBACK_BOOL__WXDRAGRESULT( GiveFeedback );
};

DEF_V_CBACK_BOOL__WXDRAGRESULT( wxPliDropSource, wxDropSource, GiveFeedback );

// Local variables: //
// mode: c++ //
// End: //

