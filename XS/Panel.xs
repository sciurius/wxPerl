#############################################################################
## Name:        Panel.xs
## Purpose:     XS for Wx::Panel
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Panel.xs,v 1.9 2003/05/05 20:38:41 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/panel.h>
#include "cpp/panel.h"

MODULE=Wx PACKAGE=Wx::Panel

Wx_Panel*
Wx_Panel::new( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTAB_TRAVERSAL, name = wxPanelNameStr )
  CASE: items == 1
    CODE:
      RETVAL = new wxPliPanel( CLASS );
    OUTPUT:
      RETVAL
  CASE:
      Wx_Window* parent
      wxWindowID id
      Wx_Point pos
      Wx_Size size
      long style
      wxString name
    CODE:
      RETVAL = new wxPliPanel( CLASS, parent, id, pos, size, style, name );
    OUTPUT:
      RETVAL

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
