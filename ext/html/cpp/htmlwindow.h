/////////////////////////////////////////////////////////////////////////////
// Name:        ext/html/cpp/htmlwindow.h
// Purpose:     C++ wrapper for Wx::HtmlWindow
// Author:      Mattia Barbon
// Modified by:
// Created:     18/03/2001
// RCS-ID:      $Id: htmlwindow.h,v 1.7 2004/03/01 21:24:10 mbarbon Exp $
// Copyright:   (c) 2001-2002 Mattia Barbon
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

    // this fixes the crashes, for some reason
    wxPliHtmlWindow( const char* package, wxWindow* _arg1, wxWindowID _arg2,
                     const wxPoint& _arg3, const wxSize& _arg4, long _arg5,
                     const wxString& _arg6 )
        : wxHtmlWindow( _arg1, _arg2, _arg3, _arg4, _arg5, _arg6 ),
          m_callback( "Wx::HtmlWindow" )
     {
         m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
     }

    void OnLinkClicked( const wxHtmlLinkInfo& info );
    void OnSetTitle( const wxString& title );
};

void wxPliHtmlWindow::OnLinkClicked( const wxHtmlLinkInfo& info )
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback,
                                           "OnLinkClicked" ) )
    {
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                           G_SCALAR|G_DISCARD, "o", &info,
                                           "Wx::HtmlLinkInfo" );
    } else
        wxHtmlWindow::OnLinkClicked( info );
}

void wxPliHtmlWindow::OnSetTitle( const wxString& title )
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "OnSetTitle" ) )
    {
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                           G_SCALAR|G_DISCARD,
                                           "p", title.c_str() );
    } else
        wxHtmlWindow::OnSetTitle( title );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliHtmlWindow, wxHtmlWindow );

// Local variables: //
// mode: c++ //
// End: //
