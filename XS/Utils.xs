#############################################################################
## Name:        Utils.xs
## Purpose:     XS for some utility classes
## Author:      Mattia Barbon
## Modified by:
## Created:      9/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/busyinfo.h>
#include <wx/settings.h>
#include <wx/caret.h>
#include <wx/utils.h>

MODULE=Wx PACKAGE=Wx::CaretSuspend

#if WXPERL_W_VERSION_GE( 2, 3 ) || defined( __WXPERL_FORCE__ )

Wx_CaretSuspend*
Wx_CaretSuspend::new( window )
    Wx_Window* window

void
Wx_CaretSuspend::DESTROY()

#endif

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

MODULE=Wx PACKAGE=Wx PREFIX=wx

bool
wxYield()

bool
wxSafeYield( window = 0 )
    Wx_Window* window

bool
wxYieldIfNeeded()

