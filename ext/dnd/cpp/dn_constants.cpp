/////////////////////////////////////////////////////////////////////////////
// Name:        ext/dnd/cpp/dn_constants.cpp
// Purpose:     constants for Wx::DND
// Author:      Mattia Barbon
// Modified by:
// Created:     12/08/2001
// RCS-ID:      $Id$
// Copyright:   (c) 2001-2003 Mattia Barbon
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
#if wxPERL_USE_DRAG_AND_DROP
        r( wxDragError );
        r( wxDragNone );
        r( wxDragMove );
        r( wxDragCopy );
        r( wxDragLink );
        r( wxDragCancel );

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

