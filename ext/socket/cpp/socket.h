///////////////////////////////////////////////////////////////////////////////
// Name:        socket.h
// Purpose:     c++ wrapper for wxSocket*
// Author:      Graciliano M. P.
// Modified by:
// Created:     06/03/2003
// RCS-ID:      
// Copyright:   (c) 2003 Graciliano M. P.
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
///////////////////////////////////////////////////////////////////////////////

#include "wx/socket.h"
#include "cpp/v_cback.h"

class wxPlSocketBase:public wxSocketBase
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlSocketBase );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlSocketBase( const char* package );
};

inline wxPlSocketBase::wxPlSocketBase( const char* package )
    : m_callback( "Wx::SocketBase" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlSocketBase , wxSocketBase );

///////////////////////////////////////////////////////////////////////////////

class wxPliSocketClient:public wxSocketClient
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliSocketClient );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliSocketClient, "Wx::SocketClient", TRUE );

    // this fixes the crashes, for some reason
    wxPliSocketClient( const char* package, long _arg1 )
        : wxSocketClient( _arg1 ),
          m_callback( "Wx::SocketClient" )
     {
         m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
     }
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliSocketClient , wxSocketClient );

///////////////////////////////////////////////////////////////////////////////

class wxPlSocketServer:public wxSocketServer
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlSocketServer );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlSocketServer( const char* package , wxIPV4address _arg1 , long _arg2 );

    wxSocketBase* Accept(bool wait)
    {
        wxSocketBase* sock = new wxPlSocketBase( "Wx::SocketBase" );

        sock->SetFlags(GetFlags());

        if (!AcceptWith(*sock, wait))
        {
            sock->Destroy();
            sock = NULL;
        }

        return sock;
    }
};

inline wxPlSocketServer::wxPlSocketServer( const char* package , wxIPV4address _arg1 , long _arg2 )
    : wxSocketServer( _arg1 , _arg2 ),
      m_callback( "Wx::SocketServer" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlSocketServer , wxSocketServer );

///////////////////////////////////////////////////////////////////////////////

#if 0

class wxPliSocketEvent:public wxSocketEvent
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliSocketEvent );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliSocketEvent, "Wx::SocketEvent", TRUE );

    // this fixes the crashes, for some reason
    wxPliSocketEvent( const char* package, int _arg1 )
        : wxSocketEvent( _arg1 ),
          m_callback( "Wx::SocketEvent" )
     {
         m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
     }
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliSocketEvent , wxSocketEvent );

#endif

// Local variables: //
// mode: c++ //
// End: //
