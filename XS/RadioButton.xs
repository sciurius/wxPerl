#############################################################################
## Name:        XS/RadioButton.xs
## Purpose:     XS for Wx::RadioButton
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id: RadioButton.xs,v 1.5 2003/06/04 20:38:43 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/radiobut.h>

MODULE=Wx PACKAGE=Wx::RadioButton

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::RadioButton::new" )

wxRadioButton*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxRadioButton();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxRadioButton*
newFull( CLASS, parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxRadioButtonNameStr )
    PlClassName CLASS
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
wxRadioButton::Create( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxRadioButtonNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, label, pos, size, style, *validator, name

bool
wxRadioButton::GetValue()

void
wxRadioButton::SetValue( value )
    bool value
