#############################################################################
## Name:        Colour.xs
## Purpose:     XS for Wx::Colour
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Colour

Wx_Colour*
newRGB( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue
  CODE:
    RETVAL = new wxColour( red, green, blue );
  OUTPUT:
    RETVAL

Wx_Colour*
newName( name )
    wxString name
  CODE:
    RETVAL = new wxColour( name );
  OUTPUT:
    RETVAL

## XXX threads
void
Wx_Colour::DESTROY()

unsigned char
Wx_Colour::Blue()

unsigned char
Wx_Colour::Green()

#if !defined( __WXMAC__ ) && !defined( __WXGTK__ ) && !defined( __WXMOTIF__ )

WXCOLORREF
Wx_Colour::GetPixel()

#else
#if defined( __WXGTK__ ) || defined( __WXMOTIF__ )

int
Wx_Colour::GetPixel()

#endif
#endif

bool
Wx_Colour::Ok()

unsigned char
Wx_Colour::Red()

void
Wx_Colour::Set( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue
