/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/scrolledwindow.h
// Purpose:     c++ wrapper for wxScrolledWindow
// Author:      Mattia Barbon
// Modified by:
// Created:     02/12/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2002, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class wxPliScrolledWindow:public wxScrolledWindow
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliScrolledWindow );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliScrolledWindow, "Wx::ScrolledWindow",
                               true );
    WXPLI_CONSTRUCTOR_6( wxPliScrolledWindow, "Wx::ScrolledWindow",
                         true, wxWindow*, wxWindowID, const wxPoint&,
                         const wxSize&, long, const wxString& );

    void OnDraw( wxDC& dc );
};

void wxPliScrolledWindow::OnDraw( wxDC& dc )
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "OnDraw" ) )
    {
        SV* val = wxPli_object_2_sv( aTHX_ newSViv( 0 ), &dc );
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                           G_SCALAR|G_DISCARD, "S", val );
        sv_setiv( SvRV( val ), 0 );
        SvREFCNT_dec( val );
    } else
        wxScrolledWindow::OnDraw( dc );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliScrolledWindow, wxScrolledWindow );

// Local variables: //
// mode: c++ //
// End: //
