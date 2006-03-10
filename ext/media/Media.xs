/////////////////////////////////////////////////////////////////////////////
// Name:        ext/media/Media.xs
// Purpose:     XS for wxWidgets multimedia control
// Author:      Mattia Barbon
// Modified by:
// Created:     04/03/2006
// RCS-ID:      $Id: Media.xs,v 1.1 2006/03/10 19:25:33 mbarbon Exp $
// Copyright:   (c) 2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
// #include "cpp/xr_constants.cpp"

#undef THIS

MODULE=Wx__Media

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: perl ../../script/xsubppp.pl --typemap ../../typemap.xsp XS/MediaCtrl.xsp |

#include "cpp/overload.h"
#include "cpp/ovl_const.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Media
