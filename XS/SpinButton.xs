#############################################################################
## Name:        XS/SpinButton.xs
## Purpose:     XS for Wx::SpinButton
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: SpinButton.xs,v 1.7 2003/05/31 15:36:56 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/spinctrl.h>
#include <wx/spinbutt.h>

MODULE=Wx_Evt PACKAGE=Wx::SpinEvent

wxSpinEvent*
wxSpinEvent::new( commandType = wxEVT_NULL, id = 0 )
    wxEventType commandType
    int id

int
wxSpinEvent::GetPosition()

void
wxSpinEvent::SetPosition( pos )
    int pos

MODULE=Wx PACKAGE=Wx::SpinButton

wxSpinButton*
wxSpinButton::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSP_HORIZONTAL, name = wxT("spinButton") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxSpinButton( parent, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

int
wxSpinButton::GetMax()

int
wxSpinButton::GetMin()

int
wxSpinButton::GetValue()

void
wxSpinButton::SetRange( min, max )
    int min
    int max

void
wxSpinButton::SetValue( value )
    int value
