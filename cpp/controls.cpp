/////////////////////////////////////////////////////////////////////////////
// Name:        controls.cpp
// Purpose:     implementation for controls.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

inline _wxBitmapButton::_wxBitmapButton( const char* package,
                                         wxWindow* parent, 
                                         wxWindowID id,
                                         const wxBitmap& bitmap,
                                         const wxPoint& pos,
                                         const wxSize& size, long style,
                                         const wxValidator& validator, 
                                         const wxString name )
    :m_callback( "Wx::BitmapButton" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, bitmap, pos, size, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxBitmapButton, wxBitmapButton );

inline _wxButton::_wxButton( const char* package, wxWindow* parent,
                             wxWindowID id, 
                             const wxString& label,
                             const wxPoint& pos, const wxSize& size,
                             long style, const wxValidator& validator,
                             const wxString& name )
    :m_callback( "Wx::Button" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, label, pos, size, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxButton, wxButton );

inline _wxCheckBox::_wxCheckBox( const char* package, wxWindow* parent, 
                                 wxWindowID id, const wxString& label, 
                                 const wxPoint& pos, const wxSize& size,
                                 long style, const wxValidator& validator,
                                 const wxString& name )
    :m_callback( "Wx::CheckBox" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, label, pos, size, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxCheckBox, wxCheckBox );

inline _wxCheckListBox::_wxCheckListBox( const char* package, wxWindow* 
                                         parent, wxWindowID id,
                                         const wxPoint& pos,
                                         const wxSize& size, int n,
                                         const wxString choices[], long style, 
                                         const wxValidator& validator, 
                                         const wxString& name )
    :m_callback( "Wx::CheckListBox" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, n, choices, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxCheckListBox, wxCheckListBox );

inline _wxChoice::_wxChoice( const char* package, wxWindow* parent,
                             wxWindowID id, const wxPoint& pos,
                             const wxSize& size, int n,
                             const wxString choices[], long style, 
                             const wxValidator& validator,
                             const wxString& name )
    :m_callback( "Wx::Choice" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, n, choices, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxChoice, wxChoice );

inline _wxComboBox::_wxComboBox( const char* package, wxWindow* parent,
                                 wxWindowID id, const wxString& value,
                                 const wxPoint& pos, const wxSize& size,
                                 int n, const wxString choices[],
                                 long style, const wxValidator& validator, 
                                 const wxString& name )
    :m_callback( "Wx::ComboBox" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, value, pos, size, n, choices, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxComboBox, wxComboBox );

inline _wxGauge::_wxGauge( const char* package, wxWindow* parent,
                           wxWindowID id, int range, const wxPoint& pos,
                           const wxSize& size,
                           long style, const wxValidator& validator,
                           const wxString &name )
    :m_callback( "Wx::Gauge" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, range, pos, size, style, validator, name );
}

#if defined( __WXMSW__ )

_IMPLEMENT_DYNAMIC_CLASS( _wxGauge, wxGauge95 );

#else

_IMPLEMENT_DYNAMIC_CLASS( _wxGauge, wxGauge );

#endif

inline _wxListBox::_wxListBox( const char* package, wxWindow* parent,
                               wxWindowID id, 
                               const wxPoint& pos, const wxSize& size, int n,
                               const wxString choices[], long style, 
                               const wxValidator& validator,
                               const wxString& name )
    :m_callback( "Wx::ListBox" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, n, choices, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxListBox, wxListBox );

inline _wxListCtrl::_wxListCtrl( const char* package, wxWindow* parent,
                                 wxWindowID id, const wxPoint& pos,
                                 const wxSize& size, long style,
                                 const wxValidator& validator,
                                 const wxString& name )
    :m_callback( "Wx::ListCtrl" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, validator, name );
}

double listctrl_constant( const char* name, int arg )
{
  // !package: Wx
  // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

  WX_PL_CONSTANT_INIT();

  switch( fl )
  {
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
      r( wxLC_SINGLE_SEL );             // listctrl
      r( wxLC_SORT_ASCENDING );         // listctrl
      r( wxLC_SORT_DESCENDING );        // listctrl
      break;
  }
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstantsModule listctrl_module( &listctrl_constant );

_IMPLEMENT_DYNAMIC_CLASS( _wxListCtrl, wxListCtrl );

inline _wxRadioButton::_wxRadioButton( const char* package, wxWindow* parent, 
                                       wxWindowID id, const wxString label,
                                       const wxPoint& pos,
                                       const wxSize& size, long style,
                                       const wxValidator& validator, 
                                       const wxString& name )
    :m_callback( "Wx::RadioButton" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, label, pos, size, style, validator, name );    
}

_IMPLEMENT_DYNAMIC_CLASS( _wxRadioButton, wxRadioButton );

inline _wxRadioBox::_wxRadioBox( const char* package, wxWindow* parent, 
                                 wxWindowID id,
                                 const wxString& label, const wxPoint& point,
                                 const wxSize& size, int n, 
                                 const wxString choices[],
                                 int majorDimension, long style, 
                                 const wxValidator& validator, 
                                 const wxString& name )
    :m_callback( "Wx::RadioBox" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, label, point, size, n, choices, majorDimension,
            style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxRadioBox, wxRadioBox );

