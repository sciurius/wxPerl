/////////////////////////////////////////////////////////////////////////////
// Name:        ext/richtext/RichText.xs
// Purpose:     XS for Wx::RichTextCtrl
// Author:      Mattia Barbon
// Modified by:
// Created:     05/11/2006
// RCS-ID:      $Id$
// Copyright:   (c) 2006-2007 Mattia Barbon
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
#if WXPERL_W_VERSION_LE( 2, 7, 2 )
    EVT( EVT_RICHTEXT_ITEM_SELECTED, 3, wxEVT_COMMAND_RICHTEXT_ITEM_SELECTED )
    EVT( EVT_RICHTEXT_ITEM_DESELECTED, 3, wxEVT_COMMAND_RICHTEXT_ITEM_DESELECTED )
#endif
    EVT( EVT_RICHTEXT_LEFT_CLICK, 3, wxEVT_COMMAND_RICHTEXT_LEFT_CLICK )
    EVT( EVT_RICHTEXT_RIGHT_CLICK, 3, wxEVT_COMMAND_RICHTEXT_RIGHT_CLICK )
    EVT( EVT_RICHTEXT_MIDDLE_CLICK, 3, wxEVT_COMMAND_RICHTEXT_MIDDLE_CLICK )
    EVT( EVT_RICHTEXT_LEFT_DCLICK, 3, wxEVT_COMMAND_RICHTEXT_LEFT_DCLICK )
    EVT( EVT_RICHTEXT_RETURN, 3, wxEVT_COMMAND_RICHTEXT_RETURN )
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
    EVT( EVT_RICHTEXT_STYLESHEET_CHANGING, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_CHANGING )
    EVT( EVT_RICHTEXT_STYLESHEET_CHANGED, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_CHANGED )
    EVT( EVT_RICHTEXT_STYLESHEET_REPLACING, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_REPLACING )
    EVT( EVT_RICHTEXT_STYLESHEET_REPLACED, 3, wxEVT_COMMAND_RICHTEXT_STYLESHEET_REPLACED )
#endif
    { 0, 0, 0 }
};

#define wxPliRichTextStyleType wxRichTextStyleListBox::wxRichTextStyleType
#if WXPERL_W_VERSION_LT( 2, 8, 0 )
#undef _
#define _( s ) wxT( s )
#endif

MODULE=Wx__RichText

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextCtrl.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextAttr.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextStyle.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextStyleCtrl.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextFormattingDialog.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextFileHandler.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/RichTextBuffer.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/SymbolPickerDialog.xsp |

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
