#############################################################################
## Name:        ColourDialog.xs
## Purpose:     XS for Wx::ColourDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/colordlg.h>

MODULE=Wx PACKAGE=Wx::ColourDialog

Wx_ColourDialog*
Wx_ColourDialog::new( parent, data = 0 )
    Wx_Window* parent
    Wx_ColourData* data

Wx_ColourData*
Wx_ColourDialog::GetColourData()
  CODE:
    RETVAL = new wxColourData( THIS->GetColourData() );
  OUTPUT:
    RETVAL

int
Wx_ColourDialog::ShowModal()

MODULE=Wx PACKAGE=Wx::ColourData

Wx_ColourData*
Wx_ColourData::new()

void
Wx_ColourData::DESTROY()

bool
Wx_ColourData::GetChooseFull()

Wx_Colour*
Wx_ColourData::GetColour()
  CODE:
    RETVAL = new wxColour( THIS->GetColour() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_ColourData::GetCustomColour( i )
    int i
  CODE:
    RETVAL = new wxColour( THIS->GetCustomColour( i ) );
  OUTPUT:
    RETVAL

void
Wx_ColourData::SetChooseFull( flag )
    bool flag

void
Wx_ColourData::SetColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetColour( *colour );

void
Wx_ColourData::SetCustomColour( i, colour )
    int i
    Wx_Colour* colour
  CODE:
    THIS->SetCustomColour( i, *colour );

MODULE=Wx PACKAGE=Wx PREFIX=wx

Wx_Colour*
wxGetColourFromUser( parent, colInit = (wxColour*)&wxNullColour )
    Wx_Window* parent
    Wx_Colour* colInit
  CODE:
    RETVAL = new wxColour( wxGetColourFromUser( parent, *colInit ) );
  OUTPUT:
    RETVAL
