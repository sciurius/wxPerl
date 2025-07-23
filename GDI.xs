/////////////////////////////////////////////////////////////////////////////
// Name:        GDI.xs
// Purpose:     XS for various GDI objects
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2003, 2005-2010 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool
#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

WXPLI_BOOT_ONCE(Wx_GDI);
#define boot_Wx_GDI wxPli_boot_Wx_GDI

MODULE=Wx_GDI

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Animation.xsp
INCLUDE: XS/Colour.xs
INCLUDE: XS/ColourDatabase.xs
INCLUDE: XS/Font.xs
INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/ImageList.xsp
INCLUDE: XS/Bitmap.xs
INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/BitmapBundle.xsp
INCLUDE: XS/Icon.xs
INCLUDE: XS/Cursor.xs
INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/DC.xsp
INCLUDE: XS/Overlay.xs
INCLUDE: XS/Pen.xs
INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Brush.xsp
INCLUDE: XS/Image.xs
INCLUDE: XS/Palette.xs

INCLUDE: XS/GraphicsContext.xs
INCLUDE: XS/GraphicsPath.xs
INCLUDE: XS/GraphicsMatrix.xs
INCLUDE: XS/GraphicsObject.xs
INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/GraphicsRenderer.xsp

INCLUDE_COMMAND: $^X -I./ -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/SVGFileDC.xsp

MODULE=Wx PACKAGE=Wx PREFIX=wx

wxRect*
wxGetClientDisplayRect()
  CODE:
    RETVAL = new wxRect( wxGetClientDisplayRect() );
  OUTPUT:
    RETVAL

bool
wxColourDisplay()
  CODE:
    RETVAL = wxColourDisplay();
  OUTPUT:
    RETVAL

int
wxDisplayDepth()
  CODE:
    RETVAL = wxDisplayDepth();
  OUTPUT:
    RETVAL

wxSize*
wxGetDisplaySizeMM()
  CODE:
    RETVAL = new wxSize( wxGetDisplaySizeMM() );
  OUTPUT:
    RETVAL

wxSize*
wxGetDisplaySize()
  CODE:
    RETVAL = new wxSize( wxGetDisplaySize() );
  OUTPUT:
    RETVAL

MODULE=Wx_GDI
