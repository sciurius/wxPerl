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

_wxPlValidator::_wxPlValidator( const char* package )
    :m_callback( "Wx::PlValidator" )
{ 
    m_callback.SetSelf( _make_object( this, package ), FALSE );
}

wxObject* _wxPlValidator::Clone() const
{
    _wxPlValidator* self = (_wxPlValidator*)this;

    if( self->m_callback.FindCallback( "Clone" ) )
    {
        SV* ret = self->m_callback.CallCallback( G_SCALAR );
        wxValidator* clone = (wxValidator*)_sv_2_object( ret, "Wx::Validator" );
        SvREFCNT_dec( ret );
        
        delete self;
        return clone;
    }

    return 0;
}

bool _wxPlValidator::TransferToWindow()
{
    if( m_callback.FindCallback( "TransferToWindow" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );

        return val;
    }
    else
        return wxValidator::TransferToWindow();
}

bool _wxPlValidator::TransferFromWindow()
{
    if( m_callback.FindCallback( "TransferFromWindow" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );

        return val;
    }
    else
        return wxValidator::TransferFromWindow();
}

bool _wxPlValidator::Validate( wxWindow* parent )
{
    if( m_callback.FindCallback( "Validate" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR, "S", 
                                           _object_2_sv( sv_newmortal(), parent )
            );
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
