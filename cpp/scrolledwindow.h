/////////////////////////////////////////////////////////////////////////////
// Name:        scrolledwindow.h
// Purpose:     c++ wrapper for wxScrolledWindow
// Author:      Mattia Barbon
// Modified by:
// Created:      2/12/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxScrolledWindow:public wxScrolledWindow
{
    _DECLARE_DYNAMIC_CLASS( _wxScrolledWindow );
    _DECLARE_V_CBACK();
public:
    _wxScrolledWindow( const char* package, wxWindow* parent, wxWindowID id,
                       const wxPoint& pos, const wxSize& size, long style,
                       const wxString& name );

    void OnDraw( wxDC& dc );
};

_wxScrolledWindow::_wxScrolledWindow( const char* package, wxWindow* parent, 
                                      wxWindowID id,
                                      const wxPoint& pos, const wxSize& size, 
                                      long style,
                                      const wxString& name )
    :m_callback( "Wx::ScrolledWindow" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

void _wxScrolledWindow::OnDraw( wxDC& dc )
{
    if( m_callback.FindCallback( "OnDraw" ) )
    {
        SV* val = _object_2_sv( newSViv( 0 ), &dc );
        SV* ret = m_callback.CallCallback( G_SCALAR|G_DISCARD, "S", val );
        sv_setiv( SvRV( val ), 0 );
        SvREFCNT_dec( val );
        SvREFCNT_dec( ret );
    } else
        wxScrolledWindow::OnDraw( dc );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxScrolledWindow, wxScrolledWindow );

// Local variables: //
// mode: c++ //
// End: //
