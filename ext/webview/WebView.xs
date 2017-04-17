/////////////////////////////////////////////////////////////////////////////
// Name:        ext/webview/WebView.xs
// Purpose:     XS for Wx::WebView
// Author:      Mark Dootson
// Modified by:
// Created:     17/03/2012
// SVN-ID:      $Id: $
// Copyright:   (c) 2012 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

MODULE=Wx__WebView

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

#if WXPERL_W_VERSION_GE( 2, 9, 3 )

#if WXPERL_W_VERSION_GE( 3, 0, 0)

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/WebViewV3.xsp

#else

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/WebViewV2.xsp

#endif

#endif

#include "cpp/overload.h"
#include "cpp/ovl_const.cpp"
#include "cpp/constants.h"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__WebView
