/////////////////////////////////////////////////////////////////////////////
// Name:        notebook.h
// Purpose:     c++ wrapper for wxNotebook
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxNotebook:public wxNotebook
{
    _DECLARE_DYNAMIC_CLASS( _wxNotebook );
    _DECLARE_SELFREF();
public:
    _wxNotebook( const char* package, wxWindow* parent, wxWindowID id,
                 const wxPoint& pos, const wxSize& size, long style,
                 const wxString& name );
};

_wxNotebook::_wxNotebook( const char* package, wxWindow* parent, wxWindowID id,
                          const wxPoint& pos, const wxSize& size, long style,
                          const wxString& name )
    :m_callback( "Wx::Notebook" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxNotebook, wxNotebook );

// Local variables: //
// mode: c++ //
// End: //
