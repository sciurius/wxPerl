#############################################################################
## Name:        XS/Constraint.xs
## Purpose:     XS for Wx::LayoutConstraints
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id: Constraint.xs,v 1.5 2006/08/11 19:38:44 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/layout.h>

MODULE=Wx PACKAGE=Wx::IndividualLayoutConstraint

void
wxIndividualLayoutConstraint::Above( otherWin, margin = 0 )
    wxWindow* otherWin
    int margin

void
wxIndividualLayoutConstraint::Absolute( value )
    int value

void
wxIndividualLayoutConstraint::AsIs()

void
wxIndividualLayoutConstraint::Below( otherWin, margin = 0 )
    wxWindow* otherWin
    int margin

void
wxIndividualLayoutConstraint::Unconstrained()

void
wxIndividualLayoutConstraint::LeftOf( otherWin, margin = 0 )
    wxWindow* otherWin
    int margin

void
wxIndividualLayoutConstraint::PercentOf( otherWin, edge, per )
    wxWindow* otherWin
    wxEdge edge
    int per

void
wxIndividualLayoutConstraint::RightOf( otherWin, margin = 0 )
    wxWindow* otherWin
    int margin

void
wxIndividualLayoutConstraint::SameAs( otherWin, edge, margin = 0 )
    wxWindow* otherWin
    wxEdge edge
    int margin

void
wxIndividualLayoutConstraint::Set( rel, otherWin, otherEdge, value = 0, margin = 0 )
    wxRelationship rel
    wxWindow* otherWin
    wxEdge otherEdge
    int value
    int margin

MODULE=Wx PACKAGE=Wx::LayoutConstraints

wxLayoutConstraints*
wxLayoutConstraints::new()

wxIndividualLayoutConstraint*
wxLayoutConstraints::bottom()
  CODE:
    RETVAL = &THIS->bottom;
  OUTPUT:
    RETVAL

wxIndividualLayoutConstraint*
wxLayoutConstraints::centreX()
  CODE:
    RETVAL = &THIS->centreX;
  OUTPUT:
    RETVAL

wxIndividualLayoutConstraint*
wxLayoutConstraints::centreY()
  CODE:
    RETVAL = &THIS->centreY;
  OUTPUT:
    RETVAL

wxIndividualLayoutConstraint*
wxLayoutConstraints::height()
  CODE:
    RETVAL = &THIS->height;
  OUTPUT:
    RETVAL

wxIndividualLayoutConstraint*
wxLayoutConstraints::left()
  CODE:
    RETVAL = &THIS->left;
  OUTPUT:
    RETVAL

wxIndividualLayoutConstraint*
wxLayoutConstraints::right()
  CODE:
    RETVAL = &THIS->right;
  OUTPUT:
    RETVAL

wxIndividualLayoutConstraint*
wxLayoutConstraints::top()
  CODE:
    RETVAL = &THIS->top;
  OUTPUT:
    RETVAL

wxIndividualLayoutConstraint*
wxLayoutConstraints::width()
  CODE:
    RETVAL = &THIS->width;
  OUTPUT:
    RETVAL
