/////////////////////////////////////////////////////////////////////////////
// Name:        ext/calendar/Calendar.xs
// Purpose:     XS for Wx::DateTime
// Author:      Mattia Barbon
// Modified by:
// Created:     22/09/2002
// RCS-ID:      $Id: Calendar.xs,v 1.9 2006/08/19 18:24:34 mbarbon Exp $
// Copyright:   (c) 2002, 2005-2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"
#include "cpp/overload.h"

#define wxDefaultDateTimePtr (wxDateTime*)&wxDefaultDateTime
#define wxDefaultValidatorPtr (wxValidator*)&wxDefaultValidator
#define wxDateTime__WeekDay wxDateTime::WeekDay

#undef THIS

MODULE=Wx__Calendar

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: perl ../../script/wx_xspp.pl -t ../../typemap.xsp XS/DatePickerCtrl.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t ../../typemap.xsp XS/CalendarCtrl.xsp |

INCLUDE: perl ../../script/wx_xspp.pl -t ../../typemap.xsp XS/CalendarDateAttr.xsp |

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Calendar
