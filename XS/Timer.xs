#############################################################################
## Name:        XS/Timer.xs
## Purpose:     XS for Wx::Timer
## Author:      Mattia Barbon
## Modified by:
## Created:     14/02/2001
## RCS-ID:      $Id: Timer.xs,v 1.8 2004/01/18 08:12:48 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/timer.h>
#include "cpp/timer.h"

MODULE=Wx PACKAGE=Wx::TimerEvent

int
Wx_TimerEvent::GetInterval()

MODULE=Wx PACKAGE=Wx::Timer

Wx_Timer*
newDefault( Class )
    SV* Class
  PREINIT:
    const char* CLASS = wxPli_get_class( aTHX_ Class );
  CODE:
    RETVAL = new wxPliTimer( CLASS );
  OUTPUT:
    RETVAL

Wx_Timer*
newEH( Class, owner, id = -1 )
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
Wx_Timer::Destroy()
  CODE:
    delete THIS;

int
Wx_Timer::GetInterval()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

int
wxTimer::GetId()

#endif

bool
Wx_Timer::IsOneShot()

bool
Wx_Timer::IsRunning()

void
Wx_Timer::SetOwner( owner, id = -1 )
    wxEvtHandler* owner
    int id

bool
Wx_Timer::Start( milliseconds = -1, oneshot = FALSE )
    int milliseconds
    bool oneshot

void
Wx_Timer::Stop()

