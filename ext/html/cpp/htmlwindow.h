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
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliHtmlWindow );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliHtmlWindow, "Wx::HtmlWindow", TRUE );
    WXPLI_CONSTRUCTOR_6( wxPliHtmlWindow, "Wx::HtmlWIndow", TRUE,
                         wxWindow*, wxWindowID, const wxPoint&,
                         const wxSize&, long, const wxString& );

    void OnLinkClicked( const wxHtmlLinkInfo& info );
    void OnSetTitle( const wxString& title );
};

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

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliHtmlWindow, wxHtmlWindow );

// Local variables: //
// mode: c++ //
// End: //
