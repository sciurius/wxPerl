/////////////////////////////////////////////////////////////////////////////
// Name:        ext/calendar/Calendar.xs
// Purpose:     XS for Wx::DateTime
// Author:      Mattia Barbon
// Modified by:
// Created:     22/ 9/2002
// RCS-ID:      $Id: Calendar.xs,v 1.3 2003/04/22 19:24:39 mbarbon Exp $
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"

#undef THIS

MODULE=Wx__Calendar

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: perl ../../script/xsubppp.pl --typemap=../../typemap.xsp XS/CalendarCtrl.xsp |
INCLUDE: perl ../../script/xsubppp.pl --typemap=../../typemap.xsp XS/CalendarDateAttr.xsp |

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Calendar
