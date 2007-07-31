#############################################################################
## Name:        XS/GraphicsObject.xs
## Purpose:     XS for Wx::GraphicsObject
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

MODULE=Wx PACKAGE=Wx::GraphicsPath

void
wxGraphicsPath::MoveToPoint (x, y)
    wxDouble x
    wxDouble y
    
 # To overload    
 # void MoveToPoint(const wxPoint2DDouble& p)
 
void
wxGraphicsPath::AddArc(x,y,r,startAngle,endAngle,clockwise )
    wxDouble x
    wxDouble y
    wxDouble r
    wxDouble startAngle
    wxDouble endAngle
    bool clockwise

 # To overload
 # void AddArc(const wxPoint2DDouble& c, wxDouble r, wxDouble startAngle, wxDouble endAngle, bool clockwise)
 
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
 
 # To overload
 # void AddCurveToPoint(const wxPoint2DDouble& c1, const wxPoint2DDouble& c2, const wxPoint2DDouble& e)
 
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
    
 # To overload
 # void AddLineToPoint(const wxPoint2DDouble& p)
 
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
    int fillStyle
    
 # To overload
 # bool Contains(const wxPoint2DDouble& c, int fillStyle = wxODDEVEN_RULE) const
 # bool Contains(wxDouble x, wxDouble y, int fillStyle = wxODDEVEN_RULE) const
 
 # To implement 
 # wxGraphicsPath::GetBox
 # wxRect2DDouble GetBox() const
 # void GetBox(wxDouble* x, wxDouble* y, wxDouble* w, wxDouble* h) const
 # Gets the bounding box enclosing all points (possibly including control points).
 
 # To implement 
 # wxGraphicsPath::GetCurrentPoint
 # void GetCurrentPoint(wxDouble* x, wxDouble* y) const
 # wxPoint2DDouble GetCurrentPoint() const
 # Gets the last point of the current path, (0,0) if not yet set.
 
 # To implement 
 # wxGraphicsPath::Transform
 # void Transform(const wxGraphicsMatrix& matrix)
 #  Transforms each point of this path by the matrix.
 
 # Omit?
 # wxGraphicsPath::GetNativePath
 # void * GetNativePath() const
 # Returns the native path (CGPathRef for Core Graphics, Path pointer for GDIPlus and a cairo_path_t pointer for cairo).
 
 # Omit?
 # wxGraphicsPath::UnGetNativePath
 # void UnGetNativePath(void* p) const
 # Gives back the native path returned by GetNativePath() because there might be some deallocations necessary (eg on cairo the native path returned by GetNativePath is newly allocated each time).

#endif
