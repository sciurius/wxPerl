/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/wizard.h
// Purpose:     c++ wrapper for wxWizard/wxWizardPage
// Author:      Mattia Barbon
// Modified by:
// Created:     28/08/2002
// RCS-ID:      $Id: wizard.h,v 1.3 2004/08/04 20:13:55 mbarbon Exp $
// Copyright:   (c) 2002-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define DEC_V_CBACK_BOOL__WXWIZARDPAGE( NAME ) \
    bool NAME( wxWizardPage* page )

#define DEF_V_CBACK_BOOL__WXWIZARDPAGE( CLASS, BASE, METHOD )                \
    DEF_V_CBACK_BOOL__WXOBJECTsP_( wxWizardPage*, CLASS,                     \
                                  return BASE::METHOD( p1 ),                 \
                                  METHOD, wxPli_NOCONST )

#define DEC_V_CBACK_WXWIZARDPAGE__VOID_const( NAME ) \
    wxWizardPage* NAME() const

#define DEF_V_CBACK_WXWIZARDPAGE__VOID_const_pure( CLASS, BASE, METHOD )     \
    DEF_V_CBACK_WXOBJECTsP__VOID_( wxWizardPage*, Wx::WizardPage,            \
                                   CLASS, return NULL, METHOD, wxPli_CONST )

class wxPliWizard : public wxWizard
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliWizard );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliWizard, "Wx::Wizard", true );
    WXPLI_CONSTRUCTOR_5( wxPliWizard, "Wx::Wizard", true,
                         wxWindow*, wxWindowID, const wxString&,
                         const wxBitmap&, const wxPoint& ); 

    DEC_V_CBACK_BOOL__WXWIZARDPAGE( HasPrevPage );
    DEC_V_CBACK_BOOL__WXWIZARDPAGE( HasNextPage );
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliWizard, wxWizard );

DEF_V_CBACK_BOOL__WXWIZARDPAGE( wxPliWizard, wxWizard, HasPrevPage );
DEF_V_CBACK_BOOL__WXWIZARDPAGE( wxPliWizard, wxWizard, HasNextPage );

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
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    DEC_V_CBACK_WXWIZARDPAGE__VOID_const( GetPrev );
    DEC_V_CBACK_WXWIZARDPAGE__VOID_const( GetNext );
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliWizardPage, wxWizardPage );

DEF_V_CBACK_WXWIZARDPAGE__VOID_const_pure( wxPliWizardPage, wxWizardPage,
                                           GetPrev );
DEF_V_CBACK_WXWIZARDPAGE__VOID_const_pure( wxPliWizardPage, wxWizardPage,
                                           GetNext );

// local variables:
// mode: c++
// end:
