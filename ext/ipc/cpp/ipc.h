/////////////////////////////////////////////////////////////////////////////
// Name:        ext/ipc/cpp/ipc.h
// Purpose:     c++ wrapper for wxIPC
// Author:      Mark Dootson
// Modified by:
// Created:     2013-04-12
// RCS-ID:      $Id: window.h 2057 2007-06-18 23:03:00Z mbarbon $
// Copyright:   (c) 2013 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/v_cback.h"
#include <wx/ipc.h>

// This C++ part is written longhand rather than in XS/IPC.xsp
// because Wx::XSP::Virtual cannot currently auto-create a
// Perlish wrapper for methods with *buffer, *buffsize
// type params.

class wxPlConnection : public wxConnection
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlConnection ); 
    WXPLI_DECLARE_V_CBACK();
public:
    SV* GetSelf()
    {
        return m_callback.GetSelf();
    }

/*******************************************************
 * Constructors
 *******************************************************/

    wxPlConnection( const char* CLASS   )
        : wxConnection(  ),
          m_callback( "Wx::Connection" )
    {
        m_callback.SetSelf( wxPli_make_object( this, CLASS ), true );
    }
    
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    wxPlConnection( const char* CLASS , void* buffer, size_t size )
#else
    wxPlConnection( const char* CLASS , wxChar* buffer, int size )
#endif
        : wxConnection( buffer, size ),
          m_callback( "Wx::Connection" )
    {
        m_callback.SetSelf( wxPli_make_object( this, CLASS ), true );
    }
    
/*******************************************************
 * Destructor
 *******************************************************/
    
    ~wxPlConnection()
    {
        dTHX;
        // only delete this object once
        wxPli_object_set_deleteable( aTHX_ m_callback.GetSelf() , false );
    }

/*******************************************************
 * OnStartAdvise
 *******************************************************/

    bool OnStartAdvise( const wxString& topic, const wxString& item)
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnStartAdvise" ) )
        {
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,
                                             "PP",  &topic, &item ) );
            return SvTRUE( ret );
        }
        else
            return wxConnection::OnStartAdvise(topic, item);
    }

    bool base_OnStartAdvise( const wxString& topic, const wxString& item)
    {
        return wxConnection::OnStartAdvise(topic, item);
    }

/*******************************************************
 * OnStopAdvise
 *******************************************************/    

    bool OnStopAdvise( const wxString& topic, const wxString& item)
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnStopAdvise" ) )
        {
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,
                                             "PP",  &topic, &item ) );
            return SvTRUE( ret );
        }
        else
            return wxConnection::OnStopAdvise(topic, item);
    }

    bool base_OnStopAdvise( const wxString& topic, const wxString& item)
    {
        return wxConnection::OnStopAdvise(topic, item);
    }

/*******************************************************
 * OnDisconnect
 *******************************************************/

    bool OnDisconnect( )
    {
        dTHX;
        
        // we do not delete the object when the other side of the
        // connection disconnects us
        
        wxPli_object_set_deleteable( aTHX_ m_callback.GetSelf() , false );
        
        if( wxPliFCback( aTHX_ &m_callback, "OnDisconnect" ) )
        {
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,
                                             NULL  ) );
            return SvTRUE( ret );
        }
        else
            return wxConnection::OnDisconnect();
    }

    bool base_OnDisconnect( )
    {
        return wxConnection::OnDisconnect();
    }


/*******************************************************
 * OnExecute
 *******************************************************/


#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    bool OnExecute( const wxString& topic, const void *data, size_t buffsize, wxIPCFormat format )
#else
    bool OnExecute( const wxString& topic, wxChar *data, int buffsize, wxIPCFormat format )
#endif
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnExecute" ) )
        {
#if WXPERL_W_VERSION_GE( 2, 9, 0 ) && !defined(__WXMSW__)                
            wxString* buff = new wxString((char*)data, (size_t)buffsize);
#else
            wxString* buff = new wxString((wxChar*)data, (size_t)buffsize);
#endif
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR, "PPi", &topic, buff, format ));
            delete( buff );
            return SvTRUE( ret );
        }
        else
            return wxConnection::OnExecute(topic, data, buffsize, format);
    }

#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    bool base_OnExecute( const wxString& topic, const void *data, size_t size, wxIPCFormat format )
#else
    bool base_OnExecute( const wxString& topic, wxChar *data, int size, wxIPCFormat format )
#endif
    {
        return wxConnection::OnExecute(topic, data, size, format);
    }

/*******************************************************
 * OnExec
 *******************************************************/
    
#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    bool OnExec( const wxString& topic, const wxString& data )
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnExec" ) )
        {
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR, "PP", &topic, &data ));
            
            return SvTRUE( ret );
        }
        else
            return wxConnection::OnExec(topic, data);
    }

    bool base_OnExec( const wxString& topic, const wxString& data )
    {
        return wxConnection::OnExec(topic, data);
    }
    
#endif
    
/*******************************************************
 * OnRequest
 *******************************************************/
#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    virtual const void *OnRequest(const wxString& topic, const wxString& item, size_t *size, wxIPCFormat format)
#else
    virtual wxChar *OnRequest( const wxString& topic, const wxString& item, int *size, wxIPCFormat format )
