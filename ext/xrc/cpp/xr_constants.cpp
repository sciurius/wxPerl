/////////////////////////////////////////////////////////////////////////////
// Name:        xr_constants.cpp
// Purpose:     constants for XRC
// Author:      Mattia Barbon
// Modified by:
// Created:      4/ 4/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

#include "wx/xrc/xmlres.h"

double xrc_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag:
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'X':
        r( wxXRC_USE_LOCALE );
        r( wxXRC_NO_SUBCLASSING );
        break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants listctrl_module( &xrc_constant );

#endif
