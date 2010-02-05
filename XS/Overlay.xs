#############################################################################
## Name:        XS/DC.xs
## Purpose:     XS for Wx::Overlay
## Author:      Mark Dootson
## Modified by:
## Created:     31/01/2010
## RCS-ID:      $Id: Overlay.xs 2561 2009-05-17 08:49:49Z mbarbon $
## Copyright:   (c) 2000-2007, 2010 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if WXPERL_W_VERSION_GE( 2, 8, 0 )

#include <wx/dc.h>
#include <wx/window.h>
#include <wx/overlay.h>

MODULE=Wx PACKAGE=Wx::Overlay

wxOverlay*
new( CLASS )
    SV* CLASS
  CODE:
    RETVAL = new wxOverlay();
  OUTPUT:
    RETVAL
    
static void
wxOverlay::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK

void
wxOverlay::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Overlay", THIS, ST(0) );
    delete THIS;

void
wxOverlay::Reset()


MODULE=Wx PACKAGE=Wx::DCOverlay

# DECLARE_OVERLOAD( woly, Wx::Overlay )

wxDCOverlay*
wxDCOverlay::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_woly_wdc, newDefault )
        MATCH_REDISP( wxPliOvl_woly_wdc_n_n_n_n, newLong )
    END_OVERLOAD( Wx::DCOverlay::new )

wxDCOverlay*
newDefault( CLASS, overlay, dc )
    SV* CLASS
    wxOverlay* overlay
    wxWindowDC* dc
  CODE:
    RETVAL = new wxDCOverlay( *overlay, dc);
  OUTPUT:
    RETVAL

wxDCOverlay*
newLong( CLASS, overlay, dc, x, y, width, height )
    SV* CLASS
    wxOverlay* overlay
    wxWindowDC* dc
    int x
    int y
    int width
    int height
  CODE:
    RETVAL = new wxDCOverlay( *overlay, dc, x, y, width, height);
  OUTPUT:
    RETVAL

static void
wxDCOverlay::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK

void
wxDCOverlay::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Overlay", THIS, ST(0) );
    delete THIS;

void
wxDCOverlay::Clear()

#endif




