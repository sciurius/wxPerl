/////////////////////////////////////////////////////////////////////////////
// Name:        ext/docview/cpp/dv_constants.cpp
// Purpose:     constants for Wx::DocView
// Author:      Simon Flack
// Created:     11/09/2002
// RCS-ID:      $Id$
// Copyright:   (c) 2002-2005 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

double docview_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: docview
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();
    //  if( strlen( name ) >= 7 )
    //      fl = name[6];
    //  else
    //      fl = 0;

    switch( fl )
    {
      case 'D':
         r( wxDEFAULT_TEMPLATE_FLAGS );
         r( wxDEFAULT_DOCMAN_FLAGS );
         r( wxDOC_SDI );
         r( wxDOC_MDI );
         r( wxDOC_NEW );
         r( wxDOC_SILENT );
         break;
      case 'T':
         r( wxTEMPLATE_VISIBLE );
         r( wxTEMPLATE_INVISIBLE );
         break;
      case 'M':
         r( wxMAX_FILE_HISTORY );
         break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants docview_module( &docview_constant );
