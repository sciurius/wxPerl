/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/validators.h
// Purpose:     c++ wrapper for wxValidator, and wxPlValidator
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: validators.h,v 1.8 2004/12/21 21:12:46 mbarbon Exp $
// Copyright:   (c) 2000-2002, 2004 Mattia Barbon
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
    m_callback.SetSelf( wxPli_make_object( this, package ), true );
}

wxObject* wxPlValidator::Clone() const
{
    dTHX;
    wxPlValidator* self = (wxPlValidator*)this;

    if( wxPliVirtualCallback_FindCallback( aTHX_ &self->m_callback, "Clone" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( aTHX_ &self->m_callback, G_SCALAR, NULL );
        wxValidator* clone =
            (wxValidator*)wxPli_sv_2_object( aTHX_ ret, "Wx::Validator" );
        SvREFCNT_dec( ret );
        
        delete self;
        return clone;
    }

    return 0;
}

bool wxPlValidator::Validate( wxWindow* parent )
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "Validate" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( aTHX_ &m_callback, G_SCALAR, "s", 
              wxPli_object_2_sv( aTHX_ sv_newmortal(), parent ) );
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
