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
#define PERL_NO_GET_CONTEXT

#include <stddef.h>
#include "cpp/compat.h"
#if !WXPERL_W_VERSION_GE( 2, 3, 0 )
#include <wx/defs.h>
#include <wx/window.h>
#endif

// THIS IS AN HACK!
#if defined(_MSC_VER) && WXPERL_W_VERSION_GE( 2, 3, 2 )
#define STRICT
#endif

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

#include <wx/defs.h>
#include <wx/window.h>
#include <wx/module.h>
#include "cpp/chkconfig.h"

#if defined(__WXMSW__)
#include <wx/msw/private.h>
#endif

#if defined(__WXGTK__) && WXPERL_W_VERSION_GE( 2, 3, 3 )
int  WXDLLEXPORT wxEntryStart( int& argc, char** argv );
#else
int  WXDLLEXPORT wxEntryStart( int argc, char** argv );
#endif
int  WXDLLEXPORT wxEntryInitGui();
void WXDLLEXPORT wxEntryCleanup();

#if __VISUALC__
#pragma warning (disable: 4800)
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#define _WXP_DEFINE_CLASSNAME 1
#include "cpp/typedef.h"
#include "cpp/helpers.h"

#include "cpp/v_cback.h"

#include "cpp/helpers.cpp"
#include "cpp/v_cback.cpp"

#undef THIS

#ifdef __cplusplus
extern "C" {
#endif
    XS( boot_Wx_Const );
    XS( boot_Wx_Ctrl );
    XS( boot_Wx_Evt );
    XS( boot_Wx_Win );
    XS( boot_Wx_Wnd );
    XS( boot_Wx_GDI );
#if defined( WXPL_STATIC )
    XS( boot_Wx__XRC );
    XS( boot_Wx__Print );
    XS( boot_Wx__MDI );
    XS( boot_Wx__Html );
    XS( boot_Wx__Help );
    XS( boot_Wx__Grid );
    XS( boot_Wx__FS );
    XS( boot_Wx__DND );
#endif
#ifdef __cplusplus
}
#endif

extern void SetConstants();

#ifdef __WXMOTIF__

#include <wx/app.h>
#include <wx/log.h>

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

DEFINE_PLI_HELPERS( st_wxPliHelpers );

#include <wx/confbase.h>
typedef wxConfigBase::EntryType EntryType;

WXPLI_BOOT_ONCE_EXP(Wx);
#define boot_Wx wxPli_boot_Wx

MODULE=Wx PACKAGE=Wx

BOOT:
  newXSproto( "Wx::_boot_Constant", boot_Wx_Const, file, "$$" );
  newXSproto( "Wx::_boot_Controls", boot_Wx_Ctrl, file, "$$" );
  newXSproto( "Wx::_boot_Events", boot_Wx_Evt, file, "$$" );
  newXSproto( "Wx::_boot_Window", boot_Wx_Win, file, "$$" );
  newXSproto( "Wx::_boot_Frames", boot_Wx_Wnd, file, "$$" );
  newXSproto( "Wx::_boot_GDI", boot_Wx_GDI, file, "$$" );
#if defined( WXPL_STATIC )
  newXSproto( "Wx::_boot_Wx__XRC", boot_Wx__XRC, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Print", boot_Wx__Print, file, "$$" );
  newXSproto( "Wx::_boot_Wx__MDI", boot_Wx__MDI, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Html", boot_Wx__Html, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Help", boot_Wx__Help, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Grid", boot_Wx__Grid, file, "$$" );
  newXSproto( "Wx::_boot_Wx__FS", boot_Wx__FS, file, "$$" );
  newXSproto( "Wx::_boot_Wx__DND", boot_Wx__DND, file, "$$" );
#endif
  SV* tmp = get_sv( "Wx::_exports", 1 );
  sv_setiv( tmp, (IV)(void*)&st_wxPliHelpers );

void 
Load()
  CODE:
    static bool initialized = false;
    if( initialized ) { XSRETURN_EMPTY; }
    initialized = true;

    // set up version as soon as possible
    SV* tmp = get_sv( "Wx::_wx_version", 0 );
    sv_setnv( tmp, wxMAJOR_VERSION + wxMINOR_VERSION / 1000.0 + 
        wxRELEASE_NUMBER / 1000000.0 );

    if( wxTopLevelWindows.Number() > 0 )
        return;

    char** argv = 0;
    int argc = 0;

    argc = wxPli_get_args_argc_argv( &argv, 0 );
    wxEntryStart( argc, argv );
    wxPli_delete_argv( argv, 0 );

void
SetConstants()
  CODE:
    // this is after wxEntryStart, since
    // wxInitializeStockObjects needs to be called
    // (for colours, cursors, pens, etc...)
    SetConstants();

void
UnLoad()
  CODE:
    wxEntryCleanup();

I32
looks_like_number( sval )
    SV* sval

void
CLONE( CLASS )
    char* CLASS
  CODE:
    SetConstants();

INCLUDE: XS/App.xs
INCLUDE: XS/Caret.xs
INCLUDE: XS/Geom.xs
INCLUDE: XS/Menu.xs
INCLUDE: XS/Log.xs
INCLUDE: XS/ToolTip.xs
INCLUDE: XS/Locale.xs
INCLUDE: XS/Utils.xs
INCLUDE: XS/Timer.xs
INCLUDE: XS/Stream.xs
INCLUDE: XS/TaskBarIcon.xs
INCLUDE: XS/Config.xs
INCLUDE: XS/Process.xs

# this is here for debugging purpouses
INCLUDE: XS/ClassInfo.xs

##  //FIXME// tricky
##if defined(__WXMSW__)
##undef XS
##define XS( name ) WXXS( name )
##endif

MODULE=Wx PACKAGE=Wx
