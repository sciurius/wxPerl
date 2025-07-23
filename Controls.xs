/////////////////////////////////////////////////////////////////////////////
// Name:        Controls.xs
// Purpose:     XS for Wx::Control and derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2013 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#include <wx/defs.h>

#include <wx/imaglist.h>
#include <wx/event.h>
#include <wx/colour.h>
#include <wx/listctrl.h>
#include <wx/treectrl.h>
#include <wx/ctrlsub.h>

// re-include for client data
#include "cpp/helpers.h"

#define wxDefaultValidatorPtr (wxValidator*)&wxDefaultValidator
#define wxBLACKPtr (wxColour*)wxBLACK
#define wxNORMAL_FONTPtr (wxFont*)wxNORMAL_FONT
#define wxNullBitmapPtr (wxBitmap*) &wxNullBitmap
#define wxNullAnimationPtr (wxAnimation*) &wxNullAnimation
#define wxNullColourPtr (wxColour*)&wxNullColour

#undef THIS

#include "cpp/v_cback.h"

#include "cpp/controls.h"
#include "cpp/controls.cpp"
#include "cpp/overload.h"

WXPLI_BOOT_ONCE(Wx_Ctrl);
#define boot_Wx_Ctrl wxPli_boot_Wx_Ctrl

MODULE=Wx_Ctrl PACKAGE=Wx::Control

void
wxControl::Command( event )
    wxCommandEvent* event
  CODE:
    THIS->Command( *event );

wxString
wxControl::GetLabelText()

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Control.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/ControlWithItems.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/bmpbuttn.h
INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/AnimationCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/EditableListBox.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/BookCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Listbook.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Choicebook.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Toolbook.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Treebook.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/HyperlinkCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/VListBox.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/SearchCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/ComboPopup.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/ComboCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/OwnerDrawnComboBox.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/CollapsiblePane.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/BitmapComboBox.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/DirCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/FileCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/generic/spinctrg.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/infobar.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/headerctrl.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/headercol.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/button.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/commandlinkbutton.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/treelist.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/richtooltip.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/bannerwindow.h

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp interface/wx/rearrangectrl.h

INCLUDE: XS/CheckBox.xs
INCLUDE: XS/CheckListBox.xs
INCLUDE: XS/Choice.xs
INCLUDE: XS/ComboBox.xs
INCLUDE: XS/Gauge.xs
INCLUDE: XS/ListBox.xs
INCLUDE: XS/ListCtrl.xs
INCLUDE: XS/Notebook.xs
INCLUDE: XS/RadioBox.xs
INCLUDE: XS/RadioButton.xs
INCLUDE: XS/ScrollBar.xs
INCLUDE: XS/Slider.xs
INCLUDE: XS/SpinButton.xs
INCLUDE: XS/SpinCtrl.xs
INCLUDE: XS/StaticBitmap.xs
INCLUDE: XS/StaticBox.xs
INCLUDE: XS/StaticLine.xs
INCLUDE: XS/StaticText.xs
INCLUDE: XS/ToggleButton.xs
INCLUDE: XS/TreeCtrl.xs

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/TextAttr.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/TextCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/PickerCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/ColourPickerCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/FilePickerCtrl.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/FontPickerCtrl.xsp

MODULE=Wx_Ctrl PACKAGE=Wx::Control
