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

#include <wx/button.h>

#include <wx/log.h>
#include <wx/tooltip.h>
#include <wx/intl.h>

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
#include "cpp/typedef.h"
#include "cpp/compat.h"
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

MODULE=Wx PACKAGE=Wx

BOOT:
  newXSproto( "Wx::_boot_Functions", boot_Wx_Func, file, "$$" );
  newXSproto( "Wx::_boot_Constant", boot_Wx_Const, file, "$$" );
  newXSproto( "Wx::_boot_Controls", boot_Wx_Ctrl, file, "$$" );
  newXSproto( "Wx::_boot_Events", boot_Wx_Evt, file, "$$" );
  newXSproto( "Wx::_boot_Window", boot_Wx_Win, file, "$$" );
  newXSproto( "Wx::_boot_Frames", boot_Wx_Wnd, file, "$$" );
  newXSproto( "Wx::_boot_GDI", boot_Wx_GDI, file, "$$" );

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
INCLUDE: XS/Geom.xs
INCLUDE: XS/Menu.xs
INCLUDE: XS/Log.xs
INCLUDE: XS/ToolTip.xs
INCLUDE: XS/Locale.xs

# this is here for debugging purpouses
INCLUDE: XS/ClassInfo.xs

MODULE=Wx PACKAGE=Wx
