#############################################################################
## Name:        SpinCtrl.xs
## Purpose:     XS for Wx::SpinCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::SpinCtrl

Wx_SpinCtrl*
Wx_SpinCtrl::new( parent, id, value = wxEmptyString, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSP_ARROW_KEYS, min = 0, max = 100, initial = 0, name = wxT("spinCtrl") )
    Wx_Window* parent
    wxWindowID id
    wxString value
    Wx_Point pos
    Wx_Size size
    long style
    int min
    int max
    int initial
    wxString name
  CODE:
    RETVAL = new wxPliSpinCtrl( CLASS, parent, id, value, pos, size,
        style, min, max, initial, name );
  OUTPUT:
    RETVAL

int
Wx_SpinCtrl::GetMin()

int
Wx_SpinCtrl::GetMax()

int
Wx_SpinCtrl::GetValue()

void
Wx_SpinCtrl::SetRange( min, max )
    int min
    int max

void
Wx_SpinCtrl::SetValue( text )
    wxString text

#if WXPERL_W_VERSION_GE( 2, 3, 3 ) && !defined(__WXGTK__)

void
Wx_SpinCtrl::SetSelection( from, to )
    long from
    long to

#endif
