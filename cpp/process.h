/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/process.h
// Purpose:     C++ wrapper for wxProcess
// Author:      Mattia Barbon
// Modified by:
// Created:     11/02/2002
// RCS-ID:      $Id: process.h,v 1.4 2004/12/21 21:12:45 mbarbon Exp $
// Copyright:   (c) 2002, 2004 Mattia Barbon
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
    m_callback.SetSelf( wxPli_make_object( this, package ), true );
}

void wxPliProcess::OnTerminate( int pid, int status )
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "OnTerminate" ) )
    {
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                           G_SCALAR|G_DISCARD,
                                           "ii", pid, status );
    }
    else
        wxProcess::OnTerminate( pid, status );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliProcess, wxProcess );

// Local variables: //
// mode: c++ //
// End: //
