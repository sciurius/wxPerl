/////////////////////////////////////////////////////////////////////////////
// Name:        ext/mdi/MDI.xs
// Purpose:     XS for MDI
// Author:      Mattia Barbon
// Modified by:
// Created:     06/09/2001
// RCS-ID:      $Id: MDI.xs,v 1.11 2004/12/21 21:12:54 mbarbon Exp $
// Copyright:   (c) 2001-2002, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

MODULE=Wx__MDI

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/MDIChildFrame.xs
INCLUDE: XS/MDIParentFrame.xs

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__MDI
