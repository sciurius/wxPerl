#############################################################################
## Name:        XS/ToggleButton.xs
## Purpose:     XS for Wx::ToggleButton
## Author:      Mattia Barbon
## Modified by:
## Created:     20/ 7/2001
## RCS-ID:      $Id: ToggleButton.xs,v 1.6 2003/05/31 15:36:56 mbarbon Exp $
## Copyright:   (c) 2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_TOGGLEBTN

#include <wx/tglbtn.h>

MODULE=Wx PACKAGE=Wx::ToggleButton

wxToggleButton*
wxToggleButton::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxCheckBoxNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxToggleButton( parent, id, label, pos, size, 
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxToggleButton::GetValue()

void
wxToggleButton::SetValue( value )
    bool value

#endif