inline _wxScrollBar::_wxScrollBar( const char* package, wxWindow* parent,
                                   wxWindowID id, const wxPoint& pos,
                                   const wxSize& size, long style,
                                   const wxValidator& validator,
                                   const wxString& name )
    :m_callback( "Wx::ScrollBar" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxScrollBar, wxScrollBar );

inline _wxSpinButton::_wxSpinButton( const char* package, wxWindow* parent, 
                                     wxWindowID id,
                                     const wxPoint& pos, const wxSize& size,
                                     long style, const wxString& name )
    :m_callback( "Wx::SpinButton" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxSpinButton, wxSpinButton );

inline _wxSpinCtrl::_wxSpinCtrl( const char* package, wxWindow* parent,
                                 wxWindowID id,
                                 const wxString& value, const wxPoint& pos,
                                 const wxSize& size, long style, int min,
                                 int max,
                                 int initial, const wxString& name )
    :m_callback( "Wx::SpinCtrl" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, value, pos, size, style, min, max, initial, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxSpinCtrl, wxSpinCtrl );

inline _wxSlider::_wxSlider( const char* package, wxWindow* parent,
                             wxWindowID id,
                             int value, int minValue, int maxValue,
                             const wxPoint& pos, const wxSize& size,
                             long style, const wxValidator& validator,
                             const wxString& name )
    :m_callback( "Wx::Slider" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, value, minValue, maxValue, pos, size, style,
            validator, name );
}

#if defined( __WXMSW__ )

_IMPLEMENT_DYNAMIC_CLASS( _wxSlider, wxSlider95 );

#else

_IMPLEMENT_DYNAMIC_CLASS( _wxSlider, wxSlider );

#endif

inline _wxStaticBitmap::_wxStaticBitmap( const char* package,
                                         wxWindow* parent, 
                                         wxWindowID id, 
                                         const wxBitmap& bitmap,
                                         const wxPoint& pos,
                                         const wxSize& size,
                                         long style, const wxString& name )
    :m_callback( "Wx::StaticBitmap" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, bitmap, pos, size, style, name );
}

inline _wxStaticBitmap::_wxStaticBitmap( const char* package,
                                         wxWindow* parent, wxWindowID id, 
                                         const wxIcon& icon,
                                         const wxPoint& pos,
                                         const wxSize& size,
                                         long style, const wxString& name )
    :m_callback( "Wx::StaticBitmap" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, icon, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxStaticBitmap, wxStaticBitmap );

inline _wxStaticBox::_wxStaticBox( const char* package, wxWindow* parent, 
                                   wxWindowID id,
                                   const wxString& label, const wxPoint& pos,
                                   const wxSize& size, long style, 
                                   const wxString& name )
    :m_callback( "Wx::StaticBox" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, label, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxStaticBox, wxStaticBox );

inline _wxStaticLine::_wxStaticLine( const char* package, wxWindow* parent, 
                                     wxWindowID id,
                                     const wxPoint& pos,
                                     const wxSize& size, long style, 
                                     const wxString& name )
    :m_callback( "Wx::StaticLine" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxStaticLine, wxStaticLine );

inline _wxStaticText::_wxStaticText( const char* package, wxWindow* 
                                     parent, wxWindowID id,
                                     const wxString& label,
                                     const wxPoint& pos, const wxSize& size, 
                                     long style, const wxString& name )
    :m_callback( "Wx::StaticText" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, label, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxStaticText, wxStaticText );

inline _wxTextCtrl::_wxTextCtrl( const char* package, wxWindow* parent, 
                                 wxWindowID id,const wxString& value,
                                 const wxPoint& pos, const wxSize& size,
                                 long style, const wxValidator& validator, 
                                 const wxString& name )
    :m_callback( "Wx::TextCtrl" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, value, pos, size, style, validator, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxTextCtrl, wxTextCtrl );

inline _wxTreeCtrl::_wxTreeCtrl( const char* package, wxWindow* parent,
                                 wxWindowID id, const wxPoint& pos,
                                 const wxSize& size, long style,
                                 const wxValidator& validator,
                                 const wxString& name )
    :m_callback( "Wx::TreeCtrl" )
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, pos, size, style, validator, name );
}

double treectrl_constant( const char* name, int arg )
{
  // !package: Wx
  // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

  WX_PL_CONSTANT_INIT();

  switch( fl ) {
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

wxPlConstantsModule tree_module( &treectrl_constant );

int _wxTreeCtrl::OnCompareItems( const wxTreeItemId& item1,
                                 const wxTreeItemId& item2 )
{
    if( m_callback.FindCallback( "OnCompareItems" ) )
    {
        SV* t1 = _non_object_2_sv( newSViv( 0 ),
                                   (void*)&item1, wxPlTreeItemIdName );
        SV* t2 = _non_object_2_sv( newSViv( 0 ),
                                   (void*)&item2, wxPlTreeItemIdName );
        SV* ret = m_callback.CallCallback( G_SCALAR, "SS", t1, t2 );

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

_IMPLEMENT_DYNAMIC_CLASS( _wxTreeCtrl, wxTreeCtrl );

// Local variables: //
// mode: c++ //
// End: //
