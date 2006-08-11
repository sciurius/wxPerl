#############################################################################
## Name:        XS/Colour.xs
## Purpose:     XS for Wx::Colour
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Colour.xs,v 1.15 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2000-2002, 2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Colour

void
wxColour::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n, newRGB )
        MATCH_REDISP( wxPliOvl_s, newName )
    END_OVERLOAD( Wx::Colour::new )

wxColour*
newRGB( CLASS, red, green, blue )
    SV* CLASS
    unsigned char red
    unsigned char green
    unsigned char blue
  CODE:
    RETVAL = new wxColour( red, green, blue );
  OUTPUT: RETVAL

wxColour*
newName( CLASS, name )
    SV* CLASS
    wxString name
  CODE:
    RETVAL = new wxColour( name );
  OUTPUT: RETVAL

static void
wxColour::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxColour::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Colour", THIS, ST(0) );
    delete THIS;

unsigned char
wxColour::Blue()

unsigned char
wxColour::Green()

bool
wxColour::Ok()

unsigned char
wxColour::Red()

void
wxColour::Set( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue
