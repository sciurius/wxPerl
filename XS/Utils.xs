#############################################################################
## Name:        XS/Utils.xs
## Purpose:     XS for some utility classes
## Author:      Mattia Barbon
## Modified by:
## Created:     09/02/2001
## RCS-ID:      $Id: Utils.xs,v 1.31 2004/03/20 17:51:32 mbarbon Exp $
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

wxCaretSuspend*
wxCaretSuspend::new( window )
    wxWindow* window

void
wxCaretSuspend::DESTROY()

MODULE=Wx PACKAGE=Wx::SplashScreen

#ifndef wxFRAME_FLOAT_ON_PARENT
#define wxFRAME_FLOAT_ON_PARENT 0
#endif

#ifndef wxFRAME_TOOL_WINDOW
#define wxFRAME_TOOL_WINDOW 0
#endif

wxSplashScreen*
wxSplashScreen::new( bitmap, splashStyle, milliseconds, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSIMPLE_BORDER|wxFRAME_NO_TASKBAR|wxSTAY_ON_TOP )
    wxBitmap* bitmap
    long splashStyle
    int milliseconds
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
  CODE:
    RETVAL = new wxSplashScreen( *bitmap, splashStyle, milliseconds, parent,
        id, pos, size, style );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::WindowDisabler

wxWindowDisabler*
wxWindowDisabler::new( skip = 0 )
    wxWindow* skip

void
wxWindowDisabler::DESTROY()

MODULE=Wx PACKAGE=Wx::BusyCursor

wxBusyCursor*
wxBusyCursor::new( cursor = wxHOURGLASS_CURSOR )
    wxCursor* cursor

void
wxBusyCursor::DESTROY()

MODULE=Wx PACKAGE=Wx::BusyInfo

wxBusyInfo*
wxBusyInfo::new( message )
    wxString message

void
wxBusyInfo::DESTROY()

MODULE=Wx PACKAGE=Wx::StopWatch

#ifdef Pause
#undef Pause
#endif

wxStopWatch*
wxStopWatch::new()

## XXX threads
void
wxStopWatch::DESTROY()

void
wxStopWatch::Pause()

void
wxStopWatch::Start( milliseconds = 0 )
    long milliseconds

void
wxStopWatch::Resume()

long
wxStopWatch::Time()

MODULE=Wx PACKAGE=Wx::SingleInstanceChecker

#if wxUSE_SNGLINST_CHECKER

wxSingleInstanceChecker*
wxSingleInstanceChecker::new()

## XXX threads
void
wxSingleInstanceChecker::DESTROY()

bool
wxSingleInstanceChecker::Create( name, path = wxEmptyString )
    wxString name
    wxString path

bool
wxSingleInstanceChecker::IsAnotherRunning()

#endif

MODULE=Wx PACKAGE=Wx::SystemSettings

wxColour*
GetSystemColour( index )
    int index
  CODE:
    RETVAL = new wxColour( wxSystemSettings::GetSystemColour( index ) );
  OUTPUT:
    RETVAL

wxFont*
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

wxTipProvider*
wxTipProvider::new( currentTip )
    size_t currentTip
  CODE:
    RETVAL = new wxPliTipProvider( CLASS, currentTip );
  OUTPUT:
    RETVAL

void
wxTipProvider::Destroy()
  CODE:
    delete THIS;

size_t
wxTipProvider::GetCurrentTip()

void
wxTipProvider::SetCurrentTip( number )
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
    wxWindow* parent
    wxTipProvider* tipProvider
    bool showAtStartup

wxTipProvider*
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

wxEventType
wxNewEventType()

void
wxRegisterId( id )
    long id

void
wxBell()

void
wxExit()

bool
wxShell(command = wxEmptyString)
    wxString command

MODULE=Wx PACKAGE=Wx

void
_utf8_on( sv )
    SV* sv
  CODE:
    SvUTF8_on( sv );

void
_utf8_off( sv )
    SV* sv
  CODE:
    SvUTF8_off( sv );
