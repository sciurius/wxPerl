/////////////////////////////////////////////////////////////////////////////
// Name:        ext/xrc/XRC.xs
// Purpose:     XS for wxWindows XML Resources
// Author:      Mattia Barbon
// Modified by:
// Created:     27/07/2001
// RCS-ID:      $Id: XRC.xs,v 1.12 2003/06/05 17:20:59 mbarbon Exp $
// Copyright:   (c) 2001-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"
#include "cpp/xr_typedef.h"
#include "cpp/xr_constants.cpp"

#undef THIS

MODULE=Wx__XRC

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/XmlResource.xs
INCLUDE: perl ../../script/xsubppp.pl --typemap ../../typemap.xsp XS/XmlSubclassFactory.xsp |

MODULE=Wx__XRC PACKAGE=Wx PREFIX=wx

void
wxXmlInitXmlModule()
  CODE:
    // nothing here

void
wxXmlInitResourceModule()

#include "cpp/overload.h"
#include "cpp/ovl_const.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__XRC
