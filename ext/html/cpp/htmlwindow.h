/////////////////////////////////////////////////////////////////////////////
// Name:        htmlwindow.h
// Purpose:     C++ wrapper for Wx::HtmlWindow
// Author:      Mattia Barbon
// Modified by:
// Created:     18/ 3/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/v_cback.h"

class wxPliHtmlWindow:public wxHtmlWindow
{
    _DECLARE_DYNAMIC_CLASS( wxPliHtmlWindow );
    _DECLARE_V_CBACK();
public:
    wxPliHtmlWindow( const char* package, wxWindow* parent, wxWindowID id,
                     const wxPoint& pos, const wxSize& size, long style,
                     const wxString& name );

    void OnLinkClicked( const wxHtmlLinkInfo& info );
    void OnSetTitle( const wxString& title );
};

inline wxPliHtmlWindow::wxPliHtmlWindow( const char* package,
                                         wxWindow* parent, wxWindowID id,
                                         const wxPoint& pos,
                                         const wxSize& size, long style,
                                         const wxString& name )
    :m_callback( "Wx::HtmlWindow" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

void wxPliHtmlWindow::OnLinkClicked( const wxHtmlLinkInfo& info )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "OnLinkClicked" ) )
    {
        wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR|G_DISCARD,
                                           "o", new wxHtmlLinkInfo( info ),
                                           "Wx::HtmlLinkInfo" );
    } else
        wxHtmlWindow::OnLinkClicked( info );
}

void wxPliHtmlWindow::OnSetTitle( const wxString& title )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "OnSetTitle" ) )
    {
        wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR|G_DISCARD,
                                           "p", title.c_str() );
    } else
        wxHtmlWindow::OnSetTitle( title );
}

_IMPLEMENT_DYNAMIC_CLASS( wxPliHtmlWindow, wxHtmlWindow );

// Local variables: //
// mode: c++ //
// End: //
