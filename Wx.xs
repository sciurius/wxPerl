/////////////////////////////////////////////////////////////////////////////
// Name:        Wx.xs
// Purpose:     main XS module
// Author:      Mattia Barbon
// Modified by:
// Created:      1/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>

#include <wx/app.h>
#include <wx/window.h>
#include <wx/menu.h>
#include <wx/icon.h>
#include <wx/caret.h>
#include <wx/timer.h>

#include <wx/button.h>

#include <wx/log.h>
#include <wx/tooltip.h>
#include <wx/intl.h>
#include <wx/module.h>
#include <wx/busyinfo.h>
#include <wx/settings.h>

#if __WXMSW__
#include <wx/msw/private.h>
#endif

#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

int  WXDLLEXPORT wxEntryStart( int argc, char** argv );
int  WXDLLEXPORT wxEntryInitGui();
void WXDLLEXPORT wxEntryCleanup();

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#define _WXP_DEFINE_CLASSNAME 1
#include "cpp/compat.h"
#include "cpp/typedef.h"
#include "cpp/helpers.h"

#include "cpp/v_cback.h"

#include "cpp/helpers.cpp"
#include "cpp/v_cback.cpp"

#include "cpp/app.h"
#include "cpp/button.h"

#undef THIS

#ifdef __cplusplus
extern "C" {
#endif
    XS( boot_Wx_Func );
    XS( boot_Wx_Const );
    XS( boot_Wx_Ctrl );
    XS( boot_Wx_Evt );
    XS( boot_Wx_Win );
    XS( boot_Wx_Wnd );
    XS( boot_Wx_GDI );
#ifdef __cplusplus
}
#endif

extern void SetConstants();

#ifdef __WXMOTIF__

int wxEntryStart( int argc, char** argv )
{
#if (defined(__WXDEBUG__) && wxUSE_MEMORY_TRACING) || wxUSE_DEBUG_CONTEXT
    // This seems to be necessary since there are 'rogue'
    // objects present at this point (perhaps global objects?)
    // Setting a checkpoint will ignore them as far as the
    // memory checking facility is concerned.
    // Of course you may argue that memory allocated in globals should be
    // checked, but this is a reasonable compromise.
    wxDebugContext::SetCheckpoint();
#endif

    if (!wxApp::Initialize())
        return FALSE;
}

int wxEntryInitGui()
{
    int retValue = 0;

    // GUI-specific initialization, such as creating an app context.
    if( !wxTheApp->OnInitGui() )
        retValue = -1;

    return retValue;
}

void wxEntryCleanup()
{
    // flush the logged messages if any
    wxLog *pLog = wxLog::GetActiveTarget();
    if ( pLog != NULL && pLog->HasPendingMessages() )
        pLog->Flush();

    delete wxLog::SetActiveTarget(new wxLogStderr); // So dialog boxes aren't used
    // for further messages

    // some code moved to _wxApp destructor
    // since at this point the app is already destroyed
}

#endif

MODULE=Wx PACKAGE=Wx

BOOT:
  newXSproto( "Wx::_boot_Functions", boot_Wx_Func, file, "$$" );
  newXSproto( "Wx::_boot_Constant", boot_Wx_Const, file, "$$" );
  newXSproto( "Wx::_boot_Controls", boot_Wx_Ctrl, file, "$$" );
  newXSproto( "Wx::_boot_Events", boot_Wx_Evt, file, "$$" );
  newXSproto( "Wx::_boot_Window", boot_Wx_Win, file, "$$" );
  newXSproto( "Wx::_boot_Frames", boot_Wx_Wnd, file, "$$" );
  newXSproto( "Wx::_boot_GDI", boot_Wx_GDI, file, "$$" );

#if __WXMSW__

void
_SetInstance( instance )
    int instance
  CODE:
    wxSetInstance( (HINSTANCE)instance );

#else

void
_SetInstance( instance )
    int instance
  CODE:
    instance = instance;

#endif

void 
Load()
  CODE:
    if( wxTopLevelWindows.Number() > 0 )
      return;

    char** argv;
    int argc;

    argc = _get_args_argc_argv( &argv );
    wxEntryStart( argc, argv );
    delete[] argv;
    // this is after wxEntryStart, since
    // wxInitializeStockObjects needs to be called
    // (for colours, cursors, pens, etc...)
    SetConstants();
  

void
UnLoad()
  CODE:
    wxEntryCleanup();

INCLUDE: XS/App.xs
INCLUDE: XS/Caret.xs
INCLUDE: XS/Geom.xs
INCLUDE: XS/Menu.xs
INCLUDE: XS/Log.xs
INCLUDE: XS/ToolTip.xs
INCLUDE: XS/Locale.xs
INCLUDE: XS/Utils.xs

# this is here for debugging purpouses
INCLUDE: XS/ClassInfo.xs

MODULE=Wx PACKAGE=Wx
