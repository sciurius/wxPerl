/////////////////////////////////////////////////////////////////////////////
// Name:        MDI.xs
// Purpose:     XS for MDI
// Author:      Mattia Barbon
// Modified by:
// Created:      6/ 9/2001
// RCS-ID:      
// Copyright:   (c) 2001-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"
#include "cpp/md_typedef.h"

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
