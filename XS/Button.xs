#############################################################################
## Name:        Button.xs
## Purpose:     XS for Wx::Button
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: Button.xs,v 1.5 2003/05/27 20:00:37 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Button

#include <wx/button.h>

wxButton*
wxButton::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxButtonNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxButton( parent, id, label, pos, size, 
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

wxSize*
GetDefaultSize()
  CODE:
    RETVAL = new wxSize( wxButton::GetDefaultSize() );
  OUTPUT:
    RETVAL

void
wxButton::SetDefault()
