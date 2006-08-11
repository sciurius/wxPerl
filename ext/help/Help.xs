/////////////////////////////////////////////////////////////////////////////
// Name:        ext/help/Help.xs
// Purpose:     XS for Wx::HelpController*
// Author:      Mattia Barbon
// Modified by:
// Created:     18/03/2001
// RCS-ID:      $Id: Help.xs,v 1.13 2006/08/11 19:38:46 mbarbon Exp $
// Copyright:   (c) 2001-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

MODULE=Wx__Help

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/HelpController.xs
INCLUDE: XS/HelpProvider.xs
INCLUDE: XS/ContextHelp.xs

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Help
