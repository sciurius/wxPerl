#############################################################################
## Name:        Colour.xs
## Purpose:     XS for Wx::Colour
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Colour

void
Wx_Colour::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n, newRGB )
        MATCH_REDISP( wxPliOvl_s, newName )
    END_OVERLOAD( Wx::Colour::new )

Wx_Colour*
newRGB( CLASS, red, green, blue )
    SV* CLASS
    unsigned char red
    unsigned char green
    unsigned char blue
  CODE:
    RETVAL = new wxColour( red, green, blue );
  OUTPUT:
    RETVAL

Wx_Colour*
newName( CLASS, name )
    SV* CLASS
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

bool
Wx_Colour::Ok()

unsigned char
Wx_Colour::Red()

void
Wx_Colour::Set( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue
