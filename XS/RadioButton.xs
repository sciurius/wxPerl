#############################################################################
## Name:        XS/RadioButton.xs
## Purpose:     XS for Wx::RadioButton
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: RadioButton.xs,v 1.4 2003/05/31 15:36:56 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/radiobut.h>

MODULE=Wx PACKAGE=Wx::RadioButton

wxRadioButton*
wxRadioButton::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxRadioButtonNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxRadioButton( parent, id, label, pos, size, 
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxRadioButton::GetValue()

void
wxRadioButton::SetValue( value )
    bool value
