/////////////////////////////////////////////////////////////////////////////
// Name:        sashwindow.h
// Purpose:     c++ wrapper for wxSashWindow
// Author:      Mattia Barbon
// Modified by:
// Created:      3/ 2/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxSashWindow:public wxSashWindow
{
    _DECLARE_DYNAMIC_CLASS( _wxSashWindow );
    _DECLARE_SELFREF();
public:
    _wxSashWindow( const char* package, wxWindow* parent, wxWindowID id,
                   const wxPoint& pos, const wxSize& size,
                   long style, const wxString& name );
};

inline _wxSashWindow::_wxSashWindow( const char* package, wxWindow* parent,
                                     wxWindowID id, const wxPoint& pos,
                                     const wxSize& size, long style,
                                     const wxString& name )
    :m_callback( "Wx::SashWindow" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxSashWindow, wxSashWindow );

// Local variables: //
// mode: c++ //
// End: //
