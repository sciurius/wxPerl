#############################################################################
## Name:        XS/GraphicsMatrix.xs
## Purpose:     XS for Wx::GraphicsMatrix
## Author:      Klaas Hartmann
## Modified by:
## Created:     29/06/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007 Klaas Hartmann
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxUSE_GRAPHICS_CONTEXT

#include <wx/graphics.h>

MODULE=Wx PACKAGE=Wx::GraphicsMatrix

void
wxGraphicsMatrix::Concat ( t )
    wxGraphicsMatrix* t

void
wxGraphicsMatrix::Get ( )
  PREINIT:
    wxDouble a, b, c, d, tx, ty;
  PPCODE:
    THIS->Get( &a, &b, &c, &d, &tx, &ty );
    EXTEND( SP, 6 );
    PUSHs( sv_2mortal( newSVnv( a ) ) );
    PUSHs( sv_2mortal( newSVnv( b ) ) );
    PUSHs( sv_2mortal( newSVnv( c ) ) );
    PUSHs( sv_2mortal( newSVnv( d ) ) );
    PUSHs( sv_2mortal( newSVnv( tx ) ) );
    PUSHs( sv_2mortal( newSVnv( ty ) ) );

void
wxGraphicsMatrix::Invert ()

bool 
wxGraphicsMatrix::IsEqual ( t )
    wxGraphicsMatrix* t
  C_ARGS: *t

bool
wxGraphicsMatrix::IsIdentity ()

void 
wxGraphicsMatrix::Rotate (angle)
    wxDouble angle

void 
wxGraphicsMatrix::Scale (xScale, yScale)
    wxDouble xScale
    wxDouble yScale

void 
wxGraphicsMatrix::Translate (dx, dy)
    wxDouble dx
    wxDouble dy

void 
wxGraphicsMatrix::Set (a, b, c, d, tx, ty)
    wxDouble a
    wxDouble b
    wxDouble c 
    wxDouble d
    wxDouble tx
    wxDouble ty

void
wxGraphicsMatrix::TransformPoint ( x, y )
    wxDouble x
    wxDouble y
  PREINIT:
    wxDouble x_out, y_out;
  PPCODE:
    x_out = x;
    y_out = y;
    THIS->TransformPoint( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSVnv( x ) ) );
    PUSHs( sv_2mortal( newSVnv( y ) ) );

void
wxGraphicsMatrix::TransformDistance ( dx, dy )
    wxDouble dx
    wxDouble dy
  PREINIT:
    wxDouble dx_out, dy_out;
  PPCODE:
    dx_out = dx;
    dy_out = dy;
    THIS->TransformDistance( &dx, &dy );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSVnv( dx ) ) );
    PUSHs( sv_2mortal( newSVnv( dy ) ) );

#endif
