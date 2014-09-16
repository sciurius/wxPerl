/////////////////////////////////////////////////////////////////////////////
// Name:        ext/grid/cpp/gr_constants.cpp
// Purpose:     constants for Wx::Grid
// Author:      Mattia Barbon
// Modified by:
// Created:     04/12/2001
// RCS-ID:      $Id$
// Copyright:   (c) 2001-2004, 2007 Mattia Barbon
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
    case 'G':
        r( wxGRIDTABLE_REQUEST_VIEW_GET_VALUES );
        r( wxGRIDTABLE_REQUEST_VIEW_SEND_VALUES );
        r( wxGRIDTABLE_NOTIFY_ROWS_INSERTED );
        r( wxGRIDTABLE_NOTIFY_ROWS_APPENDED );
        r( wxGRIDTABLE_NOTIFY_ROWS_DELETED );
        r( wxGRIDTABLE_NOTIFY_COLS_INSERTED );
        r( wxGRIDTABLE_NOTIFY_COLS_APPENDED );
        r( wxGRIDTABLE_NOTIFY_COLS_DELETED );
#if WXPERL_W_VERSION_GE( 2, 8, 8 )        
        r( wxGRID_AUTOSIZE );
#endif
#if WXPERL_W_VERSION_GE( 3, 0, 0 )
        r( wxGRID_COLUMN );
        r( wxGRID_ROW );
        r( wxGRID_DRAW_ROWS_HEADER );
        r( wxGRID_DRAW_COLS_HEADER );
        r( wxGRID_DRAW_CELL_LINES );
        r( wxGRID_DRAW_BOX_RECT );
        r( wxGRID_DRAW_SELECTION );
        r( wxGRID_DRAW_DEFAULT );
#endif
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
