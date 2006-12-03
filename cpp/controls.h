/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/controls.h
// Purpose:     c++ wrappers for wxControl-derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: controls.h,v 1.22 2006/12/03 14:56:38 mbarbon Exp $
// Copyright:   (c) 2000-2004, 2006 Mattia Barbon
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
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliListCtrl, "Wx::ListCtrl", true );
    WXPLI_CONSTRUCTOR_7( wxPliListCtrl, "Wx::ListCtrl", true,
                         wxWindow*, wxWindowID, const wxPoint&,
                         const wxSize&, long, const wxValidator&,
                         const wxString& );

    wxString OnGetItemText( long item, long column ) const;
    int OnGetItemImage( long item ) const;
    wxListItemAttr* OnGetItemAttr( long item ) const;
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
    DEC_V_CBACK_INT__LONG_LONG_const( OnGetItemColumnImage );
#endif
};

class wxPliTreeCtrl:public wxTreeCtrl
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliTreeCtrl );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliTreeCtrl, "Wx::TreeCtrl", true );
    WXPLI_CONSTRUCTOR_7( wxPliTreeCtrl, "Wx::TreeCtrl", true,
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
