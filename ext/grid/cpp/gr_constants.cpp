/////////////////////////////////////////////////////////////////////////////
// Name:        gr_constants.cpp
// Purpose:     constants for Wx::Grid
// Author:      Mattia Barbon
// Modified by:
// Created:      4/12/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
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
#if WXPERL_W_VERSION_GE( 2, 3, 1 )
        r( wxEVT_GRID_EDITOR_CREATED );
#endif
        break;
    // !export: wxGridSelectCells wxGridSelectRows wxGridSelectColumns
    case 'G':
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
