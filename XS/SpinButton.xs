#############################################################################
## Name:        SpinButton.xs
## Purpose:     XS for Wx::SpinButton
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/spinctrl.h>

MODULE=Wx_Evt PACKAGE=Wx::SpinEvent

Wx_SpinEvent*
Wx_SpinEvent::new( commandType = wxEVT_NULL, id = 0 )
    wxEventType commandType
    int id

int
Wx_SpinEvent::GetPosition()

void
Wx_SpinEvent::SetPosition( pos )
    int pos

MODULE=Wx PACKAGE=Wx::SpinButton

Wx_SpinButton*
Wx_SpinButton::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSP_HORIZONTAL, name = wxT("spinButton") )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliSpinButton( CLASS, parent, id, pos, size, style,
        name );
  OUTPUT:
    RETVAL

int
Wx_SpinButton::GetMax()

int
Wx_SpinButton::GetMin()

int
Wx_SpinButton::GetValue()

void
Wx_SpinButton::SetRange( min, max )
    int min
    int max

void
Wx_SpinButton::SetValue( value )
    int value
