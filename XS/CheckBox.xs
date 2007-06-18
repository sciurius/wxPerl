#############################################################################
## Name:        XS/CheckBox.xs
## Purpose:     XS for Wx::CheckBox
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::CheckBox

#include <wx/checkbox.h>

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::CheckBox::new" )

wxCheckBox*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxCheckBox();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxCheckBox*
newFull( CLASS, parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxCheckBoxNameStr )
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
    RETVAL = new wxCheckBox( parent, id, label, pos, size, 
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxCheckBox::Create( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxCheckBoxNameStr )
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
wxCheckBox::GetValue()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxCheckBoxState
wxCheckBox::Get3StateValue()

void
wxCheckBox::Set3StateValue(state)
    wxCheckBoxState state

bool
wxCheckBox::Is3State()

bool
wxCheckBox::Is3rdStateAllowedForUser()

#endif

void
wxCheckBox::SetValue( state )
    bool state

bool
wxCheckBox::IsChecked()
