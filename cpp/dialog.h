/////////////////////////////////////////////////////////////////////////////
// Name:        dialog.h
// Purpose:     c++ wrapper for wxDialog
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxDialog:public wxDialog
{
    _DECLARE_DYNAMIC_CLASS( _wxDialog );
    _DECLARE_V_CBACK();
public:
    _wxDialog( const char* package, wxWindow* parent, wxWindowID id, 
               const wxString& title, const wxPoint& pos, const wxSize& size,
               long style, const wxString& name );

    virtual bool TransferDataFromWindow();
    virtual bool TransferDataToWindow();
    virtual bool Validate();
};

inline _wxDialog::_wxDialog( const char* package, wxWindow* parent,
                             wxWindowID id, const wxString& title,
                             const wxPoint& pos, const wxSize& size,
                             long style, const wxString& name )
    :m_callback( "Wx::Dialog" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, title, pos, size, style, name );
}

bool _wxDialog::TransferDataFromWindow()
{
    if( m_callback.FindCallback( "TransferDataFromWindow" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );

        return val;
    }
    else
        return wxDialog::TransferDataFromWindow();
}

bool _wxDialog::TransferDataToWindow()
{
    if( m_callback.FindCallback( "TransferDataToWindow" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );

        return val;
    }
    else
        return wxDialog::TransferDataToWindow();
}

bool _wxDialog::Validate() 
{
    if( m_callback.FindCallback( "Validate" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );
        
        return val;
    }
    else
        return wxDialog::Validate();
}

_IMPLEMENT_DYNAMIC_CLASS( _wxDialog, wxDialog );

// Local variables: //
// mode: c++ //
// End: //
