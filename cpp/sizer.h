/////////////////////////////////////////////////////////////////////////////
// Name:        button.h
// Purpose:     c++ wrapper for wxButton
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxPlSizer:public wxSizer
{
    _DECLARE_DYNAMIC_CLASS( _wxPlSizer );
    _DECLARE_V_CBACK();
public:
    _wxPlSizer( const char* package );

    virtual void RecalcSizes();
    virtual wxSize CalcMin();
};

_wxPlSizer::_wxPlSizer( const char* package )
    :m_callback( "Wx::PlSizer" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
}

void _wxPlSizer::RecalcSizes()
{
    if( m_callback.FindCallback( "RecalcSizes" ) )
    {
        m_callback.CallCallback( G_SCALAR|G_DISCARD );
        return;
    }
}

wxSize _wxPlSizer::CalcMin()
{
    static wxSize ret( 0, 0 );

    if( m_callback.FindCallback( "CalcMin" ) )
    {
        SV* ret = m_callback.CallCallback( G_SCALAR );
        wxSize* val = (wxSize*)_sv_2_object( ret, "Wx::Size" );
        SvREFCNT_dec( ret );
        return *val;
    }

    return ret;
}

_IMPLEMENT_DYNAMIC_CLASS( _wxPlSizer, wxSizer );

// Local variables: //
// mode: c++ //
// End: //
