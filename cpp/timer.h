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

class _wxTimer:public wxTimer
{
    _DECLARE_DYNAMIC_CLASS( _wxTimer );
    _DECLARE_V_CBACK();
public:
    _wxTimer( const char* package );
    _wxTimer( const char* package, wxEvtHandler* owner, int id );

    virtual void Notify();
};

inline _wxTimer::_wxTimer( const char* package )
    :m_callback( "Wx::Timer" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
}

inline _wxTimer::_wxTimer( const char* package, wxEvtHandler* owner, int id )
    :wxTimer( owner, id ),
     m_callback( "Wx::Timer" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
}

void _wxTimer::Notify()
{
    if( m_callback.FindCallback( "Notify" ) )
    {
        m_callback.CallCallback( G_SCALAR|G_DISCARD );
        return;
    }
    else
        wxTimer::Notify();
}

_IMPLEMENT_DYNAMIC_CLASS( _wxTimer, wxTimer );

// Local variables: //
// mode: c++ //
// End: //
