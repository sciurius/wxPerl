/////////////////////////////////////////////////////////////////////////////
// Name:        ext/aui/AUI.xs
// Purpose:     XS for Wx::AUI
// Author:      Mattia Barbon
// Modified by:
// Created:     11/11/2006
// RCS-ID:      $Id: AUI.xs,v 1.1 2006/11/11 21:34:07 mbarbon Exp $
// Copyright:   (c) 2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"
#include "cpp/overload.h"

#undef THIS

MODULE=Wx__AUI

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/AuiManager.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t typemap.xsp -t ../../typemap.xsp XS/AuiPaneInfo.xsp |

#include "cpp/ovl_const.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__AUI
