/////////////////////////////////////////////////////////////////////////////
// Name:        dn_constants.cpp
// Purpose:     constants for Wx::DND
// Author:      Mattia Barbon
// Modified by:
// Created:     12/ 8/2001
// RCS-ID:      
// Copyright:   (c) 2001-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"
#include <wx/dnd.h>

const int Get = wxDataObjectBase::Get;
const int Set = wxDataObjectBase::Set;
const int Both = wxDataObjectBase::Both;

double dnd_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: dnd
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'B':
        r( Both );
        break;
    case 'D':
        r( wxDragError );
        r( wxDragNone );
        r( wxDragMove );
        r( wxDragCopy );
#if WXPERL_W_VERSION_GE( 2, 3, 2 )
        r( wxDragLink );
#endif
        r( wxDragCancel );

#if WXPERL_W_VERSION_GE( 2, 3, 3 )
        r( wxDrag_CopyOnly );
        r( wxDrag_AllowMove );
        r( wxDrag_DefaultMove );
#endif
        break;
    case 'G':
        r( Get );
        break;
    case 'S':
        r( Set );
        break;
    }
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants dnd_module( &dnd_constant );

