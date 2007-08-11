#############################################################################
## Name:        XS/Timer.xs
## Purpose:     XS for Wx::Timer
## Author:      Mattia Barbon
## Modified by:
## Created:     14/02/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2004, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/timer.h>
#include "cpp/timer.h"

MODULE=Wx PACKAGE=Wx::TimerEvent

int
wxTimerEvent::GetInterval()

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

wxTimer*
wxTimerEvent::GetTimer()
  CODE:
    RETVAL = &THIS->GetTimer();
  OUTPUT: RETVAL

#endif

MODULE=Wx PACKAGE=Wx::Timer

wxTimer*
newDefault( Class )
    SV* Class
  PREINIT:
    const char* CLASS = wxPli_get_class( aTHX_ Class );
  CODE:
    RETVAL = new wxPliTimer( CLASS );
  OUTPUT:
    RETVAL

wxTimer*
newEH( Class, owner, id = wxID_ANY )
    SV* Class
    wxEvtHandler* owner
    int id
  PREINIT:
    const char* CLASS = wxPli_get_class( aTHX_ Class );
  CODE:
    RETVAL = new wxPliTimer( CLASS, owner, id );
  OUTPUT:
    RETVAL

void
wxTimer::Destroy()
  CODE:
    delete THIS;

int
wxTimer::GetInterval()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

int
wxTimer::GetId()

#endif

bool
wxTimer::IsOneShot()

bool
wxTimer::IsRunning()

void
wxTimer::SetOwner( owner, id = -1 )
    wxEvtHandler* owner
    int id

bool
wxTimer::Start( milliseconds = -1, oneshot = false )
    int milliseconds
    bool oneshot

void
wxTimer::Stop()

