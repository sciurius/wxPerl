#############################################################################
## Name:        XS/ColourDialog.xs
## Purpose:     XS for Wx::ColourDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      $Id: ColourDialog.xs,v 1.5 2003/11/23 07:45:53 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/colordlg.h>

MODULE=Wx PACKAGE=Wx::ColourDialog

wxColourDialog*
wxColourDialog::new( parent, data = 0 )
    wxWindow* parent
    wxColourData* data

wxColourData*
wxColourDialog::GetColourData()
  CODE:
    RETVAL = new wxColourData( THIS->GetColourData() );
  OUTPUT: RETVAL

int
wxColourDialog::ShowModal()

MODULE=Wx PACKAGE=Wx::ColourData

wxColourData*
wxColourData::new()

void
wxColourData::DESTROY()

bool
wxColourData::GetChooseFull()

wxColour*
wxColourData::GetColour()
  CODE:
    RETVAL = new wxColour( THIS->GetColour() );
  OUTPUT: RETVAL

wxColour*
wxColourData::GetCustomColour( i )
    int i
  CODE:
    RETVAL = new wxColour( THIS->GetCustomColour( i ) );
  OUTPUT: RETVAL

void
wxColourData::SetChooseFull( flag )
    bool flag

void
wxColourData::SetColour( colour )
    wxColour* colour
  C_ARGS: *colour

void
wxColourData::SetCustomColour( i, colour )
    int i
    wxColour* colour
  C_ARGS: i, *colour

MODULE=Wx PACKAGE=Wx PREFIX=wx

wxColour*
wxGetColourFromUser( parent, colInit = (wxColour*)&wxNullColour )
    wxWindow* parent
    wxColour* colInit
  CODE:
    RETVAL = new wxColour( wxGetColourFromUser( parent, *colInit ) );
  OUTPUT:
    RETVAL
