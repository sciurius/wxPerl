/////////////////////////////////////////////////////////////////////////////
// Name:        Controls.xs
// Purpose:     XS for Wx::Control and derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: Controls.xs,v 1.21 2003/05/12 17:00:23 mbarbon Exp $
// Copyright:   (c) 2000-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#include <wx/defs.h>

#include <wx/button.h>
#include <wx/listbox.h>
#include <wx/radiobut.h>
#include <wx/radiobox.h>
#include <wx/choice.h>
#include <wx/combobox.h>
#include <wx/scrolbar.h>
#include <wx/statbox.h>
#include <wx/stattext.h>
#include <wx/textctrl.h>
#include <wx/checkbox.h>
#include <wx/notebook.h>
#include <wx/gauge.h>
#include <wx/checklst.h>
#include <wx/bmpbuttn.h>
#include <wx/statbmp.h>
#include <wx/slider.h>
#include <wx/spinbutt.h>
#include <wx/spinctrl.h>
#include <wx/statline.h>
#include <wx/imaglist.h>
#include <wx/listctrl.h>
#include <wx/treectrl.h>

// needs to be here to see #defines
#include "cpp/typedef.h"

// re-include for client data
#include "cpp/helpers.h"

#include <wx/tglbtn.h>

#undef THIS

#include "cpp/v_cback.h"

#include "cpp/controls.h"
#include "cpp/controls.cpp"
#include "cpp/overload.h"

WXPLI_BOOT_ONCE(Wx_Ctrl);
#define boot_Wx_Ctrl wxPli_boot_Wx_Ctrl

MODULE=Wx_Ctrl PACKAGE=Wx::Control

void
Wx_Control::Command( event )
    Wx_CommandEvent* event
  CODE:
    THIS->Command( *event );

MODULE=Wx_Ctrl PACKAGE=Wx::ControlWithItems

void
Wx_ControlWithItems::Append( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_s_s, AppendData )
        MATCH_REDISP( wxPliOvl_s, AppendString )
    END_OVERLOAD( Wx::ControlWithItems::Append )

void
Wx_ControlWithItems::AppendString( item )
    wxString item
  CODE:
    THIS->Append( item );

void
Wx_ControlWithItems::AppendData( item, data )
    wxString item
    Wx_UserDataCD* data
  CODE:
    THIS->Append( item, data );

void
Wx_ControlWithItems::Delete( n )
    int n

int
Wx_ControlWithItems::FindString( string )
    wxString string

int
Wx_ControlWithItems::GetCount()

int
Wx_ControlWithItems::GetSelection()

wxString
Wx_ControlWithItems::GetString( n )
    int n

wxString
Wx_ControlWithItems::GetStringSelection()

Wx_UserDataCD*
Wx_ControlWithItems::GetClientData( n )
    int n
  CODE:
    RETVAL = (Wx_UserDataCD*) THIS->GetClientObject( n );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 0 )

bool
wxControlWithItems::IsEmpty()

#endif

void
Wx_ControlWithItems::SetClientData( n, data )
    int n
    Wx_UserDataCD* data
  CODE:
    THIS->SetClientObject( n, data );

INCLUDE: XS/BitmapButton.xs
INCLUDE: XS/Button.xs
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
INCLUDE: XS/TextCtrl.xs
INCLUDE: XS/TreeCtrl.xs

MODULE=Wx_Ctrl PACKAGE=Wx::Control
