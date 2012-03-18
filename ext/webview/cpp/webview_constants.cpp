/////////////////////////////////////////////////////////////////////////////
// Name:        webview_constants.cpp
// Purpose:     wxWebView constants
// Author:      Mark Dootson
// SVN ID:      $Id:  $
// Copyright:   (c) 2012 Mattia barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <cpp/constants.h>
#include <wx/webview.h>
#include <wx/webviewarchivehandler.h>

double webview_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: webview
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'W':
        r( wxWEB_VIEW_ZOOM_TINY );
        r( wxWEB_VIEW_ZOOM_SMALL );
        r( wxWEB_VIEW_ZOOM_MEDIUM );
        r( wxWEB_VIEW_ZOOM_LARGE );
        r( wxWEB_VIEW_ZOOM_LARGEST );
        r( wxWEB_VIEW_ZOOM_TYPE_LAYOUT );
        r( wxWEB_VIEW_ZOOM_TYPE_TEXT );
        r( wxWEB_NAV_ERR_CONNECTION );
        r( wxWEB_NAV_ERR_CERTIFICATE );
        r( wxWEB_NAV_ERR_AUTH );
        r( wxWEB_NAV_ERR_SECURITY );
        r( wxWEB_NAV_ERR_NOT_FOUND );
        r( wxWEB_NAV_ERR_REQUEST );
        r( wxWEB_NAV_ERR_USER_CANCELLED );
        r( wxWEB_NAV_ERR_OTHER );
        r( wxWEB_VIEW_RELOAD_DEFAULT );
        r( wxWEB_VIEW_RELOAD_NO_CACHE );
        r( wxWEB_VIEW_BACKEND_DEFAULT );
        r( wxWEB_VIEW_BACKEND_WEBKIT );
        r( wxWEB_VIEW_BACKEND_IE );
          
        break;
    default:
        break;
    }

    
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants webview_module( &webview_constant );

