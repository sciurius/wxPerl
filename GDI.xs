/////////////////////////////////////////////////////////////////////////////
// Name:        GDI.xs
// Purpose:     XS for various GDI objects
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>

#include <wx/imaglist.h>
#include <wx/image.h>
#include <wx/icon.h>
#include <wx/bitmap.h>
#include <wx/cursor.h>
#include <wx/dc.h>
#include <wx/palette.h>
#include <wx/dcmemory.h>
#include <wx/dcclient.h>
#include <wx/dcscreen.h>

#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

// some helper functions/classes/macros
#include "cpp/compat.h"
#include "cpp/typedef.h"
#include "cpp/helpers.h"

#undef THIS

MODULE=Wx_GDI

INCLUDE: XS/Colour.xs
INCLUDE: XS/Font.xs
INCLUDE: XS/ImageList.xs
INCLUDE: XS/Bitmap.xs
INCLUDE: XS/Icon.xs
INCLUDE: XS/Cursor.xs
INCLUDE: XS/DC.xs
INCLUDE: XS/Pen.xs
INCLUDE: XS/Brush.xs
INCLUDE: XS/Image.xs
INCLUDE: XS/Palette.xs

MODULE=Wx_GDI
