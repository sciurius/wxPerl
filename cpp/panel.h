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
    _DECLARE_DYNAMIC_CLASS( _wxPanel );
    _DECLARE_V_CBACK();
public:
    _wxPanel( const char* package, wxWindow* parent, wxWindowID id, 
              const wxPoint& pos, const wxSize& size,
              long style, const wxString& name );

    DEC_V_CBACK_BOOL__VOID( TransferDataFromWindow );
    DEC_V_CBACK_BOOL__VOID( TransferDataToWindow );
    DEC_V_CBACK_BOOL__VOID( Validate );
};

inline _wxPanel::_wxPanel( const char* package, wxWindow* parent,
                           wxWindowID id, const wxPoint& pos,
                           const wxSize& size, long style,
                           const wxString& name )
    :m_callback( "Wx::Panel" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

DEF_V_CBACK_BOOL__VOID( _wxPanel, wxPanel, TransferDataFromWindow );
DEF_V_CBACK_BOOL__VOID( _wxPanel, wxPanel, TransferDataToWindow );
DEF_V_CBACK_BOOL__VOID( _wxPanel, wxPanel, Validate );

_IMPLEMENT_DYNAMIC_CLASS( _wxPanel, wxPanel );

// Local variables: //
// mode: c++ //
// End: //
