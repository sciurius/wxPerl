#############################################################################
## Name:        RadioButton.xs
## Purpose:     XS for Wx::RadioButton
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::RadioButton

Wx_RadioButton*
Wx_RadioButton::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxRadioButtonNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString label
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new wxPliRadioButton( CLASS, parent, id, label, pos, size, 
        style, *validator, name );
  OUTPUT:
    RETVAL

bool
Wx_RadioButton::GetValue()

void
Wx_RadioButton::SetValue( value )
    bool value
