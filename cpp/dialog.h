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

  DEC_V_CBACK_BOOL__VOID( TransferDataFromWindow );
  DEC_V_CBACK_BOOL__VOID( TransferDataToWindow );
  DEC_V_CBACK_BOOL__VOID( Validate );
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

DEF_V_CBACK_BOOL__VOID( _wxDialog, wxDialog, TransferDataFromWindow );
DEF_V_CBACK_BOOL__VOID( _wxDialog, wxDialog, TransferDataToWindow );
DEF_V_CBACK_BOOL__VOID( _wxDialog, wxDialog, Validate );

_IMPLEMENT_DYNAMIC_CLASS( _wxDialog, wxDialog );

// Local variables: //
// mode: c++ //
// End: //
