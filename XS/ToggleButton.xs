#############################################################################
## Name:        Button.xs
## Purpose:     XS for Wx::ToggleButton
## Author:      Mattia Barbon
## Modified by:
## Created:     20/ 7/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if WXPERL_W_VERSION_GE( 2, 3, 1 ) && wxPERL_USE_TOGGLEBTN

#include <wx/tglbtn.h>

MODULE=Wx PACKAGE=Wx::ToggleButton

Wx_ToggleButton*
Wx_ToggleButton::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxCheckBoxNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString label
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new wxPliToggleButton( CLASS, parent, id, label, pos, size, 
        style, *validator, name );
  OUTPUT:
    RETVAL

bool
wxToggleButton::GetValue()

void
wxToggleButton::SetValue( value )
    bool value

#endif

