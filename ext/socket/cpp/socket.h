///////////////////////////////////////////////////////////////////////////////
// Name:        ext/socket/cpp/socket.h
// Purpose:     c++ wrapper for wxSocket*
// Author:      Graciliano M. P.
// Modified by:
// Created:     06/03/2003
// RCS-ID:      $Id$
// Copyright:   (c) 2003-2004 Graciliano M. P.
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
///////////////////////////////////////////////////////////////////////////////

#include "wx/socket.h"
#include "cpp/v_cback.h"

#define DO_WRITE(CODE, sv, size)                                             \
    if ( size == 0 ) size = SvCUR(sv) ;                                      \
    char* buffer = SvPV_nolen(sv);                                           \
    CODE ;                                                                   \
    RETVAL = THIS->LastCount() ;

#define DO_READ(CODE, sv, size, offset)                                      \
    /* Upgrade the SV to scalar if needed. If the scalar is undef */         \
    /* can't use SvGROW. */                                                  \
    SvUPGRADE(sv , SVt_PV) ;                                                 \
    /* Tell that the scalar is string only (not integer, float, utf8...): */ \
    SvPOK_only(sv) ;                                                         \
    /* Grow the scalar to receive the data and return a char* point: */      \
    char* buffer = SvGROW( sv , offset + size + 2 ) ;                        \
    /* To read at the offset the user specified */                           \
    if ( offset > 0 ) buffer += offset ;                                     \
                                                                             \
    CODE ;                                                                   \
    int nread = THIS->LastCount() ;                                          \
                                                                             \
    /* Null-terminate the buffer, not necessary, but does not hurt: */       \
    buffer[nread] = 0 ;                                                      \
    /* Tell Perl how long the string is: */                                  \
    SvCUR_set( sv , offset + nread ) ;                                       \
    /* Undef on read error: */                                               \
    if( THIS->Error() ) XSRETURN_UNDEF ;                                     \
    /* Return the amount of data read, like Perl read(). */                  \
    RETVAL = nread ;

class wxPlSocketBase:public wxSocketBase
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlSocketBase );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlSocketBase( const char* package )
        : m_callback( "Wx::SocketBase" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlSocketBase , wxSocketBase );

///////////////////////////////////////////////////////////////////////////////

class wxPliSocketClient:public wxSocketClient
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliSocketClient );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliSocketClient, "Wx::SocketClient", true );

    // this fixes the crashes, for some reason
    wxPliSocketClient( const char* package, long _arg1 )
        : wxSocketClient( _arg1 ),
          m_callback( "Wx::SocketClient" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliSocketClient , wxSocketClient );

///////////////////////////////////////////////////////////////////////////////

class wxPlSocketServer:public wxSocketServer
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlSocketServer );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlSocketServer( const char* package , wxIPV4address _arg1 , long _arg2 )
        : wxSocketServer( _arg1 , _arg2 ),
          m_callback( "Wx::SocketServer" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

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

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlSocketServer , wxSocketServer );

///////////////////////////////////////////////////////////////////////////////

class wxPliDatagramSocket : public wxDatagramSocket
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliDatagramSocket );
    WXPLI_DECLARE_V_CBACK();
public:
//    WXPLI_DEFAULT_CONSTRUCTOR( wxPliDatagramSocket,
//                               "Wx::DatagramSocket", true );

    // this fixes the crashes, for some reason
    wxPliDatagramSocket( const char* package, wxSockAddress& _arg1,
                         wxSocketFlags _arg2 )
        : wxDatagramSocket( _arg1, _arg2 ),
          m_callback( "Wx::SocketClient" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliDatagramSocket , wxDatagramSocket );

// local variables:
// mode: c++
// end:
