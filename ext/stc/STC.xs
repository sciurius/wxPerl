/////////////////////////////////////////////////////////////////////////////
// Name:        ext/stc/STC.xs
// Purpose:     XS for Wx::STC
// Author:      Mattia Barbon
// Modified by:
// Created:     23/05/2002
// RCS-ID:      $Id: STC.xs,v 1.4 2004/01/18 08:19:20 mbarbon Exp $
// Copyright:   (c) 2002-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"
#include "cpp/st_typedef.h"

#undef THIS

MODULE=Wx__STC

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/StyledTextCtrl.xs

INCLUDE: perl ../../script/xsubppp.pl --typemap=../../typemap.xsp XS/StyledTextEvent.xsp |

#include "cpp/st_constants.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__STC
