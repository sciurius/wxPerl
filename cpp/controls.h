/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/controls.h
// Purpose:     c++ wrappers for wxControl-derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: controls.h,v 1.17 2003/05/31 15:36:56 mbarbon Exp $
// Copyright:   (c) 2000-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_CONTROLS_H
#define _WXPERL_CONTROLS_H

class wxPliListCtrl:public wxListCtrl
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliListCtrl );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliListCtrl, "Wx::ListCtrl", TRUE );
    WXPLI_CONSTRUCTOR_7( wxPliListCtrl, "Wx::ListCtrl", TRUE,
                         wxWindow*, wxWindowID, const wxPoint&,
                         const wxSize&, long, const wxValidator&,
                         const wxString& );

    wxString OnGetItemText( long item, long column ) const;
    int OnGetItemImage( long item ) const;
    wxListItemAttr* OnGetItemAttr( long item ) const;
};

WXPLI_DECLARE_CLASS_10( Slider, TRUE,
                        wxWindow*, wxWindowID, int, int, int,
                        const wxPoint&, const wxSize&, long,
                        const wxValidator&, const wxString& );

class wxPliStaticBitmap:public wxStaticBitmap
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliStaticBitmap );
    WXPLI_DECLARE_SELFREF();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliStaticBitmap, "Wx::StaticBitmap", TRUE );
    WXPLI_CONSTRUCTOR_7( wxPliStaticBitmap, "Wx::StaticBitmap", TRUE,
                         wxWindow*, wxWindowID, const wxBitmap&,
                         const wxPoint&, const wxSize&, long,
                         const wxString& );
#if !defined(__WXUNIVERSAL__)
    WXPLI_CONSTRUCTOR_7( wxPliStaticBitmap, "Wx::StaticBitmap", TRUE,
                         wxWindow*, wxWindowID, const wxIcon&,
                         const wxPoint&, const wxSize&, long,
                         const wxString& );
#endif
};


WXPLI_DECLARE_CLASS_7( StaticBox, TRUE,
                       wxWindow*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long,
                       const wxString& );
WXPLI_DECLARE_CLASS_7( StaticText, TRUE,
                       wxWindow*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long,
                       const wxString& );
WXPLI_DECLARE_CLASS_8( TextCtrl, TRUE,
                       wxWindow*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long,
                       const wxValidator&, const wxString& );

class wxPliTreeCtrl:public wxTreeCtrl
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliTreeCtrl );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliTreeCtrl, "Wx::TreeCtrl", TRUE );
    WXPLI_CONSTRUCTOR_7( wxPliTreeCtrl, "Wx::TreeCtrl", TRUE,
                         wxWindow*, wxWindowID, const wxPoint&,
                         const wxSize&, long, const wxValidator&,
                         const wxString& );

    int OnCompareItems( const wxTreeItemId& item1,
                        const wxTreeItemId& item2 );
};

#endif // _WXPERL_CONTROLS_H

// Local variables: //
// mode: c++ //
// End: //
