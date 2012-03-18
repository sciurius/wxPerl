#############################################################################
## Name:        ext/webview/Makefile.PL
## Purpose:     Makefile.PL for wxWebView
## Author:      Mark Dootson
## Modified by:
## Created:     17/03/2012
## SVN-ID:      $Id$
## Copyright:   (c) 2012 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::WebView',
                 VERSION_FROM => 'lib/Wx/WebView.pm',
                 REQUIRE_WX   => 2.009003,
                 WX_CORE_LIB  => 'webview core base',
                 REQUIRE_WX_LIB  => 'webview',
                 NO_WX_PLATFORMS => [ ],
                 );
