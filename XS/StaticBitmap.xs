#############################################################################
## Name:        StaticBitmap.xs
## Purpose:     XS for Wx::StaticBitmap
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::StaticBitmap

void
Wx_StaticBitmap::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin_n_wico, newIcon )
        MATCH_REDISP( wxPliOvl_wwin_n_wbmp, newBitmap )
    END_OVERLOAD( Wx::StaticBitmap::new )

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
    const char* CLASS = wxPli_get_class( aTHX_ cls );
  CODE:
    RETVAL = new wxPliStaticBitmap( CLASS, parent, id, *bitmap, pos, size,
         style, name );
  OUTPUT:
    RETVAL

#if !defined(__WXUNIVERSAL__) || defined(__WXPERL_FORCE__)

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
    const char* CLASS = wxPli_get_class( aTHX_ cls );
  CODE:
    RETVAL = new wxPliStaticBitmap( CLASS, parent, id, *icon, pos, size,
         style, name );
  OUTPUT:
    RETVAL

#endif

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

#if !defined(__WXUNIVERSAL__) || defined(__WXPERL_FORCE__)

Wx_Icon*
Wx_StaticBitmap::GetIcon()
  CODE:
    RETVAL = new wxIcon( THIS->GetIcon() );
  OUTPUT:
    RETVAL

void
Wx_StaticBitmap::SetIcon( icon )
    Wx_Icon* icon
  CODE:
    THIS->SetIcon( *icon );

#endif
