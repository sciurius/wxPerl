#############################################################################
## Name:        BitmapButton.xs
## Purpose:     XS for Wx::BitmapButton
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::BitmapButton

Wx_BitmapButton*
Wx_BitmapButton::new( parent, id, bitmap, pos = wxDefaultPosition, size = wxDefaultSize, style = wxBU_AUTODRAW, validator = (wxValidator*)&wxDefaultValidator, name = wxButtonNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Bitmap* bitmap
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new _wxBitmapButton( CLASS, parent, id, *bitmap, pos, size,
        style, *validator, name );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_BitmapButton::GetBitmapDisabled()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapDisabled() );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_BitmapButton::GetBitmapFocus()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapFocus() );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_BitmapButton::GetBitmapLabel()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapLabel() );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_BitmapButton::GetBitmapSelected()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmapSelected() );
  OUTPUT:
    RETVAL

void
Wx_BitmapButton::SetBitmapDisabled( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SetBitmapDisabled( *bitmap );

void
Wx_BitmapButton::SetBitmapLabel( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SetBitmapLabel( *bitmap );

void
Wx_BitmapButton::SetBitmapSelected( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SetBitmapSelected( *bitmap );

void
Wx_BitmapButton::SetBitmapFocus( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SetBitmapFocus( *bitmap );
