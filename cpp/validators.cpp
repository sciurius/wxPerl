/////////////////////////////////////////////////////////////////////////////
// Name:        validators.cpp
// Purpose:     implementation for validators.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

inline _wxPlValidator::_wxPlValidator( const char* package )
    :m_callback( "Wx::PlValidator" )
{ 
    m_callback.SetSelf( _make_object( this, package ), FALSE );
}

wxObject* _wxPlValidator::Clone() const
{
    _wxPlValidator* self = (_wxPlValidator*)this;

    if( wxPliVirtualCallback_FindCallback( &self->m_callback, "Clone" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &self->m_callback, G_SCALAR );
        wxValidator* clone = (wxValidator*)_sv_2_object( ret, "Wx::Validator" );
        SvREFCNT_dec( ret );
        
        delete self;
        return clone;
    }

    return 0;
}

DEF_V_CBACK_BOOL__VOID( _wxPlValidator, wxValidator, TransferToWindow );
DEF_V_CBACK_BOOL__VOID( _wxPlValidator, wxValidator, TransferFromWindow );

bool _wxPlValidator::Validate( wxWindow* parent )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "Validate" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &m_callback, G_SCALAR, "S", 
              _object_2_sv( sv_newmortal(), parent ) );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );

        return val;
    }
    else
        return wxValidator::Validate( parent );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxPlValidator, wxValidator );

// Local variables: //
// mode: c++ //
// End: //
