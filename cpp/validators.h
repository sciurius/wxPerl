/////////////////////////////////////////////////////////////////////////////
// Name:        validators.h
// Purpose:     c++ wrapper for wxValidator, and wxPlValidator
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_VALIDATORS_H
#define _WXPERL_VALIDATORS_H

class wxPlValidator:public wxValidator
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlValidator );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlValidator( const char* package );

    virtual wxObject* Clone() const;
    virtual bool Validate( wxWindow* );

    DEC_V_CBACK_BOOL__VOID( TransferToWindow );
    DEC_V_CBACK_BOOL__VOID( TransferFromWindow );
};

DEF_V_CBACK_BOOL__VOID( wxPlValidator, wxValidator, TransferToWindow );
DEF_V_CBACK_BOOL__VOID( wxPlValidator, wxValidator, TransferFromWindow );

inline wxPlValidator::wxPlValidator( const char* package )
    :m_callback( "Wx::PlValidator" )
{ 
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

wxObject* wxPlValidator::Clone() const
{
    wxPlValidator* self = (wxPlValidator*)this;

    if( wxPliVirtualCallback_FindCallback( &self->m_callback, "Clone" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &self->m_callback, G_SCALAR );
        wxValidator* clone =
            (wxValidator*)wxPli_sv_2_object( ret, "Wx::Validator" );
        SvREFCNT_dec( ret );
        
        delete self;
        return clone;
    }

    return 0;
}

bool wxPlValidator::Validate( wxWindow* parent )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "Validate" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &m_callback, G_SCALAR, "S", 
              wxPli_object_2_sv( sv_newmortal(), parent ) );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );

        return val;
    }
    else
        return wxValidator::Validate( parent );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlValidator, wxValidator );

#endif // _WXPERL_VALIDATORS_H

// Local variables: //
// mode: c++ //
// End: //
