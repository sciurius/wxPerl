/////////////////////////////////////////////////////////////////////////////
// Name:        Frames.xs
// Purpose:     XS for Wx::Frame, Wx::Dialog, Wx::Panel
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>

#include <wx/window.h>
#include <wx/frame.h>
#include <wx/panel.h>
#include <wx/dialog.h>
#include <wx/button.h>
#include <wx/toolbar.h>
#include <wx/tbarsmpl.h>
#include <wx/statusbr.h>
#include <wx/minifram.h>
#include <wx/menu.h>

#include <wx/colordlg.h>
#include <wx/filedlg.h>
#include <wx/dirdlg.h>
#include <wx/choicdlg.h>
#include <wx/textdlg.h>
#include <wx/msgdlg.h>
#include <wx/progdlg.h>

#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#include "cpp/compat.h"
#include "cpp/typedef.h"
#include "cpp/helpers.h"

#include "cpp/v_cback.h"

#include "cpp/panel.h"
#include "cpp/dialog.h"
#include "cpp/frame.h"

#include "cpp/singlechoicedialog.h"

#undef THIS

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

MODULE=Wx_Wnd
