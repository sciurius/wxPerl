#############################################################################
## Name:        Brush.xs
## Purpose:     XS for Wx::Brush
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/brush.h>
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::Brush

void
Wx_Brush::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wbmp, newBitmap )
        MATCH_REDISP( wxPliOvl_wcol_n, newColour )
        MATCH_REDISP( wxPliOvl_s_n, newName )
    END_OVERLOAD( Wx::Brush::new )

Wx_Brush*
newColour( CLASS, colour, style )
    SV* CLASS
    Wx_Colour* colour
    int style
  CODE:
    RETVAL = new wxBrush( *colour, style );
  OUTPUT:
    RETVAL

Wx_Brush*
newName( CLASS, name, style )
    SV* CLASS
    wxString name
    int style
  CODE:
    RETVAL = new wxBrush( name, style );
  OUTPUT:
    RETVAL

Wx_Brush*
newBitmap( CLASS, stipple )
    SV* CLASS
    Wx_Bitmap* stipple
  CODE:
    RETVAL = new wxBrush( *stipple );
  OUTPUT:
    RETVAL

## XXX threads
void
Wx_Brush::DESTROY()

Wx_Colour*
Wx_Brush::GetColour()
  CODE:
    RETVAL = new wxColour( THIS->GetColour() );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_Brush::GetStipple()
  CODE:
    RETVAL = new wxBitmap( *THIS->GetStipple() );
  OUTPUT:
    RETVAL

int
Wx_Brush::GetStyle()

bool
Wx_Brush::Ok()

void
Wx_Brush::SetColour( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n, SetColourRGB )
        MATCH_REDISP( wxPliOvl_wcol, SetColourColour )
        MATCH_REDISP( wxPliOvl_s, SetColourName )
    END_OVERLOAD( Wx::Brush::SetColour )

void
Wx_Brush::SetColourColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetColour( *colour );

void
Wx_Brush::SetColourName( name )
    wxString name
  CODE:
    THIS->SetColour( name );

void
Wx_Brush::SetColourRGB( r, g, b )
    int r
    int g
    int b
  CODE:
    THIS->SetColour( r, g, b );

void
Wx_Brush::SetStipple( stipple )
    Wx_Bitmap* stipple
  CODE:
    THIS->SetStipple( *stipple );

void
Wx_Brush::SetStyle( style )
    int style
