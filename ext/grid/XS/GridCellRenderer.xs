#############################################################################
## Name:        ext/grid/XS/GridCellRenderer.xs
## Purpose:     XS for Wx::GridCellRenderer*
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2001
## RCS-ID:      $Id: GridCellRenderer.xs,v 1.12 2007/03/27 19:33:33 mbarbon Exp $
## Copyright:   (c) 2001-2007 Mattia Barbon
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

static void
wxGridCellRenderer::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxGridCellRenderer::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ ST(0) ),
                                SvRV( ST(0) ), ST(0) );
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

MODULE=Wx PACKAGE=Wx::GridCellAutoWrapStringRenderer

wxGridCellAutoWrapStringRenderer*
wxGridCellAutoWrapStringRenderer::new()

MODULE=Wx PACKAGE=Wx::GridCellEnumRenderer

wxGridCellEnumRenderer*
wxGridCellEnumRenderer::new( choices = wxEmptyString )
    wxString choices
    
MODULE=Wx PACKAGE=Wx::GridCellDateTimeRenderer   

#if WXPERL_W_VERSION_LT( 2, 6, 0 )
#define wxDefaultDateTimeFormat wxT("%c")
#endif

wxGridCellDateTimeRenderer*
wxGridCellDateTimeRenderer::new( outformat = wxDefaultDateTimeFormat, informat = wxDefaultDateTimeFormat )
    wxString outformat
    wxString informat    

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
