#############################################################################
## Name:        Utils.xs
## Purpose:     XS for some utility classes
## Author:      Mattia Barbon
## Modified by:
## Created:      9/ 2/2001
## RCS-ID:      $Id: Utils.xs,v 1.26 2003/06/05 17:29:44 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/busyinfo.h>
#include <wx/settings.h>
#include <wx/caret.h>
#if WXPERL_W_VERSION_GE( 2, 3, 1 )
#include <wx/snglinst.h>
#include <wx/splash.h>
#endif
#include <wx/utils.h>
#include <wx/debug.h>
#include <wx/tipdlg.h>
#include "cpp/tipprovider.h"

MODULE=Wx PACKAGE=Wx::CaretSuspend

Wx_CaretSuspend*
Wx_CaretSuspend::new( window )
    Wx_Window* window

void
Wx_CaretSuspend::DESTROY()

MODULE=Wx PACKAGE=Wx::SplashScreen

#ifndef wxFRAME_FLOAT_ON_PARENT
#define wxFRAME_FLOAT_ON_PARENT 0
#endif

#ifndef wxFRAME_TOOL_WINDOW
#define wxFRAME_TOOL_WINDOW 0
#endif

Wx_SplashScreen*
Wx_SplashScreen::new( bitmap, splashStyle, milliseconds, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSIMPLE_BORDER|wxFRAME_NO_TASKBAR|wxSTAY_ON_TOP )
    Wx_Bitmap* bitmap
    long splashStyle
    int milliseconds
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
  CODE:
    RETVAL = new wxSplashScreen( *bitmap, splashStyle, milliseconds, parent,
        id, pos, size, style );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::WindowDisabler

Wx_WindowDisabler*
Wx_WindowDisabler::new( skip = 0 )
    Wx_Window* skip

void
Wx_WindowDisabler::DESTROY()

MODULE=Wx PACKAGE=Wx::BusyCursor

Wx_BusyCursor*
Wx_BusyCursor::new( cursor = wxHOURGLASS_CURSOR )
    Wx_Cursor* cursor

void
Wx_BusyCursor::DESTROY()

MODULE=Wx PACKAGE=Wx::BusyInfo

Wx_BusyInfo*
Wx_BusyInfo::new( message )
    wxString message

void
Wx_BusyInfo::DESTROY()

MODULE=Wx PACKAGE=Wx::StopWatch

#ifdef Pause
#undef Pause
#endif

Wx_StopWatch*
Wx_StopWatch::new()

## XXX threads
void
Wx_StopWatch::DESTROY()

void
Wx_StopWatch::Pause()

void
Wx_StopWatch::Start( milliseconds = 0 )
    long milliseconds

void
Wx_StopWatch::Resume()

long
Wx_StopWatch::Time()

MODULE=Wx PACKAGE=Wx::SingleInstanceChecker

#if wxUSE_SNGLINST_CHECKER

Wx_SingleInstanceChecker*
Wx_SingleInstanceChecker::new()

## XXX threads
void
Wx_SingleInstanceChecker::DESTROY()

bool
Wx_SingleInstanceChecker::Create( name, path = wxEmptyString )
    wxString name
    wxString path

bool
Wx_SingleInstanceChecker::IsAnotherRunning()

#endif

MODULE=Wx PACKAGE=Wx::SystemSettings

Wx_Colour*
GetSystemColour( index )
    int index
  CODE:
    RETVAL = new wxColour( wxSystemSettings::GetSystemColour( index ) );
  OUTPUT:
    RETVAL

Wx_Font*
GetSystemFont( index )
    int index
  CODE:
    RETVAL = new wxFont( wxSystemSettings::GetSystemFont( index ) );
  OUTPUT:
    RETVAL

int
GetSystemMetric( index )
    int index
  CODE:
    RETVAL = wxSystemSettings::GetSystemMetric( index );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::TipProvider

Wx_TipProvider*
Wx_TipProvider::new( currentTip )
    size_t currentTip
  CODE:
    RETVAL = new wxPliTipProvider( CLASS, currentTip );
  OUTPUT:
    RETVAL

void
Wx_TipProvider::Destroy()
  CODE:
    delete THIS;

size_t
Wx_TipProvider::GetCurrentTip()

void
Wx_TipProvider::SetCurrentTip( number )
    size_t number
  CODE:
    ((wxPliTipProvider*)THIS)->SetCurrentTip( number );

MODULE=Wx PACKAGE=Wx::Thread

#if wxUSE_THREADS

bool
IsMain()
  CODE:
    RETVAL = wxThread::IsMain();
  OUTPUT:
    RETVAL

#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

bool
wxShowTip( parent, tipProvider, showAtStartup = TRUE )
    Wx_Window* parent
    Wx_TipProvider* tipProvider
    bool showAtStartup

Wx_TipProvider*
wxCreateFileTipProvider( filename, currentTip )
    wxString filename
    size_t currentTip

void
wxUsleep( ms )
    unsigned long ms

void
wxSleep( sec )
    int sec

bool
wxYield()

bool
wxSafeYield( window = 0, onlyIfNeeded = FALSE )
    wxWindow* window
    bool onlyIfNeeded

bool
wxYieldIfNeeded()

void
wxTrap()

wxString
wxGetOsDescription()

long
wxNewId()

void
wxRegisterId( id )
    long id

void
wxBell()
