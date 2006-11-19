#############################################################################
## Name:        XS/Palette.xs
## Purpose:     XS for Wx::Palette
## Author:      Mattia Barbon
## Modified by:
## Created:     09/01/2000
## RCS-ID:      $Id: Palette.xs,v 1.13 2006/11/19 16:11:26 mbarbon Exp $
## Copyright:   (c) 2001-2002, 2004, 2006 Mattia Barbon
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

static void
wxPalette::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxPalette::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Palette", THIS, ST(0) );
    delete THIS;

#if WXPERL_W_VERSION_GE( 2, 6, 1 )

int
wxPalette::GetColoursCount()

#endif

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

