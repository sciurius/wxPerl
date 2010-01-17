/////////////////////////////////////////////////////////////////////////////
// Name:        ext/aui/AUI.xs
// Purpose:     XS for Wx::AUI
// Author:      Mattia Barbon
// Modified by:
// Created:     11/11/2006
// RCS-ID:      $Id$
// Copyright:   (c) 2006, 2008-2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"
#include "cpp/overload.h"

#define wxNullBitmapPtr (wxBitmap*)&wxNullBitmap

#undef THIS

#include <wx/aui/framemanager.h>
#include <wx/aui/auibook.h>

// event macros
#define SEVT( NAME, ARGS )    wxPli_StdEvent( NAME, ARGS )
#define EVT( NAME, ARGS, ID ) wxPli_Event( NAME, ARGS, ID )

// !package: Wx::Event
// !tag:
// !parser: sub { $_[0] =~ m<^\s*S?EVT\(\s*(\w+)\s*\,> }

#if WXPERL_W_VERSION_LT( 2, 8, 0 )
#define wxEVT_AUI_PANE_BUTTON   wxEVT_AUI_PANEBUTTON
#define wxEVT_AUI_PANE_CLOSE    wxEVT_AUI_PANECLOSE
#define wxEVT_AUI_PANE_MAXIMIZE wxEVT_AUI_PANEMAXIMIZE
#define wxEVT_AUI_PANE_RESTORE  wxEVT_AUI_PANERESTORE
#endif

static wxPliEventDescription evts[] =
{
    SEVT( EVT_AUI_PANE_BUTTON, 2 )
    SEVT( EVT_AUI_PANE_CLOSE, 2 )
    SEVT( EVT_AUI_PANE_MAXIMIZE, 2 )
    SEVT( EVT_AUI_PANE_RESTORE, 2 )
    SEVT( EVT_AUI_RENDER, 2 )
    EVT( EVT_AUINOTEBOOK_PAGE_CLOSE, 3, wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE )
    EVT( EVT_AUINOTEBOOK_PAGE_CHANGED, 3, wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED )
    EVT( EVT_AUINOTEBOOK_PAGE_CHANGING, 3, wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING )
    EVT( EVT_AUINOTEBOOK_BUTTON, 3, wxEVT_COMMAND_AUINOTEBOOK_BUTTON )
    EVT( EVT_AUINOTEBOOK_BEGIN_DRAG, 3, wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG )
    EVT( EVT_AUINOTEBOOK_END_DRAG, 3, wxEVT_COMMAND_AUINOTEBOOK_END_DRAG )
    EVT( EVT_AUINOTEBOOK_DRAG_MOTION, 3, wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION )
    EVT( EVT_AUINOTEBOOK_ALLOW_DND, 3, wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND )
    { 0, 0, 0 }
};

MODULE=Wx__AUI

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/AuiManager.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/AuiPaneInfo.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/AuiNotebook.xsp

MODULE=Wx__AUI PACKAGE=Wx::AUI

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

MODULE=Wx__AUI
