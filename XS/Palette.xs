#############################################################################
## Name:        XS/Palette.xs
## Purpose:     XS for Wx::Palette
## Author:      Mattia Barbon
## Modified by:
## Created:     09/01/2000
## RCS-ID:      $Id: Palette.xs,v 1.10 2004/07/10 21:49:46 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/palette.h>

MODULE=Wx PACKAGE=Wx::Palette

wxPalette*
wxPalette::new( r, g, b )
    SV* r
    SV* g
    SV* b
  PREINIT:
    unsigned char* red;
    unsigned char* green;
    unsigned char* blue;
    int rn, gn, bn;
  CODE:
    rn = wxPli_av_2_uchararray( aTHX_ r, &red );
    gn = wxPli_av_2_uchararray( aTHX_ g, &green );
    bn = wxPli_av_2_uchararray( aTHX_ b, &blue );

    if( rn != gn || gn != bn )
    {
      croak( "arrays must be of the same size" );
    }

    RETVAL = new wxPalette( rn, red, green, blue );

    delete[] red;
    delete[] green;
    delete[] blue;
  OUTPUT:
    RETVAL

## XXX threads
void
wxPalette::DESTROY()

int
wxPalette::GetPixel( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue

void
wxPalette::GetRGB( pixel )
    int pixel
  PREINIT:
    unsigned char red, green, blue;
  PPCODE:
    if( THIS->GetRGB( pixel, &red, &green, &blue ) ) 
    {
      EXTEND( SP, 3 );
      PUSHs( sv_2mortal( newSVuv( red ) ) );
      PUSHs( sv_2mortal( newSVuv( green ) ) );
      PUSHs( sv_2mortal( newSVuv( blue ) ) ); 
    }
    else
    {
      EXTEND( SP, 3 );
      PUSHs( &PL_sv_undef );
      PUSHs( &PL_sv_undef );
      PUSHs( &PL_sv_undef );
    }

bool
wxPalette::Ok()

