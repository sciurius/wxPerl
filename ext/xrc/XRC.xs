/////////////////////////////////////////////////////////////////////////////
// Name:        XRC.xs
// Purpose:     XS for wxWindows XML Resources
// Author:      Mattia Barbon
// Modified by:
// Created:     27/ 7/2001
// RCS-ID:      
// Copyright:   (c) 2001-2002 Mattia Barbon
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

MODULE=Wx__XRC PACKAGE=Wx PREFIX=wx

void
wxXmlInitXmlModule()
  CODE:
#if WXPERL_W_VERSION_GE( 2, 3, 3 )
    // nothing here
#else
    wxXmlInitXmlModule();
#endif

void
wxXmlInitResourceModule()

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__XRC
