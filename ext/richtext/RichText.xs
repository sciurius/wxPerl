/////////////////////////////////////////////////////////////////////////////
// Name:        ext/richtext/RichText.xs
// Purpose:     XS for Wx::RichTextCtrl
// Author:      Mattia Barbon
// Modified by:
// Created:     05/11/2006
// RCS-ID:      $Id$
// Copyright:   (c) 2006-2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"
#include "cpp/overload.h"

#define wxNullColourPtr (wxColour*)&wxNullColour
#define wxNullFontPtr (wxFont*)&wxNullFont

#undef THIS

#include <wx/richtext/richtextctrl.h>

// event macros
#define SEVT( NAME, ARGS )    wxPli_StdEvent( NAME, ARGS )
#define EVT( NAME, ARGS, ID ) wxPli_Event( NAME, ARGS, ID )

// !package: Wx::Event
// !tag:
// !parser: sub { $_[0] =~ m<^\s*S?EVT\(\s*(\w+)\s*\,> }

static wxPliEventDescription evts[] =
{
    EVT( EVT_RICHTEXT_LEFT_CLICK, 3, wxEVT_COMMAND_RICHTEXT_LEFT_CLICK )
    EVT( EVT_RICHTEXT_RIGHT_CLICK, 3, wxEVT_COMMAND_RICHTEXT_RIGHT_CLICK )
    EVT( EVT_RICHTEXT_MIDDLE_CLICK, 3, wxEVT_COMMAND_RICHTEXT_MIDDLE_CLICK )
    EVT( EVT_RICHTEXT_LEFT_DCLICK, 3, wxEVT_COMMAND_RICHTEXT_LEFT_DCLICK )
    EVT( EVT_RICHTEXT_RETURN, 3, wxEVT_COMMAND_RICHTEXT_RETURN )
    EVT( EVT_RICHTEXT_STYLESHEET_CHANGING, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_CHANGING )
    EVT( EVT_RICHTEXT_STYLESHEET_CHANGED, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_CHANGED )
    EVT( EVT_RICHTEXT_STYLESHEET_REPLACING, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_REPLACING )
    EVT( EVT_RICHTEXT_STYLESHEET_REPLACED, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_REPLACED )
    EVT( EVT_RICHTEXT_CHARACTER, 3, wxEVT_COMMAND_RICHTEXT_CHARACTER )
    EVT( EVT_RICHTEXT_DELETE, 3, wxEVT_COMMAND_RICHTEXT_DELETE )
    EVT( EVT_RICHTEXT_STYLE_CHANGED, 3, wxEVT_COMMAND_RICHTEXT_STYLE_CHANGED )
    EVT( EVT_RICHTEXT_CONTENT_INSERTED, 3, wxEVT_COMMAND_RICHTEXT_CONTENT_INSERTED )
    EVT( EVT_RICHTEXT_CONTENT_DELETED, 3, wxEVT_COMMAND_RICHTEXT_CONTENT_DELETED )
    { 0, 0, 0 }
};

#define wxPliRichTextStyleType wxRichTextStyleListBox::wxRichTextStyleType

MODULE=Wx__RichText

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextCtrl.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextAttr.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextStyle.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextStyleCtrl.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextFormattingDialog.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextFileHandler.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextBuffer.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/SymbolPickerDialog.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextStyleOrganiserDialog.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RichTextPrinting.xsp

MODULE=Wx__RichText PACKAGE=Wx::RichText

void
SetEvents()
  CODE:
    wxPli_set_events( evts );

#include "cpp/ovl_const.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__RichText
