/////////////////////////////////////////////////////////////////////////////
// Name:        controls.cpp
// Purpose:     implementation for controls.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000-2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliBitmapButton, wxBitmapButton );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliButton, wxButton );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliCheckBox, wxCheckBox );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliCheckListBox, wxCheckListBox );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliChoice, wxChoice );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliComboBox, wxComboBox );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliListBox, wxListBox );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliNotebook, wxNotebook );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliRadioBox, wxRadioBox );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliRadioButton, wxRadioButton );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliScrollBar, wxScrollBar );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliSpinButton, wxSpinButton );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliSpinCtrl, wxSpinCtrl );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliStaticBitmap, wxStaticBitmap );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliStaticBox, wxStaticBox );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliStaticLine, wxStaticLine );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliStaticText, wxStaticText );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliTextCtrl, wxTextCtrl );
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliToggleButton, wxToggleButton );

#if defined( __WXMSW__ )
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliGauge, wxGauge95 );
#else
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliGauge, wxGauge );
#endif

#if defined( __WXMSW__ )
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliSlider, wxSlider95 );
#else
WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliSlider, wxSlider );
#endif


//
// Wx::ListCtrl implementation
//

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliListCtrl, wxListCtrl );

double listctrl_constant( const char* name, int arg )
{
  // !package: Wx
  // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
  // !tag:
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

  WX_PL_CONSTANT_INIT();

  switch( fl )
  {
  case 'E':
      r( wxEVT_COMMAND_LIST_BEGIN_DRAG );
      r( wxEVT_COMMAND_LIST_BEGIN_RDRAG );
      r( wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT );
      r( wxEVT_COMMAND_LIST_END_LABEL_EDIT );
      r( wxEVT_COMMAND_LIST_DELETE_ITEM );
      r( wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS );
      r( wxEVT_COMMAND_LIST_SET_INFO );
      r( wxEVT_COMMAND_LIST_GET_INFO );
      r( wxEVT_COMMAND_LIST_ITEM_SELECTED );
      r( wxEVT_COMMAND_LIST_ITEM_DESELECTED );
      r( wxEVT_COMMAND_LIST_KEY_DOWN );
      r( wxEVT_COMMAND_LIST_INSERT_ITEM );
      r( wxEVT_COMMAND_LIST_COL_CLICK );
      r( wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK );
      r( wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK );
      r( wxEVT_COMMAND_LIST_ITEM_ACTIVATED );

      break;
  case 'I':
      r( wxIMAGE_LIST_NORMAL );         // listctrl
      r( wxIMAGE_LIST_SMALL );          // listctrl
      r( wxIMAGE_LIST_STATE );          // listctrl
      break;
  case 'L':
      r( wxLIST_AUTOSIZE );             // listctrl
      r( wxLIST_AUTOSIZE_USEHEADER );   // listctrl

      r( wxLIST_ALIGN_DEFAULT );        // listctrl
      r( wxLIST_ALIGN_LEFT );           // listctrl
      r( wxLIST_ALIGN_TOP );            // listctrl
      r( wxLIST_ALIGN_SNAP_TO_GRID );   // listctrl

      r( wxLIST_FORMAT_LEFT );          // listctrl
      r( wxLIST_FORMAT_RIGHT );         // listctrl
      r( wxLIST_FORMAT_CENTRE );        // listctrl

      r( wxLIST_HITTEST_ABOVE );        // listctrl
      r( wxLIST_HITTEST_BELOW );        // listctrl
      r( wxLIST_HITTEST_NOWHERE );      // listctrl
      r( wxLIST_HITTEST_ONITEMICON );   // listctrl
      r( wxLIST_HITTEST_ONITEMLABEL );  // listctrl
      r( wxLIST_HITTEST_ONITEMRIGHT );  // listctrl
      r( wxLIST_HITTEST_ONITEMSTATEICON );// listctrl
      r( wxLIST_HITTEST_TOLEFT );       // listctrl
      r( wxLIST_HITTEST_TORIGHT );      // listctrl
      r( wxLIST_HITTEST_ONITEM );       // listctrl

      r( wxLIST_MASK_STATE );           // listctrl
      r( wxLIST_MASK_TEXT );            // listctrl
      r( wxLIST_MASK_IMAGE );           // listctrl
      r( wxLIST_MASK_DATA );            // listctrl
      r( wxLIST_MASK_WIDTH );           // listctrl
      r( wxLIST_MASK_FORMAT );          // listctrl

      r( wxLIST_NEXT_ABOVE );           // listctrl
      r( wxLIST_NEXT_ALL );             // listctrl
      r( wxLIST_NEXT_BELOW );           // listctrl
      r( wxLIST_NEXT_LEFT );            // listctrl
      r( wxLIST_NEXT_RIGHT );           // listctrl

      r( wxLIST_RECT_BOUNDS );          // listctrl
      r( wxLIST_RECT_ICON );            // listctrl
      r( wxLIST_RECT_LABEL );           // listctrl

      r( wxLIST_STATE_DONTCARE );       // listctrl
      r( wxLIST_STATE_DROPHILITED );    // listctrl
      r( wxLIST_STATE_FOCUSED );        // listctrl
      r( wxLIST_STATE_SELECTED );       // listctrl
      r( wxLIST_STATE_CUT );            // listctrl

      r( wxLIST_SET_ITEM );             // listctrl
#if WXPERL_W_VERSION_GE( 2, 3 )
      r( wxLC_VRULES );                 // listctrl
      r( wxLC_HRULES );                 // listctrl
#endif
      r( wxLC_ICON );                   // listctrl
      r( wxLC_SMALL_ICON );             // listctrl
      r( wxLC_LIST );                   // listctrl
      r( wxLC_REPORT );                 // listctrl
      r( wxLC_ALIGN_TOP );              // listctrl
      r( wxLC_ALIGN_LEFT );             // listctrl
      r( wxLC_AUTOARRANGE );            // listctrl
      r( wxLC_USER_TEXT );              // listctrl
      r( wxLC_EDIT_LABELS );            // listctrl
      r( wxLC_NO_HEADER );              // listctrl
      r( wxLC_NO_SORT_HEADER );         // listctrl
      r( wxLC_SINGLE_SEL );             // listctrl
      r( wxLC_SORT_ASCENDING );         // listctrl
      r( wxLC_SORT_DESCENDING );        // listctrl
#if WXPERL_W_VERSION_GE( 2, 3 )
      r( wxLC_VIRTUAL );                // listctrl
#endif
      break;
  }
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants listctrl_module( &listctrl_constant );

//
// Wx::TreeCtrl implementation
//

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliTreeCtrl, wxTreeCtrl );

