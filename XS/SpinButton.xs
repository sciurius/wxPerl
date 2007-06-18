#############################################################################
## Name:        XS/SpinButton.xs
## Purpose:     XS for Wx::SpinButton
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2003, 2006 Mattia Barbon
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

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::SpinButton::new" )

wxSpinButton*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxSpinButton();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxSpinButton*
newFull( CLASS, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSP_HORIZONTAL, name = wxSPIN_BUTTON_NAME )
    PlClassName CLASS
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

bool
wxSpinButton::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSP_HORIZONTAL, name = wxSPIN_BUTTON_NAME )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

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
