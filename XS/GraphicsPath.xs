#############################################################################
## Name:        XS/GraphicsPath.xs
## Purpose:     XS for Wx::GraphicsPath
## Author:      Klaas Hartmann
## Modified by:
## Created:     29/06/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007, 2009 Klaas Hartmann
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

## There are several overloaded functions (see below) where one variant takes a 
## wxPoint2DDouble and the other takes x and y values individually. In these
## cases the former variant has not been implemented.  Feel free to do so!
##
## Unimplemented overloaded functions
## void MoveToPoint(const wxPoint2DDouble& p)
## void AddArc(const wxPoint2DDouble& c, wxDouble r, wxDouble startAngle, wxDouble endAngle, bool clockwise)
## void AddCurveToPoint(const wxPoint2DDouble& c1, const wxPoint2DDouble& c2, const wxPoint2DDouble& e)
## void AddLineToPoint(const wxPoint2DDouble& p)
## bool Contains(const wxPoint2DDouble& c, int fillStyle = wxODDEVEN_RULE) const

#if wxUSE_GRAPHICS_CONTEXT

#include <wx/graphics.h>

MODULE=Wx PACKAGE=Wx::GraphicsPath

void
wxGraphicsPath::MoveToPoint (x, y)
    wxDouble x
    wxDouble y

void
wxGraphicsPath::AddArc(x,y,r,startAngle,endAngle,clockwise )
    wxDouble x
    wxDouble y
    wxDouble r
    wxDouble startAngle
    wxDouble endAngle
    bool clockwise

void
wxGraphicsPath::AddArcToPoint ( x1, y1, x2, y2, r)
    wxDouble x1
    wxDouble y1
    wxDouble x2
    wxDouble y2
    wxDouble r 

void 
wxGraphicsPath::AddCircle ( x, y, r)
    wxDouble x
    wxDouble y
    wxDouble r

void 
wxGraphicsPath::AddCurveToPoint (cx1, cy1, cx2, cy2, x, y)
    wxDouble cx1
    wxDouble cy1
    wxDouble cx2
    wxDouble cy2
    wxDouble x
    wxDouble y

void 
wxGraphicsPath::AddEllipse ( x, y, w, h)
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h

void 
wxGraphicsPath::AddLineToPoint ( x, y)
    wxDouble x
    wxDouble y

void 
wxGraphicsPath::AddPath (path)
    wxGraphicsPath* path
  CODE:
    THIS->AddPath(*path);

void 
wxGraphicsPath::AddQuadCurveToPoint (cx, cy, x, y)
    wxDouble cx
    wxDouble cy
    wxDouble x
    wxDouble y

void
wxGraphicsPath::AddRectangle (x, y, w, h)
    wxDouble x
    wxDouble y
    wxDouble w 
    wxDouble h

void 
wxGraphicsPath::AddRoundedRectangle (x, y, w, h, radius)
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h
    wxDouble radius

void 
wxGraphicsPath::CloseSubpath ( )

bool
wxGraphicsPath::Contains (x, y, fillStyle = wxODDEVEN_RULE)
    wxDouble x
    wxDouble y
    wxPolygonFillMode fillStyle

void
wxGraphicsPath::GetBox ( )
  PREINIT:
    wxDouble x, y, w, h;
  PPCODE:
    THIS->GetBox( &x, &y, &w, &h );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSVnv( x ) ) );
    PUSHs( sv_2mortal( newSVnv( y ) ) );
    PUSHs( sv_2mortal( newSVnv( w ) ) );
    PUSHs( sv_2mortal( newSVnv( h ) ) );

void
wxGraphicsPath::GetCurrentPoint ( )
  PREINIT:
    wxDouble x, y;
  PPCODE:
    THIS->GetCurrentPoint( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSVnv( x ) ) );
    PUSHs( sv_2mortal( newSVnv( y ) ) );

void
wxGraphicsPath::Transform (matrix)
    wxGraphicsMatrix* matrix
  CODE:
    THIS->Transform( *matrix );

#endif
