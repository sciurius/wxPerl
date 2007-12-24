#############################################################################
## Name:        XS/ToggleButton.xs
## Purpose:     XS for Wx::ToggleButton
## Author:      Mattia Barbon
## Modified by:
## Created:     20/07/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001, 2003, 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_TOGGLEBTN

#include <wx/tglbtn.h>

MODULE=Wx PACKAGE=Wx::ToggleButton

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::ToggleButton::new" )

wxToggleButton*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxToggleButton();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxToggleButton*
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
    RETVAL = new wxToggleButton( parent, id, label, pos, size, 
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxToggleButton::Create( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxCheckBoxNameStr )
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
wxToggleButton::GetValue()

void
wxToggleButton::SetValue( value )
    bool value

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

MODULE=Wx PACKAGE=Wx::BitmapToggleButton

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::BitmapToggleButton::new" )

wxBitmapToggleButton*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxBitmapToggleButton();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxBitmapToggleButton*
newFull( CLASS, parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxCheckBoxNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxBitmap* label
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxBitmapToggleButton( parent, id, *label, pos, size, 
                                       style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxBitmapToggleButton::Create( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxCheckBoxNameStr )
    wxWindow* parent
    wxWindowID id
    wxBitmap* label
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, *label, pos, size, style, *validator, name

bool
wxBitmapToggleButton::GetValue()

void
wxBitmapToggleButton::SetValue( value )
    bool value

#endif

#endif
