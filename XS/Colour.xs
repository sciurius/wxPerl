#############################################################################
## Name:        XS/Colour.xs
## Purpose:     XS for Wx::Colour
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2002, 2004, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Colour

void
wxColour::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, newRGBA )
        MATCH_REDISP( wxPliOvl_n_n_n, newRGB )
        MATCH_REDISP( wxPliOvl_s, newName )
    END_OVERLOAD( Wx::Colour::new )

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

wxColour*
newRGBA( CLASS, red, green, blue, alpha = wxALPHA_OPAQUE )
    SV* CLASS
    unsigned char red
    unsigned char green
    unsigned char blue
    unsigned char alpha
  CODE:
    RETVAL = new wxColour( red, green, blue, alpha );
  OUTPUT: RETVAL

#endif

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

#if WXPERL_W_VERSION_GE( 2, 8, 0 )

bool
wxColour::IsOk()

#endif

unsigned char
wxColour::Red()

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

unsigned char
wxColour::Alpha()

void
wxColour::Set( red, green, blue, alpha )
    unsigned char red
    unsigned char green
    unsigned char blue
    unsigned char alpha

#else

void
wxColour::Set( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue

#endif

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

wxString
wxColour::GetAsString( long flags )

#endif

#if !defined(__WXMAC__)

long
wxColour::GetPixel()

#endif
