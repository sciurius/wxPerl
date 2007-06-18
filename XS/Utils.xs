#############################################################################
## Name:        XS/Utils.xs
## Purpose:     XS for some utility classes
## Author:      Mattia Barbon
## Modified by:
## Created:     09/02/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2003, 2005-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/busyinfo.h>
#include <wx/settings.h>
#include <wx/caret.h>
#include <wx/snglinst.h>
#include <wx/splash.h>
#include <wx/utils.h>
#include <wx/debug.h>
#include <wx/tipdlg.h>
#if WXPERL_W_VERSION_GE( 2, 8, 0 )
#include <wx/sysopt.h>
#endif
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
#ifdef __WXGTK20__
#define __WXGTK20__DEFINED
#undef __WXGTK20__
#endif
#include <wx/stockitem.h>
#ifdef __WXGTK20__DEFINED
#define __WXGTK20__
#endif
#endif
#include "cpp/tipprovider.h"

MODULE=Wx PACKAGE=Wx::CaretSuspend

wxCaretSuspend*
wxCaretSuspend::new( window )
    wxWindow* window

static void
wxCaretSuspend::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxCaretSuspend::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::CaretSuspend", THIS, ST(0) );
    delete THIS;

MODULE=Wx PACKAGE=Wx::SplashScreen

#ifndef wxFRAME_FLOAT_ON_PARENT
#define wxFRAME_FLOAT_ON_PARENT 0
#endif

#ifndef wxFRAME_TOOL_WINDOW
#define wxFRAME_TOOL_WINDOW 0
#endif

wxSplashScreen*
wxSplashScreen::new( bitmap, splashStyle, milliseconds, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSIMPLE_BORDER|wxFRAME_NO_TASKBAR|wxSTAY_ON_TOP )
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

static void
wxWindowDisabler::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxWindowDisabler::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::WindowDisabler", THIS, ST(0) );
    delete THIS;

MODULE=Wx PACKAGE=Wx::BusyCursor

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

wxBusyCursor*
wxBusyCursor::new( cursor = wxHOURGLASS_CURSOR )
    const wxCursor* cursor

#else

wxBusyCursor*
wxBusyCursor::new( cursor = wxHOURGLASS_CURSOR )
    wxCursor* cursor

#endif

static void
wxBusyCursor::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxBusyCursor::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::BusyCursor", THIS, ST(0) );
    delete THIS;

MODULE=Wx PACKAGE=Wx::BusyInfo

wxBusyInfo*
wxBusyInfo::new( message )
    wxString message

static void
wxBusyInfo::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxBusyInfo::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::BusyInfo", THIS, ST(0) );
    delete THIS;

MODULE=Wx PACKAGE=Wx::StopWatch

#ifdef Pause
#undef Pause
#endif

wxStopWatch*
wxStopWatch::new()

static void
wxStopWatch::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxStopWatch::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::StopWatch", THIS, ST(0) );
    delete THIS;

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

static void
wxSingleInstanceChecker::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxSingleInstanceChecker::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::SingleInstanceChecker", THIS, ST(0) );
    delete THIS;

bool
wxSingleInstanceChecker::Create( name, path = wxEmptyString )
    wxString name
    wxString path

bool
wxSingleInstanceChecker::IsAnotherRunning()

#endif

#if WXPERL_W_VERSION_GE( 2, 8, 0 )

MODULE=Wx PACKAGE=Wx::SystemOptions

#define wxSystemOptions_SetOption wxSystemOptions::SetOption
#define wxSystemOptions_GetOption wxSystemOptions::GetOption
#define wxSystemOptions_GetOptionInt wxSystemOptions::GetOptionInt
#define wxSystemOptions_HasOption wxSystemOptions::HasOption
#define wxSystemOptions_IsFalse wxSystemOptions::IsFalse

void
SetOption( name, value )
    wxString name
    wxString value
  CODE:
    wxSystemOptions_SetOption( name, value);
    
void
SetOptionInt( name, value )
    wxString name
    int value
  CODE:
    wxSystemOptions_SetOption( name, value);
    
