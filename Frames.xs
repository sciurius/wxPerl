/////////////////////////////////////////////////////////////////////////////
// Name:        Frames.xs
// Purpose:     XS for Wx::Frame, Wx::Dialog, Wx::Panel
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000-2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool
#define PERL_NO_GET_CONTEXT

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
#undef New
#undef Pause
#if defined( __WXMSW__ )
#undef read
#undef write
#undef eof
#undef form
#undef vform
#endif

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#include "cpp/typedef.h"
#include "cpp/helpers.h"

#include "cpp/v_cback.h"

#undef THIS

WXPLI_BOOT_ONCE(Wx_Wnd);
#define boot_Wx_Wnd wxPli_boot_Wx_Wnd

MODULE=Wx_Wnd

INCLUDE: XS/Panel.xs
INCLUDE: XS/Dialog.xs
INCLUDE: XS/Frame.xs
INCLUDE: XS/StatusBar.xs
INCLUDE: XS/ToolBar.xs

INCLUDE: XS/ColourDialog.xs
INCLUDE: XS/DirDialog.xs
INCLUDE: XS/FileDialog.xs
INCLUDE: XS/TextEntryDialog.xs
INCLUDE: XS/MessageDialog.xs
INCLUDE: XS/ProgressDialog.xs
INCLUDE: XS/SingleChoiceDialog.xs
INCLUDE: XS/MultiChoiceDialog.xs
INCLUDE: XS/FontDialog.xs
INCLUDE: XS/FindReplaceDialog.xs

MODULE=Wx_Wnd
