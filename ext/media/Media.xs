/////////////////////////////////////////////////////////////////////////////
// Name:        ext/media/Media.xs
// Purpose:     XS for wxWidgets multimedia control
// Author:      Mattia Barbon
// Modified by:
// Created:     04/03/2006
// RCS-ID:      $Id$
// Copyright:   (c) 2006, 2008 Mattia Barbon
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

INCLUDE: xspp -t ../../typemap.xsp XS/MediaCtrl.xsp |

INCLUDE: xspp -t ../../typemap.xsp XS/MediaEvent.xsp |

#include "cpp/overload.h"
#include "cpp/ovl_const.cpp"
#include "cpp/me_constants.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Media
