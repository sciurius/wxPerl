#############################################################################
## Name:        XS/ColourDialog.xs
## Purpose:     XS for Wx::ColourDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2001, 2003, 2006-2007 Mattia Barbon
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

static void
wxColourData::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxColourData::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::ColourData", THIS, ST(0) );
    delete THIS;

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
