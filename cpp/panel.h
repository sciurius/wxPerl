/////////////////////////////////////////////////////////////////////////////
// Name:        panel.h
// Purpose:     c++ wrapper for wxPanel
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxPanel:public wxPanel
{
    _DECLARE_DYNAMIC_CLASS(_wxPanel);
    _DECLARE_V_CBACK();
public:
    _wxPanel( const char* package, wxWindow* parent, wxWindowID id, 
              const wxPoint& pos, const wxSize& size,
              long style, const wxString& name );

    virtual bool TransferDataFromWindow();
    virtual bool TransferDataToWindow();
    virtual bool Validate();
};

_wxPanel::_wxPanel( const char* package, wxWindow* parent, wxWindowID id, 
                    const wxPoint& pos, const wxSize& size,
                    long style, const wxString& name )
    :m_callback( "Wx::Panel" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

bool _wxPanel::TransferDataFromWindow()
{
    if( m_callback.FindCallback( "TransferDataFromWindow" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );
        
        return val;
    }
    else
        return wxPanel::TransferDataFromWindow();
}

bool _wxPanel::TransferDataToWindow()
{
    if( m_callback.FindCallback( "TransferDataToWindow" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );
        
        return val;
    }
    else
        return wxPanel::TransferDataToWindow();
}

bool _wxPanel::Validate() 
{
    if( m_callback.FindCallback( "Validate" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );
        
        return val;
    }
    else
        return wxPanel::Validate();
}

_IMPLEMENT_DYNAMIC_CLASS( _wxPanel, wxPanel );

// Local variables: //
// mode: c++ //
// End: //
