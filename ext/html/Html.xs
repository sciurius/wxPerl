/////////////////////////////////////////////////////////////////////////////
// Name:        Html.xs
// Purpose:     XS for Wx::Html*
// Author:      Mattia Barbon
// Modified by:
// Created:     10/ 3/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>
#include <stdarg.h>

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy
#undef Pause
#undef New
#undef read
#undef eof
#undef write
#ifdef __WXMSW__
#undef form
#undef vform
#endif

#undef THIS

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#include "cpp/compat.h"
#if !WXPL_MSW_EXPORTS
#define _WXP_DEFINE_CLASSNAME 1
#endif
#include "cpp/typedef.h"
#include "cpp/helpers.h"
#include "cpp/ht_typedef.h"

MODULE=Wx__Html

BOOT:
#if !WXPL_MSW_EXPORTS
  INIT_PLI_HELPERS( wx_pli_helpers );
#endif

INCLUDE: XS/HtmlWindow.xs
INCLUDE: XS/HtmlHelpController.xs

#include "cpp/ht_constants.cpp"

#  //FIXME//tricky
#if __WXMSW__
#undef XS
#define XS( name ) __declspec(dllexport) void name( pTHXo_ CV* cv )
#endif

MODULE=Wx__Html