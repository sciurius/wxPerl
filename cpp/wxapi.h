/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/wxapi.h
// Purpose:     Magic to be included to get access to wxPerl API
// Author:      Mattia Barbon
// Modified by:
// Created:     21/ 9/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifdef __CPP_WXAPI_H
#error "cpp/wxapi.h must be included only once!"
#endif

#define __CPP_WXAPI_H

#undef bool

#include <wx/defs.h>

#include "cpp/compat.h"
#include "cpp/chkconfig.h"

WXPL_EXTERN_C_START
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
WXPL_EXTERN_C_END

#undef bool
#undef Move
#undef Copy
#undef New
#undef Pause
#undef Mkdir
#undef Seek
#undef Stat
#if defined( __WXMSW__ )
#undef read
#undef write
#undef eof
#undef form
#undef vform
#undef do_open
#undef do_close
#endif

#if __VISUALC__
#pragma warning ( disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

// some helper functions/classes/macros
#include "cpp/helpers.h"
