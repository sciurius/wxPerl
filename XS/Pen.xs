#############################################################################
## Name:        Pen.xs
## Purpose:     XS for Wx::Pen
## Author:      Mattia Barbon
## Modified by:
## Created:     21/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Pen

#FIXME// unimplemented
# SetDashes
# GetDashes
# operator == !=

Wx_Pen*
newColour( colour, width, style )
    Wx_Colour* colour
    int width
    int style
  CODE:
    RETVAL = new wxPen( *colour, width, style );
  OUTPUT:
    RETVAL

Wx_Pen*
newString( name, width, style )
    wxString name
    int width
    int style
  CODE:
    RETVAL = new wxPen( name, width, style );
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

Wx_Pen*
newBitmap( stipple, width )
    Wx_Bitmap* stipple
    int width
  CODE:
    RETVAL = new wxPen( *stipple, width );

#endif

int
Wx_Pen::GetCap()

Wx_Colour*
Wx_Pen::GetColour()
  CODE:
    RETVAL = new wxColour( THIS->GetColour() );
  OUTPUT:
    RETVAL

int
Wx_Pen::GetJoin()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

Wx_Bitmap*
Wx_Pen::GetStipple()
  CODE:
    RETVAL = new wxBitmap( *THIS->GetStipple() );
  OUTPUT:
    RETVAL

#endif

int
Wx_Pen::GetStyle()

int
Wx_Pen::GetWidth()

bool
Wx_Pen::Ok()

void
Wx_Pen::SetCap( capStyle )
    int capStyle

void
Wx_Pen::SetColourColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetColour( *colour );

void
Wx_Pen::SetColourName( name )
    wxString name
  CODE:
    THIS->SetColour( name );

void
Wx_Pen::SetColourRGB( r, g, b )
    int r
    int g
    int b
  CODE:
    THIS->SetColour( r, g, b );

void
Wx_Pen::SetJoin( join_style )
    int join_style

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_Pen::SetStipple( stipple )
    Wx_Bitmap* stipple
  CODE:
    THIS->SetStipple( *stipple );

#endif

void
Wx_Pen::SetStyle( style )
    int style

void
Wx_Pen::SetWidth( width )
    int width
