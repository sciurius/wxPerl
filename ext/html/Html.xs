/////////////////////////////////////////////////////////////////////////////
// Name:        ext/html/Html.xs
// Purpose:     XS for Wx::Html*
// Author:      Mattia Barbon
// Modified by:
// Created:     10/03/2001
// RCS-ID:      $Id$
// Copyright:   (c) 2001-2004, 2006, 2008-2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include <wx/html/htmlwin.h>

#undef THIS

#define wxDefaultValidatorPtr (wxValidator*)&wxDefaultValidator

// event macros
#define SEVT( NAME, ARGS )    wxPli_StdEvent( NAME, ARGS )
#define EVT( NAME, ARGS, ID ) wxPli_Event( NAME, ARGS, ID )

// !package: Wx::Event
// !tag:
// !parser: sub { $_[0] =~ m<^\s*S?EVT\(\s*(\w+)\s*\,> }

static wxPliEventDescription evts[] =
{
    EVT( EVT_HTML_CELL_CLICKED, 3, wxEVT_COMMAND_HTML_CELL_CLICKED )
    EVT( EVT_HTML_CELL_HOVER, 3, wxEVT_COMMAND_HTML_CELL_HOVER )
    EVT( EVT_HTML_LINK_CLICKED, 3, wxEVT_COMMAND_HTML_LINK_CLICKED )
    { 0, 0, 0 }
};

MODULE=Wx__Html

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/HtmlWindow.xsp

INCLUDE: XS/HtmlHelpController.xs

#if wxPERL_USE_PRINTING_ARCHITECTURE

INCLUDE: XS/HtmlEasyPrinting.xs
INCLUDE: XS/HtmlDCRenderer.xs

#endif

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/HtmlParser.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/HtmlTagHandler.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/HtmlTag.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/HtmlCell.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/HtmlListBox.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/HtmlPrintout.xsp

#include "cpp/ht_constants.cpp"
#include "cpp/ovl_const.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Html
