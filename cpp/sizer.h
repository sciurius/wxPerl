/////////////////////////////////////////////////////////////////////////////
// Name:        sizer.h
// Purpose:     c++ wrapper for wxSizers
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class wxPlSizer:public wxSizer
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlSizer );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlSizer( const char* package );

    virtual void RecalcSizes();
    virtual wxSize CalcMin();
};

inline wxPlSizer::wxPlSizer( const char* package )
    :m_callback( "Wx::PlSizer" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

void wxPlSizer::RecalcSizes()
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "RecalcSizes" ) )
    {
        wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR|G_DISCARD );
        return;
    }
}

wxSize wxPlSizer::CalcMin()
{
    static wxSize ret( 0, 0 );

    if( wxPliVirtualCallback_FindCallback( &m_callback, "CalcMin" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR );
        wxSize* val = (wxSize*)wxPli_sv_2_object( ret, "Wx::Size" );
        SvREFCNT_dec( ret );
        return *val;
    }

    return ret;
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlSizer, wxSizer );

// Local variables: //
// mode: c++ //
// End: //
