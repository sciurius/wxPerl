#############################################################################
## Name:        XS/Panel.xs
## Purpose:     XS for Wx::Panel
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Panel.xs,v 1.11 2004/02/29 14:43:24 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/panel.h>
#include "cpp/panel.h"

MODULE=Wx PACKAGE=Wx::Panel

wxPanel*
newFull( CLASS, parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTAB_TRAVERSAL, name = wxPanelNameStr )
  CASE: items == 1
      PlClassName CLASS
    CODE:
      RETVAL = new wxPliPanel( CLASS );
    OUTPUT:
      RETVAL
  CASE:
      PlClassName CLASS
      wxWindow* parent
      wxWindowID id
      wxPoint pos
      wxSize size
      long style
      wxString name
    CODE:
      RETVAL = new wxPliPanel( CLASS, parent, id, pos, size, style, name );
    OUTPUT:
      RETVAL

bool
wxPanel::Create( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTAB_TRAVERSAL, name = wxPanelNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

bool
wxPanel::TransferDataFromWindow()
  CODE:
    RETVAL = THIS->wxPanel::TransferDataFromWindow();
  OUTPUT:
    RETVAL

bool
wxPanel::TransferDataToWindow()
  CODE:
    RETVAL = THIS->wxPanel::TransferDataToWindow();
  OUTPUT:
    RETVAL

bool
wxPanel::Validate()
  CODE:
    RETVAL = THIS->wxPanel::Validate();
  OUTPUT:
    RETVAL
