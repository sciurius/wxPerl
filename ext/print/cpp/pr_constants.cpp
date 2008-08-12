/////////////////////////////////////////////////////////////////////////////
// Name:        ext/print/cpp/pr_constants.cpp
// Purpose:     constants for Print framework
// Author:      Mattia Barbon
// Modified by:
// Created:     04/05/2001
// RCS-ID:      $Id$
// Copyright:   (c) 2001, 2004-2005, 2008 Mattia Barbon
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
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxPAPER_12X11 );
        r( wxPAPER_A3_ROTATED );
        r( wxPAPER_A4_ROTATED );
        r( wxPAPER_A5_ROTATED );
        r( wxPAPER_A6 );
        r( wxPAPER_A6_ROTATED );
        r( wxPAPER_B4_JIS_ROTATED );
        r( wxPAPER_B5_JIS_ROTATED );
        r( wxPAPER_B6_JIS );
        r( wxPAPER_B6_JIS_ROTATED );
        r( wxPAPER_DBL_JAPANESE_POSTCARD );
        r( wxPAPER_DBL_JAPANESE_POSTCARD_ROTATED );
        r( wxPAPER_JAPANESE_POSTCARD_ROTATED );
        r( wxPAPER_JENV_CHOU3 );
        r( wxPAPER_JENV_CHOU3_ROTATED );
        r( wxPAPER_JENV_CHOU4 );
        r( wxPAPER_JENV_CHOU4_ROTATED );
        r( wxPAPER_JENV_KAKU2 );
        r( wxPAPER_JENV_KAKU2_ROTATED );
        r( wxPAPER_JENV_KAKU3 );
        r( wxPAPER_JENV_KAKU3_ROTATED );
        r( wxPAPER_JENV_YOU4 );
        r( wxPAPER_JENV_YOU4_ROTATED );
        r( wxPAPER_LETTER_ROTATED );
        r( wxPAPER_P16K );
        r( wxPAPER_P16K_ROTATED );
        r( wxPAPER_P32K );
        r( wxPAPER_P32KBIG );
        r( wxPAPER_P32KBIG_ROTATED );
        r( wxPAPER_P32K_ROTATED );
        r( wxPAPER_PENV_1 );
        r( wxPAPER_PENV_10 );
        r( wxPAPER_PENV_10_ROTATED );
        r( wxPAPER_PENV_1_ROTATED );
        r( wxPAPER_PENV_2 );
        r( wxPAPER_PENV_2_ROTATED );
        r( wxPAPER_PENV_3 );
        r( wxPAPER_PENV_3_ROTATED );
        r( wxPAPER_PENV_4 );
        r( wxPAPER_PENV_4_ROTATED );
        r( wxPAPER_PENV_5 );
        r( wxPAPER_PENV_5_ROTATED );
        r( wxPAPER_PENV_6 );
        r( wxPAPER_PENV_6_ROTATED );
        r( wxPAPER_PENV_7 );
        r( wxPAPER_PENV_7_ROTATED );
        r( wxPAPER_PENV_8 );
        r( wxPAPER_PENV_8_ROTATED );
        r( wxPAPER_PENV_9 );
        r( wxPAPER_PENV_9_ROTATED );
#endif

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

        r( wxPRINT_MODE_FILE );
        r( wxPRINT_MODE_NONE );
        r( wxPRINT_MODE_PREVIEW );
        r( wxPRINT_MODE_PRINTER );
        r( wxPRINT_MODE_STREAM );

        r( wxPRINTER_NO_ERROR );
        r( wxPRINTER_CANCELLED );
        r( wxPRINTER_ERROR );
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
        r( wxPRINTBIN_DEFAULT );

        r( wxPRINTBIN_ONLYONE );
        r( wxPRINTBIN_LOWER );
        r( wxPRINTBIN_MIDDLE );
        r( wxPRINTBIN_MANUAL );
        r( wxPRINTBIN_ENVELOPE );
        r( wxPRINTBIN_ENVMANUAL );
        r( wxPRINTBIN_AUTO );
        r( wxPRINTBIN_TRACTOR );
        r( wxPRINTBIN_SMALLFMT );
        r( wxPRINTBIN_LARGEFMT );
        r( wxPRINTBIN_LARGECAPACITY );
        r( wxPRINTBIN_CASSETTE );
        r( wxPRINTBIN_FORMSOURCE );

        r( wxPRINTBIN_USER );
#endif
        break;
    default:
        break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants print_module( &print_constant );