#endif
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnRequest" ) )
        {
            
            SV* ret = wxPliCCback( aTHX_ &m_callback, G_SCALAR, "PPi", &topic, &item, format );
            *size = SvLEN(ret);
            wxChar* buf = (wxChar*)SvPV_force(ret, SvLEN(ret));
            sv_2mortal( ret );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )              
            return (void*)buf;
#else
            return (wxChar*)buf;
#endif
        }
        else
            return wxConnection::OnRequest(topic, item, size, format);
    }

#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    virtual const void *base_OnRequest(const wxString& topic, const wxString& item, size_t *size, wxIPCFormat format)
#else
    virtual wxChar *base_OnRequest( const wxString& topic, const wxString& item, int *size, wxIPCFormat format )
#endif
    {
        return wxConnection::OnRequest(topic,item,size,format);
    }


/*******************************************************
 * OnPoke
 *******************************************************/

#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    bool OnPoke( const wxString& topic, const wxString& item, const void *data, size_t buffsize, wxIPCFormat format )
#else
    bool OnPoke( const wxString& topic, const wxString& item,  wxChar *data, int buffsize, wxIPCFormat format )
#endif
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnPoke" ) )
        {
            SV* buff = newSVpvn((char*)data, (size_t)buffsize);
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR, "PPsi", &topic, &item, buff, format ));
            SvREFCNT_dec( buff );
            return SvTRUE( ret );
        }
        else
            return wxConnection::OnPoke(topic, item, data, buffsize, format);
    }

#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    bool base_OnPoke( const wxString& topic, const wxString& item, const void *data, size_t size, wxIPCFormat format )
#else
    bool base_OnPoke( const wxString& topic, const wxString& item, wxChar *data, int size, wxIPCFormat format )
#endif
    {
        return wxConnection::OnPoke(topic, item, data, size, format);
    }

/*******************************************************
 * OnAdvise
 *******************************************************/

#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    bool OnAdvise( const wxString& topic, const wxString& item, const void *data, size_t buffsize, wxIPCFormat format )
#else
    bool OnAdvise( const wxString& topic, const wxString& item,  wxChar *data, int buffsize, wxIPCFormat format )
#endif
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnAdvise" ) )
        {
            SV* buff = newSVpvn((char*)data, (size_t)buffsize);          
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR, "PPsi", &topic, &item, buff, format ));
            SvREFCNT_dec( buff );
            return SvTRUE( ret );
        }
        else
            return wxConnection::OnAdvise(topic, item, data, buffsize, format);
    }

#if WXPERL_W_VERSION_GE( 2, 9, 0 )    
    bool base_OnAdvise( const wxString& topic, const wxString& item, const void *data, size_t size, wxIPCFormat format )
#else
    bool base_OnAdvise( const wxString& topic, const wxString& item, wxChar *data, int size, wxIPCFormat format )
#endif
    {
        return wxConnection::OnAdvise(topic, item, data, size, format);
    }  
    
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlConnection, wxConnection );


class wxPlServer : public wxServer
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlServer ); 
    WXPLI_DECLARE_V_CBACK();
public:
    SV* GetSelf()
    {
        return m_callback.GetSelf();
    }

/*******************************************************
 * Constructor
 *******************************************************/

    wxPlServer( const char* CLASS   )
        : wxServer(  ),
          m_callback( "Wx::Server" )
    {
        m_callback.SetSelf( wxPli_make_object( this, CLASS ), true );
    }

/*******************************************************
 * OnAcceptConnection
 *******************************************************/    

    wxConnectionBase *OnAcceptConnection(const wxString& topic)
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnAcceptConnection" ) )
        {
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,
                                             "P",  &topic ) );
            
            return (wxConnectionBase*)wxPli_sv_2_object( aTHX_ ret, "Wx::Connection" );
        }
        else
            return wxServer::OnAcceptConnection(topic);
    }

    wxConnectionBase *base_OnAcceptConnection(const wxString& topic)
    {
        return wxServer::OnAcceptConnection(topic);
    }

};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlServer, wxServer );


class wxPlClient : public wxClient
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlClient ); 
    WXPLI_DECLARE_V_CBACK();
public:
    SV* GetSelf()
    {
        return m_callback.GetSelf();
    }

/*******************************************************
 * Constructor
 *******************************************************/

    wxPlClient( const char* CLASS   )
        : wxClient(  ),
          m_callback( "Wx::Client" )
    {
        m_callback.SetSelf( wxPli_make_object( this, CLASS ), true );
    }

/*******************************************************
 * OnMakeConnection
 *******************************************************/    

    wxConnectionBase *OnMakeConnection()
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "OnMakeConnection" ) )
        {
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR, NULL ) );
            
            return (wxConnectionBase*)wxPli_sv_2_object( aTHX_ ret, "Wx::Connection" );
        }
        else
            return wxClient::OnMakeConnection();
    }

    wxConnectionBase *base_OnMakeConnection()
    {
        return wxClient::OnMakeConnection();
    }


};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlClient, wxClient );


// local variables:
// mode: c++
// end:
