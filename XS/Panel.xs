#############################################################################
## Name:        XS/Panel.xs
## Purpose:     XS for Wx::Panel
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Panel.xs,v 1.16 2006/09/24 15:04:24 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/panel.h>
#include "cpp/panel.h"
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::Panel

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Panel::new" )

wxPanel*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliPanel( CLASS );
  OUTPUT: RETVAL

wxPanel*
newFull( CLASS, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTAB_TRAVERSAL, name = wxPanelNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliPanel( CLASS, parent, id, pos, size, style, name );
  OUTPUT: RETVAL

bool
wxPanel::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTAB_TRAVERSAL, name = wxPanelNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

#if WXPERL_W_VERSION_GE( 2, 5, 4 )

void
wxPanel::SetFocusIgnoringChildren()

#endif

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
