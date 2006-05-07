#############################################################################
## Name:        XS/BitmapButton.xs
## Purpose:     XS for Wx::BitmapButton
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id: BitmapButton.xs,v 1.6 2006/05/07 16:37:51 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::BitmapButton

#include <wx/bmpbuttn.h>

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::BitmapButton::new" )

wxBitmapButton*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxBitmapButton();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxBitmapButton*
newFull( CLASS, parent, id, bitmap, pos = wxDefaultPosition, size = wxDefaultSize, style = wxBU_AUTODRAW, validator = (wxValidator*)&wxDefaultValidator, name = wxButtonNameStr )
    PlClassName CLASS
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

bool
wxBitmapButton::Create( parent, id, bitmap, pos = wxDefaultPosition, size = wxDefaultSize, style = wxBU_AUTODRAW, validator = (wxValidator*)&wxDefaultValidator, name = wxButtonNameStr )
    wxWindow* parent
    wxWindowID id
    wxBitmap* bitmap
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, *bitmap, pos, size, style, *validator, name

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

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

wxBitmap*
wxBitmapButton::GetBitmapHover()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapHover() );
  OUTPUT:
    RETVAL

#endif

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

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

void
wxBitmapButton::SetBitmapHover( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

#endif

