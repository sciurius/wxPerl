#############################################################################
## Name:        ext/grid/XS/GridCellRenderer.xs
## Purpose:     XS for Wx::GridCellRenderer*
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2001
## RCS-ID:      $Id: GridCellRenderer.xs,v 1.9 2006/08/11 19:38:46 mbarbon Exp $
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::GridCellRenderer

void
wxGridCellRenderer::Draw( grid, attr, dc, rect, row, col, isSelected )
    wxGrid* grid
    wxGridCellAttr* attr
    wxDC* dc
    wxRect* rect
    int row
    int col
    bool isSelected
  CODE:
    THIS->Draw( *grid, *attr, *dc, *rect, row, col, isSelected );

wxSize*
wxGridCellRenderer::GetBestSize( grid, attr, dc, row, col )
    wxGrid* grid
    wxGridCellAttr* attr
    wxDC* dc
    int row
    int col
  CODE:
    RETVAL = new wxSize( THIS->GetBestSize( *grid, *attr, *dc, row, col ) );
  OUTPUT:
    RETVAL

## // thread KO
void
wxGridCellRenderer::DESTROY()
  CODE:
    if( THIS )
        THIS->DecRef();

void
wxGridCellRenderer::SetParameters( parameters )
    wxString parameters

MODULE=Wx PACKAGE=Wx::GridCellStringRenderer

wxGridCellStringRenderer*
wxGridCellStringRenderer::new()

MODULE=Wx PACKAGE=Wx::GridCellNumberRenderer

wxGridCellNumberRenderer*
wxGridCellNumberRenderer::new()

MODULE=Wx PACKAGE=Wx::GridCellFloatRenderer

wxGridCellFloatRenderer*
wxGridCellFloatRenderer::new( width = -1, precision = -1 )
    int width
    int precision

int
wxGridCellFloatRenderer::GetWidth()

int
wxGridCellFloatRenderer::GetPrecision()

void
wxGridCellFloatRenderer::SetWidth( width )
    int width

void
wxGridCellFloatRenderer::SetPrecision( precision )
    int precision

MODULE=Wx PACKAGE=Wx::GridCellBoolRenderer

wxGridCellBoolRenderer*
wxGridCellBoolRenderer::new()

MODULE=Wx PACKAGE=Wx::PlGridCellRenderer

#include "cpp/renderer.h"

SV*
wxPlGridCellRenderer::new()
  CODE:
    wxPlGridCellRenderer* r = new wxPlGridCellRenderer( CLASS );
    r->SetClientObject( new wxPliUserDataCD( r->m_callback.GetSelf() ) );
    RETVAL = r->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT: RETVAL

void
wxPlGridCellRenderer::Draw( grid, attr, dc, rect, row, col, isSelected )
    wxGrid* grid
    wxGridCellAttr* attr
    wxDC* dc
    wxRect* rect
    int row
    int col
    bool isSelected
  CODE:
    THIS->wxGridCellRenderer::Draw( *grid, *attr, *dc, *rect,
                                    row, col, isSelected );
