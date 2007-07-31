#############################################################################
## Name:        XS/GraphicsMatrix.xs
## Purpose:     XS for Wx::GraphicsMatrix
## Author:      Klaas Hartmann
## Modified by:
## Created:     29/06/2007
## RCS-ID:      $Id: $
## Copyright:   (c) 2007 Klaas Hartmann
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/graphics.h>

#if wxUSE_GRAPHICS_CONTEXT

#include <wx/graphics.h>

MODULE=Wx PACKAGE=Wx::GraphicsMatrix

void
wxGraphicsMatrix::Concat ( t )
    wxGraphicsMatrix* t

 # to implement
 # wxGraphicsMatrix::Get
 # void  Get(wxDouble* a=NULL, wxDouble* b=NULL, wxDouble* c=NULL, wxDouble* d=NULL, wxDouble* tx=NULL, wxDouble* ty=NULL) const
 #  Returns the component values of the matrix via the argument pointers.
 
 # omit
 # wxGraphicsMatrix::GetNativeMatrix
 # void * GetNativeMatrix() const
 #  Returns the native representation of the matrix. For CoreGraphics this is a CFAffineMatrix pointer. For GDIPlus a Matrix Pointer and for Cairo a cairo_matrix_t pointer.
 
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
 
 # TODO
 # wxGraphicsMatrix::TransformPoint
 # void TransformPoint(wxDouble* x, wxDouble* y) const
 # Applies this matrix to a point.
 
 # TODO 
 # wxGraphicsMatrix::TransformDistance
 # void TransformDistance(wxDouble* dx, wxDouble* dy) const
 # Applies this matrix to a distance (ie. performs all transforms except translations)

#endif
