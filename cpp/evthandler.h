/////////////////////////////////////////////////////////////////////////////
// Name:        controls.cpp
// Purpose:     implementation for controls.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000-2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class wxPliEvtHandler:public wxEvtHandler
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliEvtHandler );
    WXPLI_DECLARE_SELFREF();
public:
    wxPliEvtHandler( const char* package );
};

inline wxPliEvtHandler::wxPliEvtHandler( const char* package )
    :m_callback( "Wx::EvtHandler" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliEvtHandler, wxEvtHandler );

// Local variables: //
// mode: c++ //
// End: //
