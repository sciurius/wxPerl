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

inline _wxPlSizer::_wxPlSizer( const char* package )
    :m_callback( "Wx::PlSizer" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
}

void _wxPlSizer::RecalcSizes()
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "RecalcSizes" ) )
    {
        wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR|G_DISCARD );
        return;
    }
}

wxSize _wxPlSizer::CalcMin()
{
    static wxSize ret( 0, 0 );

    if( wxPliVirtualCallback_FindCallback( &m_callback, "CalcMin" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR );
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
