/////////////////////////////////////////////////////////////////////////////
// Name:        wizard.h
// Purpose:     c++ wrapper for wxWizardPage
// Author:      Mattia Barbon
// Modified by:
// Created:     28/ 8/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class wxPliWizardPage : public wxWizardPage
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliWizardPage );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPliWizardPage( const char* package, wxWizard* parent,
                     const wxBitmap& bitmap )
        :wxWizardPage( parent, bitmap ),
         m_callback( "Wx::WizardPage" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
    }

    wxWizardPage* GetPrev() const;
    wxWizardPage* GetNext() const;
};

wxWizardPage* wxPliWizardPage::GetPrev() const
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "GetPrev" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                                     G_SCALAR );
        wxWizardPage* val =
            (wxWizardPage*)wxPli_sv_2_object( aTHX_ ret, "Wx::WizardPage" );
        SvREFCNT_dec( ret );
        return val;
    }

    return 0;
}

wxWizardPage* wxPliWizardPage::GetNext() const
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "GetNext" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                                     G_SCALAR );
        wxWizardPage* val =
            (wxWizardPage*)wxPli_sv_2_object( aTHX_ ret, "Wx::WizardPage" );
        SvREFCNT_dec( ret );
        return val;
    }

    return 0;
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliWizardPage, wxWizardPage );

// local variables:
// mode: c++
// end:
