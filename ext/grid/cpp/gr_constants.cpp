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
