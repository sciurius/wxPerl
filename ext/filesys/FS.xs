/////////////////////////////////////////////////////////////////////////////
// Name:        ext/filesys/FS.xs
// Purpose:     XS for Wx::FileSystem and related classes
// Author:      Mattia Barbon
// Modified by:
// Created:     28/04/2001
// RCS-ID:      $Id: FS.xs,v 1.12 2006/11/21 21:08:21 mbarbon Exp $
// Copyright:   (c) 2001-2002, 2004, 2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"

#undef THIS

#if WXPERL_W_VERSION_GE( 2, 7, 2 )
#include <wx/filesys.h>

double fs_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: filesystem
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'F':
        r( wxFS_READ );
        r( wxFS_SEEKABLE );
        break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants fs_module( &fs_constant );
#endif

MODULE=Wx__FS

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/FileSystem.xs
INCLUDE: XS/FileSystemHandler.xs
INCLUDE: XS/FSFile.xs

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__FS
