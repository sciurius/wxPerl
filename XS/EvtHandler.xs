#############################################################################
## Name:        XS/EvtHandler.xs
## Purpose:     XS for Wx::EvtHandler
## Author:      Mattia Barbon
## Modified by:
## Created:     26/11/2000
## RCS-ID:      $Id: EvtHandler.xs,v 1.6 2004/10/19 20:28:05 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::EvtHandler

wxEvtHandler*
wxEvtHandler::new()
  CODE:
    RETVAL = new wxEvtHandler();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

void
wxEvtHandler::AddPendingEvent( event )
    wxEvent* event
  CODE:
    THIS->AddPendingEvent( *event );

void
wxEvtHandler::Connect( id, lastid, type, method )
    wxWindowID id
    int lastid
    wxEventType type
    SV* method
  CODE:
    if( SvOK( method ) )
    {
        THIS->Connect( id, lastid, type,
                       (wxObjectEventFunction)&wxPliEventCallback::Handler,
                       new wxPliEventCallback( method, ST(0) ) );
    }
    else
    {
        THIS->Disconnect( id, lastid, type,
                          (wxObjectEventFunction)&wxPliEventCallback::Handler,
                          0 );
    }

void
wxEvtHandler::Destroy()
  CODE:
    delete THIS;

bool
wxEvtHandler::Disconnect( id, lastid, type )
    wxWindowID id
    int lastid
    wxEventType type
  CODE:
    RETVAL = THIS->Disconnect( id, lastid, type,
        (wxObjectEventFunction)&wxPliEventCallback::Handler );
  OUTPUT:
    RETVAL

bool
wxEvtHandler::GetEvtHandlerEnabled()

wxEvtHandler*
wxEvtHandler::GetNextHandler()

wxEvtHandler*
wxEvtHandler::GetPreviousHandler()

bool
wxEvtHandler::ProcessEvent( event )
    wxEvent* event
  CODE:
    RETVAL = THIS->ProcessEvent( *event );
  OUTPUT:
    RETVAL

void
wxEvtHandler::SetEvtHandlerEnabled( enabled )
    bool enabled

void
wxEvtHandler::SetNextHandler( handler )
    wxEvtHandler* handler

void
wxEvtHandler::SetPreviousHandler( handler )
    wxEvtHandler* handler
