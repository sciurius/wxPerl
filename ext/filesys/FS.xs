/////////////////////////////////////////////////////////////////////////////
// Name:        ext/filesys/FS.xs
// Purpose:     XS for Wx::FileSystem and related classes
// Author:      Mattia Barbon
// Modified by:
// Created:     28/04/2001
// RCS-ID:      $Id: FS.xs,v 1.11 2004/12/21 21:12:50 mbarbon Exp $
// Copyright:   (c) 2001-2002, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

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
