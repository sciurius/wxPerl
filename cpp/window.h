/////////////////////////////////////////////////////////////////////////////
// Name:        window.h
// Purpose:     c++ wrapper for wxWindow
// Author:      Mattia Barbon
// Modified by:
// Created:      3/11/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxWindow:public wxWindow
{
    _DECLARE_DYNAMIC_CLASS( _wxWindow );
    _DECLARE_SELFREF();
public:
    _wxWindow( const char* package, wxWindow* parent, wxWindowID id,
               const wxPoint& pos, const wxSize& size, long style,
               const wxString& name );
};

inline _wxWindow::_wxWindow( const char* package, wxWindow* parent,
                             wxWindowID id,
                             const wxPoint& pos, const wxSize& size,
                             long style,
                             const wxString& name )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxWindow, wxWindow );

// Local variables: //
// mode: c++ //
// End: //
