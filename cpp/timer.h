/////////////////////////////////////////////////////////////////////////////
// Name:        timer.h
// Purpose:     C++ wrapper for wxTimer
// Author:      Mattia Barbon
// Modified by:
// Created:     14/ 2/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class wxPliTimer:public wxTimer
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliTimer );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPliTimer( const char* package );
    wxPliTimer( const char* package, wxEvtHandler* owner, int id );

    virtual void Notify();
};

inline wxPliTimer::wxPliTimer( const char* package )
    :m_callback( "Wx::Timer" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

inline wxPliTimer::wxPliTimer( const char* package, wxEvtHandler* owner,
                               int id )
    :wxTimer( owner, id ),
     m_callback( "Wx::Timer" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

void wxPliTimer::Notify()
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "Notify" ) )
    {
        wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR|G_DISCARD );
        return;
    }
    else
        wxTimer::Notify();
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliTimer, wxTimer );

// Local variables: //
// mode: c++ //
// End: //
