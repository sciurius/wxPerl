/////////////////////////////////////////////////////////////////////////////
// Name:        controls.cpp
// Purpose:     implementation for controls.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxEvtHandler:public wxEvtHandler
{
    _DECLARE_DYNAMIC_CLASS( _wxEvtHandler );
    _DECLARE_SELFREF();
public:
    _wxEvtHandler( const char* package );
};

inline _wxEvtHandler::_wxEvtHandler( const char* package )
    :m_callback( "Wx::EvtHandler" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxEvtHandler, wxEvtHandler );

// Local variables: //
// mode: c++ //
// End: //
