/////////////////////////////////////////////////////////////////////////////
// Name:        ext/mdi/MDI.xs
// Purpose:     XS for MDI
// Author:      Mattia Barbon
// Modified by:
// Created:     06/09/2001
// RCS-ID:      $Id: MDI.xs,v 1.10 2004/03/01 21:24:10 mbarbon Exp $
// Copyright:   (c) 2001-2002 Mattia Barbon
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
