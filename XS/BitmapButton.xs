#############################################################################
## Name:        BitmapButton.xs
## Purpose:     XS for Wx::BitmapButton
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::BitmapButton

#include <wx/bmpbuttn.h>

wxBitmapButton*
wxBitmapButton::new( parent, id, bitmap, pos = wxDefaultPosition, size = wxDefaultSize, style = wxBU_AUTODRAW, validator = (wxValidator*)&wxDefaultValidator, name = wxButtonNameStr )
    wxWindow* parent
    wxWindowID id
    wxBitmap* bitmap
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxBitmapButton( parent, id, *bitmap, pos, size,
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxBitmap*
wxBitmapButton::GetBitmapDisabled()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapDisabled() );
  OUTPUT:
    RETVAL

wxBitmap*
wxBitmapButton::GetBitmapFocus()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapFocus() );
  OUTPUT:
    RETVAL

wxBitmap*
wxBitmapButton::GetBitmapLabel()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapLabel() );
  OUTPUT:
    RETVAL

wxBitmap*
wxBitmapButton::GetBitmapSelected()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapSelected() );
  OUTPUT:
    RETVAL

void
wxBitmapButton::SetBitmapDisabled( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

void
wxBitmapButton::SetBitmapLabel( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

void
wxBitmapButton::SetBitmapSelected( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

void
wxBitmapButton::SetBitmapFocus( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap
