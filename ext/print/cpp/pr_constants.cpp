/////////////////////////////////////////////////////////////////////////////
// Name:        ext/print/cpp/pr_constants.cpp
// Purpose:     constants for Print framework
// Author:      Mattia Barbon
// Modified by:
// Created:     04/05/2001
// RCS-ID:      $Id: pr_constants.cpp,v 1.5 2004/12/21 21:12:56 mbarbon Exp $
// Copyright:   (c) 2001, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

double print_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: print
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'D':
        r( wxDUPLEX_SIMPLEX );
        r( wxDUPLEX_HORIZONTAL );
        r( wxDUPLEX_VERTICAL );
        break;
    case 'L':
        r( wxLANDSCAPE );
        break;
    case 'H':
        break;
    case 'P':
        r( wxPAPER_NONE );
        r( wxPAPER_LETTER );
        r( wxPAPER_LEGAL );
        r( wxPAPER_A4 );
        r( wxPAPER_CSHEET );
        r( wxPAPER_DSHEET );
        r( wxPAPER_ESHEET );
        r( wxPAPER_LETTERSMALL );
        r( wxPAPER_TABLOID );
        r( wxPAPER_LEDGER );
        r( wxPAPER_STATEMENT );
        r( wxPAPER_EXECUTIVE );
        r( wxPAPER_A3 );
        r( wxPAPER_A4SMALL );
        r( wxPAPER_A5 );
        r( wxPAPER_B4 );
        r( wxPAPER_B5 );
        r( wxPAPER_FOLIO );
        r( wxPAPER_QUARTO );
        r( wxPAPER_10X14 );
        r( wxPAPER_11X17 );
        r( wxPAPER_NOTE );
        r( wxPAPER_ENV_9 );
        r( wxPAPER_ENV_10 );
        r( wxPAPER_ENV_11 );
        r( wxPAPER_ENV_12 );
        r( wxPAPER_ENV_14 );
        r( wxPAPER_ENV_DL );
        r( wxPAPER_ENV_C5 );
        r( wxPAPER_ENV_C3 );
        r( wxPAPER_ENV_C4 );
        r( wxPAPER_ENV_C6 );
        r( wxPAPER_ENV_C65 );
        r( wxPAPER_ENV_B4 );
        r( wxPAPER_ENV_B5 );
        r( wxPAPER_ENV_B6 );
        r( wxPAPER_ENV_ITALY );
        r( wxPAPER_ENV_MONARCH );
        r( wxPAPER_ENV_PERSONAL );
        r( wxPAPER_FANFOLD_US );
        r( wxPAPER_FANFOLD_STD_GERMAN );
        r( wxPAPER_FANFOLD_LGL_GERMAN );
        r( wxPAPER_ISO_B4 );
        r( wxPAPER_JAPANESE_POSTCARD );
        r( wxPAPER_9X11 );
        r( wxPAPER_10X11 );
        r( wxPAPER_15X11 );
        r( wxPAPER_ENV_INVITE );
        r( wxPAPER_LETTER_EXTRA );
        r( wxPAPER_LEGAL_EXTRA );
        r( wxPAPER_TABLOID_EXTRA );
        r( wxPAPER_A4_EXTRA );
        r( wxPAPER_LETTER_TRANSVERSE );
        r( wxPAPER_A4_TRANSVERSE );
        r( wxPAPER_LETTER_EXTRA_TRANSVERSE );
        r( wxPAPER_A_PLUS );
        r( wxPAPER_B_PLUS );
        r( wxPAPER_LETTER_PLUS );
        r( wxPAPER_A4_PLUS );
        r( wxPAPER_A5_TRANSVERSE );
        r( wxPAPER_B5_TRANSVERSE );
        r( wxPAPER_A3_EXTRA );
        r( wxPAPER_A5_EXTRA );
        r( wxPAPER_B5_EXTRA );
        r( wxPAPER_A2 );
        r( wxPAPER_A3_TRANSVERSE );
        r( wxPAPER_A3_EXTRA_TRANSVERSE );

        r( wxPORTRAIT );

        r( wxPREVIEW_PRINT );
        r( wxPREVIEW_NEXT );
        r( wxPREVIEW_PREVIOUS );
        r( wxPREVIEW_ZOOM );
        r( wxPREVIEW_DEFAULT );

        r( wxPRINT_QUALITY_HIGH );
        r( wxPRINT_QUALITY_MEDIUM );
        r( wxPRINT_QUALITY_LOW );
        r( wxPRINT_QUALITY_DRAFT );

        r( wxPRINTER_NO_ERROR );
        r( wxPRINTER_CANCELLED );
        r( wxPRINTER_ERROR );
        break;
    default:
        break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants print_module( &print_constant );