wxString
GetOption( name )
    wxString name
  CODE:
    RETVAL = wxSystemOptions_GetOption( name );
  OUTPUT: RETVAL
    
int
GetOptionInt( name )
    wxString name
  CODE:
    RETVAL = wxSystemOptions_GetOptionInt( name );
  OUTPUT: RETVAL    

bool
HasOption( name )
    wxString name
  CODE:
    RETVAL = wxSystemOptions_HasOption( name );
  OUTPUT: RETVAL    
    
bool
IsFalse( name )
    wxString name
  CODE:
    RETVAL = wxSystemOptions_IsFalse( name );
  OUTPUT: RETVAL    

#endif

MODULE=Wx PACKAGE=Wx::SystemSettings

#if WXPERL_W_VERSION_GE( 2, 5, 2 )
#define wxSystemSettings_GetSystemColour wxSystemSettings::GetColour
#define wxSystemSettings_GetSystemFont wxSystemSettings::GetFont
#define wxSystemSettings_GetSystemMetric wxSystemSettings::GetMetric
#else
#define wxSystemSettings_GetSystemColour wxSystemSettings::GetSystemColour
#define wxSystemSettings_GetSystemFont wxSystemSettings::GetSystemFont
#define wxSystemSettings_GetSystemMetric wxSystemSettings::GetSystemMetric
#endif

wxColour*
GetSystemColour( index )
    wxSystemColour index
  CODE:
    RETVAL = new wxColour( wxSystemSettings_GetSystemColour( index ) );
  OUTPUT: RETVAL

wxFont*
GetSystemFont( index )
    wxSystemFont index
  CODE:
    RETVAL = new wxFont( wxSystemSettings_GetSystemFont( index ) );
  OUTPUT: RETVAL

int
GetSystemMetric( index )
    wxSystemMetric index
  CODE:
    RETVAL = wxSystemSettings_GetSystemMetric( index );
  OUTPUT: RETVAL

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

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

bool
wxIsStockID( wxWindowID id )

bool
wxIsStockLabel( wxWindowID id, wxString label )

#if WXPERL_W_VERSION_GE( 2, 6, 3 )

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

wxString
wxGetStockLabel( wxWindowID id, long flags = wxSTOCK_WITH_MNEMONIC )

#else

wxString
wxGetStockLabel( wxWindowID id, bool withCodes = true, wxString accelerator = wxEmptyString )

#endif

#else

wxString
wxGetStockLabel( wxWindowID id )

#endif

#endif

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

wxAcceleratorEntry*
wxGetStockAccelerator( wxWindowID id )
  CODE:
    RETVAL = new wxAcceleratorEntry( wxGetStockAccelerator( id ) );
  OUTPUT: RETVAL

wxString
wxGetStockHelpString( wxWindowID id, wxStockHelpStringClient client = wxSTOCK_MENU )

#endif

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

bool
wxLaunchDefaultBrowser( url, flags = 0 )
    wxString url
    int flags

#else
#if WXPERL_W_VERSION_GE( 2, 6, 1 )

bool
wxLaunchDefaultBrowser( url )
    wxString url

#endif
#endif

bool
wxShowTip( parent, tipProvider, showAtStartup = true )
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
  CODE:
#if WXPERL_W_VERSION_LE( 2, 5, 2 )
    wxUsleep( ms );
#else
    wxMilliSleep( ms );
#endif

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxMicroSleep( ms )
    unsigned long ms

#endif

void
wxMilliSleep( ms )
    unsigned long ms
  CODE:
#if WXPERL_W_VERSION_LE( 2, 5, 2 )
    wxUsleep( ms );
#else
    wxMilliSleep( ms );
#endif

void
wxSleep( sec )
    int sec

bool
wxYield()

bool
wxSafeYield( window = 0, onlyIfNeeded = false )
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
wxShell( command = wxEmptyString )
    wxString command

#if WXPERL_W_VERSION_GE( 2, 6, 0 )

bool
wxGetKeyState( key )
    wxKeyCode key

#endif

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
