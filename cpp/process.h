/////////////////////////////////////////////////////////////////////////////
// Name:        process.h
// Purpose:     C++ wrapper for wxProcess
// Author:      Mattia Barbon
// Modified by:
// Created:     11/ 2/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class wxPliProcess:public wxProcess
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliProcess );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPliProcess( const char* package, wxEvtHandler* parent, int id );

    virtual void OnTerminate( int pid, int status );
};

inline wxPliProcess::wxPliProcess( const char* package,
                                   wxEvtHandler* parent, int id )
    : wxProcess( parent, id ),
      m_callback( "Wx::Process" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

void wxPliProcess::OnTerminate( int pid, int status )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "OnTerminate" ) )
    {
        wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR|G_DISCARD,
                                           "ii", pid, status );
    }
    else
        wxProcess::OnTerminate( pid, status );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliProcess, wxProcess );

// Local variables: //
// mode: c++ //
// End: //
