#############################################################################
## Name:        Constraints.xs
## Purpose:     XS for Wx::LayoutConstraints
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/layout.h>

MODULE=Wx PACKAGE=Wx::IndividualLayoutConstraint

void
Wx_IndividualLayoutConstraint::Above( otherWin, margin = 0 )
    Wx_Window* otherWin
    int margin

void
Wx_IndividualLayoutConstraint::Absolute( value )
    int value

void
Wx_IndividualLayoutConstraint::AsIs()

void
Wx_IndividualLayoutConstraint::Below( otherWin, margin = 0 )
    Wx_Window* otherWin
    int margin

void
Wx_IndividualLayoutConstraint::Unconstrained()

void
Wx_IndividualLayoutConstraint::LeftOf( otherWin, margin = 0 )
    Wx_Window* otherWin
    int margin

void
Wx_IndividualLayoutConstraint::PercentOf( otherWin, edge, per )
    Wx_Window* otherWin
    wxEdge edge
    int per

void
Wx_IndividualLayoutConstraint::RightOf( otherWin, margin = 0 )
    Wx_Window* otherWin
    int margin

void
Wx_IndividualLayoutConstraint::SameAs( otherWin, edge, margin = 0 )
    Wx_Window* otherWin
    wxEdge edge
    int margin

void
Wx_IndividualLayoutConstraint::Set( rel, otherWin, otherEdge, value = 0, margin = 0 )
    wxRelationship rel
    Wx_Window* otherWin
    wxEdge otherEdge
    int value
    int margin

MODULE=Wx PACKAGE=Wx::LayoutConstraints

Wx_LayoutConstraints*
Wx_LayoutConstraints::new()

Wx_IndividualLayoutConstraint*
Wx_LayoutConstraints::bottom()
  CODE:
    RETVAL = &THIS->bottom;
  OUTPUT:
    RETVAL

Wx_IndividualLayoutConstraint*
Wx_LayoutConstraints::centreX()
  CODE:
    RETVAL = &THIS->centreX;
  OUTPUT:
    RETVAL

Wx_IndividualLayoutConstraint*
Wx_LayoutConstraints::centreY()
  CODE:
    RETVAL = &THIS->centreY;
  OUTPUT:
    RETVAL

Wx_IndividualLayoutConstraint*
Wx_LayoutConstraints::height()
  CODE:
    RETVAL = &THIS->height;
  OUTPUT:
    RETVAL

Wx_IndividualLayoutConstraint*
Wx_LayoutConstraints::left()
  CODE:
    RETVAL = &THIS->left;
  OUTPUT:
    RETVAL

Wx_IndividualLayoutConstraint*
Wx_LayoutConstraints::right()
  CODE:
    RETVAL = &THIS->right;
  OUTPUT:
    RETVAL

Wx_IndividualLayoutConstraint*
Wx_LayoutConstraints::top()
  CODE:
    RETVAL = &THIS->top;
  OUTPUT:
    RETVAL

Wx_IndividualLayoutConstraint*
Wx_LayoutConstraints::width()
  CODE:
    RETVAL = &THIS->width;
  OUTPUT:
    RETVAL
