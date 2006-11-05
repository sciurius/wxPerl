/////////////////////////////////////////////////////////////////////////////
// Name:        ext/richtext/RichText.xs
// Purpose:     XS for Wx::RichTextCtrl
// Author:      Mattia Barbon
// Modified by:
// Created:     05/11/2006
// RCS-ID:      $Id: RichText.xs,v 1.1 2006/11/05 16:28:01 mbarbon Exp $
// Copyright:   (c) 2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"
#include "cpp/overload.h"

#define wxNullColourPtr (wxColour*)&wxNullColour

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
    EVT( EVT_RICHTEXT_ITEM_SELECTED, 3, wxEVT_COMMAND_RICHTEXT_ITEM_SELECTED )
    EVT( EVT_RICHTEXT_ITEM_DESELECTED, 3, wxEVT_COMMAND_RICHTEXT_ITEM_DESELECTED )
    EVT( EVT_RICHTEXT_LEFT_CLICK, 3, wxEVT_COMMAND_RICHTEXT_LEFT_CLICK )
    EVT( EVT_RICHTEXT_RIGHT_CLICK, 3, wxEVT_COMMAND_RICHTEXT_RIGHT_CLICK )
    EVT( EVT_RICHTEXT_MIDDLE_CLICK, 3, wxEVT_COMMAND_RICHTEXT_MIDDLE_CLICK )
    EVT( EVT_RICHTEXT_LEFT_DCLICK, 3, wxEVT_COMMAND_RICHTEXT_LEFT_DCLICK )
    EVT( EVT_RICHTEXT_RETURN, 3, wxEVT_COMMAND_RICHTEXT_RETURN )
    EVT( EVT_RICHTEXT_STYLESHEET_CHANGING, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_CHANGING )
    EVT( EVT_RICHTEXT_STYLESHEET_CHANGED, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_CHANGED )
    EVT( EVT_RICHTEXT_STYLESHEET_REPLACING, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_REPLACING )
    EVT( EVT_RICHTEXT_STYLESHEET_REPLACED, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_REPLACED )
    { 0, 0, 0 }
};

MODULE=Wx__RichText

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextCtrl.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextAttr.xsp |

#include "cpp/ovl_const.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__RichText
