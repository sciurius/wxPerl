/////////////////////////////////////////////////////////////////////////////
// Name:        Help.xs
// Purpose:     XS for Wx::HelpController*
// Author:      Mattia Barbon
// Modified by:
// Created:     18/ 3/2001
// RCS-ID:      
// Copyright:   (c) 2001-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"
#include "cpp/he_typedef.h"

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
