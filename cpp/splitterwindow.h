/////////////////////////////////////////////////////////////////////////////
// Name:        splitterwindow.h
// Purpose:     c++ wrapper for wxSplitterWindow
// Author:      Mattia Barbon
// Modified by:
// Created:      2/12/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxSplitterWindow:public wxSplitterWindow
{
    _DECLARE_DYNAMIC_CLASS( _wxSplitterWindow );
    _DECLARE_SELFREF();
public:
    _wxSplitterWindow( const char* package, wxWindow* parent, wxWindowID id,
                       const wxPoint& pos, const wxSize& size, long style,
                       const wxString& name );
};

_wxSplitterWindow::_wxSplitterWindow( const char* package, wxWindow* parent, 
                                      wxWindowID id,
                                      const wxPoint& pos, const wxSize& size, 
                                      long style,
                                      const wxString& name )
  :m_callback( "Wx::SplitterWindow" )
{
  m_callback.SetSelf( _make_object( this, package ), FALSE );
  Create( parent, id, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxSplitterWindow, wxSplitterWindow );

// Local variables: //
// mode: c++ //
// End: //
