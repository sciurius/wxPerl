#############################################################################
## Name:        GridCellRenderer.xs
## Purpose:     XS for Wx::GridCellRenderer*
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2001
## RCS-ID:      $Id: GridCellRenderer.xs,v 1.4 2003/05/28 20:53:01 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::GridCellRenderer

void
Wx_GridCellRenderer::Draw( grid, attr, dc, rect, row, col, isSelected )
    Wx_Grid* grid
    Wx_GridCellAttr* attr
    Wx_DC* dc
    Wx_Rect* rect
    int row
    int col
    bool isSelected
  CODE:
    THIS->Draw( *grid, *attr, *dc, *rect, row, col, isSelected );

Wx_Size*
Wx_GridCellRenderer::GetBestSize( grid, attr, dc, row, col )
    Wx_Grid* grid
    Wx_GridCellAttr* attr
    Wx_DC* dc
    int row
    int col
  CODE:
    RETVAL = new wxSize( THIS->GetBestSize( *grid, *attr, *dc, row, col ) );
  OUTPUT:
    RETVAL

## XXX threads
void
Wx_GridCellRenderer::DESTROY()
  CODE:
    if( THIS )
        THIS->DecRef();

void
Wx_GridCellRenderer::SetParameters( parameters )
    wxString parameters

MODULE=Wx PACKAGE=Wx::GridCellStringRenderer

Wx_GridCellStringRenderer*
Wx_GridCellStringRenderer::new()

MODULE=Wx PACKAGE=Wx::GridCellNumberRenderer

Wx_GridCellNumberRenderer*
Wx_GridCellNumberRenderer::new()

MODULE=Wx PACKAGE=Wx::GridCellFloatRenderer

Wx_GridCellFloatRenderer*
Wx_GridCellFloatRenderer::new( width = -1, precision = -1 )
    int width
    int precision

int
Wx_GridCellFloatRenderer::GetWidth()

int
Wx_GridCellFloatRenderer::GetPrecision()

void
Wx_GridCellFloatRenderer::SetWidth( width )
    int width

void
Wx_GridCellFloatRenderer::SetPrecision( precision )
    int precision

MODULE=Wx PACKAGE=Wx::GridCellBoolRenderer

Wx_GridCellBoolRenderer*
Wx_GridCellBoolRenderer::new()

MODULE=Wx PACKAGE=Wx::PlGridCellRenderer

#include "cpp/renderer.h"

SV*
wxPlGridCellRenderer::new()
  CODE:
    wxPlGridCellRenderer* r = new wxPlGridCellRenderer( CLASS );
    RETVAL = r->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT: RETVAL


