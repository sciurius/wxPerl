/////////////////////////////////////////////////////////////////////////////
// Name:        dv_constants.cpp
// Purpose:     constants for Wx::DocView
// Author:      Simon Flack
// Created:     11/ 9/2002
// RCS-ID:
// Copyright:   (c) 2002 Mattia Barbon
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
      case 'I':
         r( wxID_OPEN );
         r( wxID_CLOSE );
         r( wxID_CLOSE_ALL );
         r( wxID_NEW );
         r( wxID_SAVE );
         r( wxID_SAVEAS );
         r( wxID_REVERT );
         r( wxID_EXIT );
         r( wxID_UNDO );
         r( wxID_REDO );
         r( wxID_HELP );
         r( wxID_PRINT );
         r( wxID_PRINT_SETUP );
         r( wxID_PREVIEW );
         break;
      case 'D':
         r( wxDEFAULT_TEMPLATE_FLAGS );
         break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants docview_module( &docview_constant );
