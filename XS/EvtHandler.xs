#############################################################################
## Name:        EvtHandler.xs
## Purpose:     XS for Wx::EvtHandler
## Author:      Mattia Barbon
## Modified by:
## Created:     26/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::EvtHandler

Wx_EvtHandler*
Wx_EvtHandler::new()
  CODE:
    RETVAL = new wxPliEvtHandler( CLASS );
  OUTPUT:
    RETVAL

void
Wx_EvtHandler::AddPendingEvent( event )
    Wx_Event* event
  CODE:
    THIS->AddPendingEvent( *event );

void
Wx_EvtHandler::Connect( id, lastid, type, method )
    wxWindowID id
    int lastid
    wxEventType type
    SV* method
  CODE:
    THIS->Connect(id, lastid, type,
                    (wxObjectEventFunction)&wxPliEventCallback::Handler,
                    new wxPliEventCallback( method, ST(0) ) );

void
Wx_EvtHandler::Destroy()
  CODE:
    delete THIS;

bool
Wx_EvtHandler::Disconnect( id, lastid, type )
    wxWindowID id
    int lastid
    wxEventType type
  CODE:
    RETVAL = THIS->Disconnect( id, lastid, type,
        (wxObjectEventFunction)&wxPliEventCallback::Handler );
  OUTPUT:
    RETVAL

bool
Wx_EvtHandler::GetEvtHandlerEnabled()

Wx_EvtHandler*
Wx_EvtHandler::GetNextHandler()

Wx_EvtHandler*
Wx_EvtHandler::GetPreviousHandler()

bool
Wx_EvtHandler::ProcessEvent( event )
    Wx_Event* event
  CODE:
    RETVAL = THIS->ProcessEvent( *event );
  OUTPUT:
    RETVAL

void
Wx_EvtHandler::SetEvtHandlerEnabled( enabled )
    bool enabled

void
Wx_EvtHandler::SetNextHandler( handler )
    Wx_EvtHandler* handler

void
Wx_EvtHandler::SetPreviousHandler( handler )
    Wx_EvtHandler* handler
