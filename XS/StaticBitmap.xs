#############################################################################
## Name:        StaticBitmap.xs
## Purpose:     XS for Wx::StaticBitmap
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::StaticBitmap

Wx_StaticBitmap*
newBitmap( cls, parent, id, bitmap, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticBitmapNameStr )
    SV* cls
    Wx_Window* parent
    wxWindowID id
    Wx_Bitmap* bitmap
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  PREINIT:
    const char* CLASS = _get_class( cls );
  CODE:
    RETVAL = new _wxStaticBitmap( CLASS, parent, id, *bitmap, pos, size,
         style, name );
  OUTPUT:
    RETVAL

Wx_StaticBitmap*
newIcon( cls, parent, id, icon, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticBitmapNameStr )
    SV* cls
    Wx_Window* parent
    wxWindowID id
    Wx_Icon* icon
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  PREINIT:
    const char* CLASS = _get_class( cls );
  CODE:
    RETVAL = new _wxStaticBitmap( CLASS, parent, id, *icon, pos, size,
         style, name );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_StaticBitmap::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

void
Wx_StaticBitmap::SetBitmap( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SetBitmap( *bitmap );

void
Wx_StaticBitmap::SetIcon( icon )
    Wx_Icon* icon
  CODE:
    THIS->SetIcon( *icon );
