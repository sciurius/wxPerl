/////////////////////////////////////////////////////////////////////////////
// Name:        DND.xs
// Purpose:     XS for Drag'n'Drop and Clipboard
// Author:      Mattia Barbon
// Modified by:
// Created:     12/ 8/2001
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
#include "cpp/dn_typedef.h"

#include <wx/dataobj.h>
#include "cpp/dn_constants.cpp"

typedef wxDataObjectBase::Direction Direction;
typedef wxDataFormat::NativeFormat  NativeFormat;

MODULE=Wx__DND

BOOT:
#if !WXPL_MSW_EXPORTS
  INIT_PLI_HELPERS( wx_pli_helpers );
#endif

INCLUDE: XS/DataObject.xs
INCLUDE: XS/DropFiles.xs
INCLUDE: XS/Clipboard.xs
INCLUDE: XS/DropSource.xs
INCLUDE: XS/DropTarget.xs

#  //FIXME//tricky
#if __WXMSW__
#undef XS
#define XS( name ) __declspec(dllexport) void name( pTHXo_ CV* cv )
#endif

MODULE=Wx__DND
