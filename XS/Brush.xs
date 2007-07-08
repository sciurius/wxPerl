#############################################################################
## Name:        XS/Brush.xs
## Purpose:     XS for Wx::Brush
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2004, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/colour.h>
#include <wx/bitmap.h>
#include <wx/brush.h>
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::Brush

void
wxBrush::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wbmp, newBitmap )
        MATCH_REDISP( wxPliOvl_wcol_n, newColour )
        MATCH_REDISP( wxPliOvl_s_n, newName )
    END_OVERLOAD( Wx::Brush::new )

wxBrush*
newColour( CLASS, colour, style )
    SV* CLASS
    wxColour* colour
    int style
  CODE:
    RETVAL = new wxBrush( *colour, style );
  OUTPUT:
    RETVAL

wxBrush*
newName( CLASS, name, style )
    SV* CLASS
    wxString name
    int style
  CODE:
    RETVAL = new wxBrush( name, style );
  OUTPUT:
    RETVAL

wxBrush*
newBitmap( CLASS, stipple )
    SV* CLASS
    wxBitmap* stipple
  CODE:
    RETVAL = new wxBrush( *stipple );
  OUTPUT:
    RETVAL

static void
wxBrush::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxBrush::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Brush", THIS, ST(0) );
    delete THIS;

wxColour*
wxBrush::GetColour()
  CODE:
    RETVAL = new wxColour( THIS->GetColour() );
  OUTPUT:
    RETVAL

wxBitmap*
wxBrush::GetStipple()
  CODE:
    RETVAL = new wxBitmap( *THIS->GetStipple() );
  OUTPUT:
    RETVAL

int
wxBrush::GetStyle()

bool
wxBrush::Ok()

#if WXPERL_W_VERSION_GE( 2, 8, 0 )

bool
wxBrush::IsOk()

#endif

void
wxBrush::SetColour( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n, SetColourRGB )
        MATCH_REDISP( wxPliOvl_wcol, SetColourColour )
        MATCH_REDISP( wxPliOvl_s, SetColourName )
    END_OVERLOAD( Wx::Brush::SetColour )

void
wxBrush::SetColourColour( colour )
    wxColour* colour
  CODE:
    THIS->SetColour( *colour );

void
wxBrush::SetColourName( name )
    wxString name
  CODE:
    THIS->SetColour( name );

void
wxBrush::SetColourRGB( r, g, b )
    int r
    int g
    int b
  CODE:
    THIS->SetColour( r, g, b );

void
wxBrush::SetStipple( stipple )
    wxBitmap* stipple
  CODE:
    THIS->SetStipple( *stipple );

void
wxBrush::SetStyle( style )
    int style
