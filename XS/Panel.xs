#############################################################################
## Name:        Panel.xs
## Purpose:     XS for Wx::Panel
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/panel.h>
#include "cpp/panel.h"

MODULE=Wx PACKAGE=Wx::Panel

Wx_Panel*
Wx_Panel::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTAB_TRAVERSAL, name = wxPanelNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new _wxPanel( CLASS, parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

Wx_Button*
Wx_Panel::GetDefaultItem()
  CODE:
    RETVAL = (Wx_Button*)THIS->GetDefaultItem();
  OUTPUT:
    RETVAL

void
Wx_Panel::InitDialog()

void
Wx_Panel::SetDefaultItem( btn )
    Wx_Button* btn

bool
Wx_Panel::TransferDataFromWindow()
  CODE:
    RETVAL = THIS->wxPanel::TransferDataFromWindow();
  OUTPUT:
    RETVAL

bool
Wx_Panel::TransferDataToWindow()
  CODE:
    RETVAL = THIS->wxPanel::TransferDataToWindow();
  OUTPUT:
    RETVAL

bool
Wx_Panel::Validate()
  CODE:
    RETVAL = THIS->wxPanel::Validate();
  OUTPUT:
    RETVAL
