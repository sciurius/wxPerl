#############################################################################
## Name:        ImageList.xs
## Purpose:     XS for Wx::ImageList
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/imaglist.h>

MODULE=Wx PACKAGE=Wx::ImageList

Wx_ImageList*
Wx_ImageList::new( width, height, mask = TRUE, initialCount =1 )
    int width
    int height
    bool mask
    int initialCount

## XXX threads
void
Wx_ImageList::DESTROY()

int
Wx_ImageList::AddBitmap( bitmap, mask = (wxBitmap*)&wxNullBitmap )
    Wx_Bitmap* bitmap
    Wx_Bitmap* mask
  CODE:
    RETVAL = THIS->Add( *bitmap, *mask );
  OUTPUT:
    RETVAL

int
Wx_ImageList::AddWithColourMask( bitmap, colour )
    Wx_Bitmap* bitmap
    Wx_Colour* colour
  CODE:
    RETVAL = THIS->Add( *bitmap, *colour );
  OUTPUT:
    RETVAL

int
Wx_ImageList::AddIcon( icon )
    Wx_Icon* icon
  CODE:
    RETVAL = THIS->Add( *icon );
  OUTPUT:
    RETVAL

bool
Wx_ImageList::Draw( index, dc, x, y, flags = wxIMAGELIST_DRAW_NORMAL, solidBackground = FALSE )
    int index
    Wx_DC* dc
    int x
    int y
    int flags
    bool solidBackground
  CODE:
    RETVAL = THIS->Draw( index, *dc, x, y, flags, solidBackground );
  OUTPUT:
    RETVAL

int
Wx_ImageList::GetImageCount()

void
Wx_ImageList::GetSize( index )
    int index
  PREINIT:
    int width;
    int height;
    bool result;
  PPCODE:
    result = THIS->GetSize( index, width, height );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( result ) ) );
    PUSHs( sv_2mortal( newSViv( width ) ) );
    PUSHs( sv_2mortal( newSViv( height ) ) );

bool
Wx_ImageList::Remove( index )
    int index

bool
Wx_ImageList::RemoveAll()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

bool
Wx_ImageList::ReplaceBitmap( index, bitmap, mask = (wxBitmap*)&wxNullBitmap )
    int index
    Wx_Bitmap* bitmap
    Wx_Bitmap* mask
  CODE:
    RETVAL = THIS->Replace( index, *bitmap, *mask );
  OUTPUT:
    RETVAL

#else

bool
Wx_ImageList::ReplaceBitmap( index, bitmap )
    int index
    Wx_Bitmap* bitmap
  CODE:
    RETVAL = THIS->Replace( index, *bitmap );
  OUTPUT:
    RETVAL

#endif

bool
Wx_ImageList::ReplaceIcon( index, icon )
    int index
    Wx_Icon* icon
  CODE:
    RETVAL = THIS->Replace( index, *icon );
  OUTPUT:
    RETVAL
