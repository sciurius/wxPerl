/////////////////////////////////////////////////////////////////////////////
// Name:        Grid.xs
// Purpose:     XS for Wx::Grid
// Author:      Mattia Barbon
// Modified by:
// Created:      4/12/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>
#include <stdarg.h>

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

#if !WXPL_MSW_EXPORTS
#define _WXP_DEFINE_CLASSNAME 1
#endif
#include "cpp/typedef.h"
#include "cpp/helpers.h"
#include "cpp/gr_typedef.h"

#include <wx/grid.h>
typedef wxGrid::wxGridSelectionModes wxGridSelectionModes;
typedef wxGridCellAttr::wxAttrKind wxAttrKind;

MODULE=Wx__Grid

BOOT:
#if !WXPL_MSW_EXPORTS
  INIT_PLI_HELPERS( wx_pli_helpers );
#endif

INCLUDE: XS/Grid.xs
INCLUDE: XS/GridCellAttr.xs

#include "cpp/gr_constants.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) __declspec(dllexport) void name( pTHXo_ CV* cv )
#endif

MODULE=Wx__Grid