double treectrl_constant( const char* name, int arg )
{
  // !package: Wx
  // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
  // !tag:
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

  WX_PL_CONSTANT_INIT();

  switch( fl ) {
  case 'E':
      r( wxEVT_COMMAND_TREE_BEGIN_DRAG );
      r( wxEVT_COMMAND_TREE_BEGIN_RDRAG );
      r( wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT );
      r( wxEVT_COMMAND_TREE_END_LABEL_EDIT );
      r( wxEVT_COMMAND_TREE_DELETE_ITEM );
      r( wxEVT_COMMAND_TREE_GET_INFO );
      r( wxEVT_COMMAND_TREE_SET_INFO );
      r( wxEVT_COMMAND_TREE_ITEM_EXPANDED );
      r( wxEVT_COMMAND_TREE_ITEM_EXPANDING );
      r( wxEVT_COMMAND_TREE_ITEM_COLLAPSED );
      r( wxEVT_COMMAND_TREE_ITEM_COLLAPSING );
      r( wxEVT_COMMAND_TREE_SEL_CHANGED );
      r( wxEVT_COMMAND_TREE_SEL_CHANGING );
      r( wxEVT_COMMAND_TREE_KEY_DOWN );
      r( wxEVT_COMMAND_TREE_ITEM_ACTIVATED );
      r( wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK );
      r( wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK );
      r( wxEVT_COMMAND_TREE_END_DRAG );

      break;
  case 'T':
    r( wxTR_HAS_BUTTONS );              // treectrl
    r( wxTR_EDIT_LABELS );              // treectrl
    r( wxTR_MULTIPLE );                 // treectrl

    r( wxTreeItemIcon_Normal );         // treectrl
    r( wxTreeItemIcon_Selected );       // treectrl
    r( wxTreeItemIcon_Expanded );       // treectrl
    r( wxTreeItemIcon_SelectedExpanded ); // treectrl

    r( wxTREE_HITTEST_ABOVE );          // treectrl
    r( wxTREE_HITTEST_BELOW );          // treectrl
    r( wxTREE_HITTEST_NOWHERE );        // treectrl
    r( wxTREE_HITTEST_ONITEMBUTTON );   // treectrl
    r( wxTREE_HITTEST_ONITEMICON );     // treectrl
    r( wxTREE_HITTEST_ONITEMINDENT );   // treectrl
    r( wxTREE_HITTEST_ONITEMLABEL );    // treectrl
    r( wxTREE_HITTEST_ONITEMRIGHT );    // treectrl
    r( wxTREE_HITTEST_ONITEMSTATEICON ); // treectrl
    r( wxTREE_HITTEST_TOLEFT );         // treectrl
    r( wxTREE_HITTEST_TORIGHT );        // treectrl
    r( wxTREE_HITTEST_ONITEMUPPERPART ); // treectrl
    r( wxTREE_HITTEST_ONITEMLOWERPART ); // treectrl
    r( wxTREE_HITTEST_ONITEM );         // treectrl
    break;
  default:
    break;
  }
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants tree_module( &treectrl_constant );

int wxPliTreeCtrl::OnCompareItems( const wxTreeItemId& item1,
                                   const wxTreeItemId& item2 )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "OnCompareItems" ) )
    {
        SV* t1 = wxPli_non_object_2_sv( newSViv( 0 ),
                                        (void*)&item1, wxPlTreeItemIdName );
        SV* t2 = wxPli_non_object_2_sv( newSViv( 0 ),
                                        (void*)&item2, wxPlTreeItemIdName );
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &m_callback, G_SCALAR, "SS", t1, t2 );

        sv_setiv( SvRV( t1 ), 0 );
        sv_setiv( SvRV( t2 ), 0 );
        int val = SvIV( ret );
        SvREFCNT_dec( ret );
        SvREFCNT_dec( t1 );
        SvREFCNT_dec( t2 );

        return val;
    }
    else
        return wxTreeCtrl::OnCompareItems( item1, item2 );
}

// Local variables: //
// mode: c++ //
// End: //
