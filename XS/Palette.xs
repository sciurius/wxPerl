#############################################################################
## Name:        Palette.xs
## Purpose:     XS for Wx::Palette
## Author:      Mattia Barbon
## Modified by:
## Created:      9/ 1/2000
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Palette

Wx_Palette*
Wx_Palette::new( r, g, b )
    SV* r
    SV* g
    SV* b
  PREINIT:
    unsigned char* red;
    unsigned char* green;
    unsigned char* blue;
    int rn, gn, bn, n;
  CODE:
    rn = _av_2_uchararray( r, &red );
    gn = _av_2_uchararray( g, &green );
    bn = _av_2_uchararray( b, &blue );

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

void
Wx_Palette::DESTROY()

int
Wx_Palette::GetPixel( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue

void
Wx_Palette::GetRGB( pixel )
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
Wx_Palette::Ok()

