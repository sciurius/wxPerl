/////////////////////////////////////////////////////////////////////////////
// Name:        ext/grid/cpp/gr_constants.cpp
// Purpose:     constants for Wx::Grid
// Author:      Mattia Barbon
// Modified by:
// Created:     04/12/2001
// RCS-ID:      $Id: gr_constants.cpp,v 1.7 2004/02/29 14:30:40 mbarbon Exp $
// Copyright:   (c) 2001-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

double grid_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: grid
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'E':
        r( wxEVT_GRID_CELL_LEFT_CLICK );
        r( wxEVT_GRID_CELL_RIGHT_CLICK );
        r( wxEVT_GRID_CELL_LEFT_DCLICK );
        r( wxEVT_GRID_CELL_RIGHT_DCLICK );
        r( wxEVT_GRID_LABEL_LEFT_CLICK );
        r( wxEVT_GRID_LABEL_RIGHT_CLICK );
        r( wxEVT_GRID_LABEL_LEFT_DCLICK );
        r( wxEVT_GRID_LABEL_RIGHT_DCLICK );
        r( wxEVT_GRID_ROW_SIZE );
        r( wxEVT_GRID_COL_SIZE );
        r( wxEVT_GRID_RANGE_SELECT );
        r( wxEVT_GRID_CELL_CHANGE );
        r( wxEVT_GRID_SELECT_CELL );
        r( wxEVT_GRID_EDITOR_SHOWN );
        r( wxEVT_GRID_EDITOR_HIDDEN );
        r( wxEVT_GRID_EDITOR_CREATED );
        break;
    case 'G':
        r( wxGRIDTABLE_REQUEST_VIEW_GET_VALUES );
        r( wxGRIDTABLE_REQUEST_VIEW_SEND_VALUES );
        r( wxGRIDTABLE_NOTIFY_ROWS_INSERTED );
        r( wxGRIDTABLE_NOTIFY_ROWS_APPENDED );
        r( wxGRIDTABLE_NOTIFY_ROWS_DELETED );
        r( wxGRIDTABLE_NOTIFY_COLS_INSERTED );
        r( wxGRIDTABLE_NOTIFY_COLS_APPENDED );
        r( wxGRIDTABLE_NOTIFY_COLS_DELETED );

        // !export: wxGridSelectCells wxGridSelectRows wxGridSelectColumns
        if( strEQ( name, "wxGridSelectCells" ) )
            return wxGrid::wxGridSelectCells;
        if( strEQ( name, "wxGridSelectRows" ) )
            return wxGrid::wxGridSelectRows;
        if( strEQ( name, "wxGridSelectColumns" ) )
            return wxGrid::wxGridSelectColumns;
        break;
    }
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants grid_module( &grid_constant );
