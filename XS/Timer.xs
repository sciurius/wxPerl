#############################################################################
## Name:        Timer.xs
## Purpose:     XS for Wx::Timer
## Author:      Mattia Barbon
## Modified by:
## Created:     14/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
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
    const char* CLASS = _get_class( Class );
  CODE:
    RETVAL = new _wxTimer( CLASS );
  OUTPUT:
    RETVAL

Wx_Timer*
newEH( Class, owner, id = -1 )
    SV* Class
    Wx_EvtHandler* owner
    int id
  PREINIT:
    const char* CLASS = _get_class( Class );
  CODE:
    RETVAL = new _wxTimer( CLASS, owner, id );
  OUTPUT:
    RETVAL

#void
#Wx_Timer::DESTROY()

void
Wx_Timer::Destroy()
  CODE:
    delete THIS;

int
Wx_Timer::GetInterval()

bool
Wx_Timer::IsOneShot()

bool
Wx_Timer::IsRunning()

void
Wx_Timer::SetOwner( owner, id = -1 )
    Wx_EvtHandler* owner
    int id

bool
Wx_Timer::Start( milliseconds = -1, oneshot = FALSE )
    int milliseconds
    bool oneshot

void
Wx_Timer::Stop()

