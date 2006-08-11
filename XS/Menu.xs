#############################################################################
## Name:        XS/Menu.xs
## Purpose:     XS for Wx::Menu, Wx::MenuBar, Wx::MenuItem
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Menu.xs,v 1.25 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2000-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/menu.h>

MODULE=Wx PACKAGE=Wx::Menu

wxMenu*
wxMenu::new( title = wxEmptyString, style = 0)
    wxString title
    long style

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

wxMenuItem*
wxMenu::AppendSubMenu( submenu, text, help = wxEmptyString )
    wxMenu* submenu
    wxString text
    wxString help

#endif

void
wxMenu::AppendString( id, item, help = wxEmptyString, kind = wxITEM_NORMAL )
    int id
    wxString item
    wxString help
    wxItemKind kind
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Append( id, item, help, kind ) ) );
#else
    THIS->Append( id, item, help, kind );
#endif

void
wxMenu::AppendSubMenu_( id, item, subMenu, helpString = wxEmptyString )
    int id
    wxString item
    wxMenu* subMenu
    wxString helpString
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Append( id, item, subMenu, helpString ) ) );
#else
    THIS->Append( id, item, subMenu, helpString );
#endif

void
wxMenu::AppendItem( menuItem )
    wxMenuItem* menuItem
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Append( menuItem ) ) );
#else
    THIS->Append( menuItem );
#endif

void
wxMenu::AppendCheckItem( id, item, helpString = wxEmptyString )
    int id
    wxString item
    wxString helpString
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->AppendCheckItem( id, item, helpString ) ) );
#else
    THIS->AppendCheckItem( id, item, helpString );
#endif

void
wxMenu::AppendRadioItem( id, item, helpString = wxEmptyString )
    int id
    wxString item
    wxString helpString
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->AppendRadioItem( id, item, helpString ) ) );
#else
    THIS->AppendRadioItem( id, item, helpString );
#endif

void
wxMenu::AppendSeparator()
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->AppendSeparator() ) );
#else
    THIS->AppendSeparator();
#endif

void
wxMenu::Break()

void
wxMenu::Check( id, check )
    int id
    bool check

void
wxMenu::DeleteId( id )
    int id
  CODE:
    THIS->Delete( id );

void
wxMenu::DeleteItem( item )
    wxMenuItem* item
  CODE:
    THIS->Delete( item );

void
wxMenu::DestroyMenu()
  CODE:
    delete THIS;

void
wxMenu::DestroyId( id )
    int id
  CODE:
    THIS->Destroy( id );

void
wxMenu::DestroyItem( item )
    wxMenuItem* item
  CODE:
    THIS->Destroy( item );

void
wxMenu::Enable( id, enable )
    int id
    bool enable

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxMenuItem*
wxMenu::FindItemByPosition( pos )
    size_t pos

#endif

void
wxMenu::FindItem( item )
    SV* item
  PPCODE:
    if( looks_like_number( item ) ) {
      int id = SvIV( item );
      wxMenu* submenu;
      wxMenuItem* ret;

      ret = THIS->FindItem( id, &submenu );

      SV* mi = sv_newmortal();

      if( GIMME_V == G_ARRAY ) {
        EXTEND( SP, 2 );
        SV* sm = sv_newmortal();

        PUSHs( wxPli_object_2_sv( aTHX_ mi, ret ) );
        PUSHs( wxPli_object_2_sv( aTHX_ sm, submenu ) );
      }
      else {
        EXTEND( SP, 1 );
        PUSHs( wxPli_object_2_sv( aTHX_ mi, ret ) );
      }
    }
    else {
      wxString string;
      WXSTRING_INPUT( string, const char*, item );
      int id = THIS->FindItem( string );

      EXTEND( SP, 1 );
      PUSHs( sv_2mortal( newSViv( id ) ) );
    }

wxString
wxMenu::GetHelpString( id )
    int id

wxString
wxMenu::GetLabel( id )
    int id

int
wxMenu::GetMenuItemCount()

void
wxMenu::GetMenuItems()
  PPCODE:
    wxMenuItemList& data = THIS->GetMenuItems();
    wxMenuItemList::compatibility_iterator node;
 
    EXTEND( SP, (IV) data.GetCount() );
    for( node = data.GetFirst(); node; node = node->GetNext() )
    {
      PUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), node->GetData() ) );
    }

wxString
wxMenu::GetTitle()

void
wxMenu::InsertItem( pos, item )
    int pos
    wxMenuItem* item
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Insert( pos, item ) ) );
#else
    XPUSHs( THIS->Insert( pos, item ) ? &PL_sv_yes : &PL_sv_no );
#endif

void
wxMenu::InsertString( pos, id, item, helpString = wxEmptyString, kind = wxITEM_NORMAL )
    int pos
    int id
    wxString item
    wxString helpString
    wxItemKind kind
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Insert( pos, id, item, helpString, kind ) ) );
#else
    THIS->Insert( pos, id, item, helpString, kind );
#endif

void
wxMenu::InsertSubMenu( pos, id, text, submenu, help = wxEmptyString )
    int pos
    int id
    wxString text
    wxMenu* submenu
    wxString help
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Insert( pos, id, text, submenu, help ) ) );
#else
    THIS->Insert( pos, id, text, submenu, help );
#endif

void
wxMenu::InsertCheckItem( pos, id, item, helpString )
     size_t pos
     int id
     wxString item
     wxString helpString
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->InsertCheckItem( pos, id, item, helpString ) ) );
#else
    THIS->InsertCheckItem( pos, id, item, helpString );
#endif

void
wxMenu::InsertRadioItem( pos, id, item, helpString )
     size_t pos
     int id
     wxString item
     wxString helpString
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->InsertRadioItem( pos, id, item, helpString ) ) );
#else
    THIS->InsertRadioItem( pos, id, item, helpString );
#endif

void
wxMenu::InsertSeparator( pos )
    size_t pos
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->InsertSeparator( pos ) ) );
#else
    THIS->InsertSeparator( pos );
#endif

bool
wxMenu::IsChecked( id )
    int id

bool
wxMenu::IsEnabled( id )
    int id

void
wxMenu::PrependString( id, item, help = wxEmptyString, kind = wxITEM_NORMAL )
    int id
    wxString item
    wxString help
    wxItemKind kind
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Prepend( id, item, help, kind ) ) );
#else
    THIS->Prepend( id, item, help, kind );
#endif

void
wxMenu::PrependItem( menuItem )
    wxMenuItem* menuItem
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Prepend( menuItem ) ) );
#else
    THIS->Prepend( menuItem );
#endif

void
wxMenu::PrependSubMenu( id, item, subMenu, helpString = wxEmptyString )
    int id
    wxString item
    wxMenu* subMenu
    wxString helpString
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->Prepend( id, item, subMenu, helpString ) ) );
#else
    THIS->Prepend( id, item, subMenu, helpString );
#endif

void
wxMenu::PrependCheckItem( id, item, helpString = wxEmptyString )
    int id
    wxString item
    wxString helpString
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->PrependCheckItem( id, item, helpString ) ) );
#else
   THIS->PrependCheckItem( id, item, helpString );
#endif

void
wxMenu::PrependRadioItem( id, item, helpString = wxEmptyString )
    int id
    wxString item
    wxString helpString
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->PrependRadioItem( id, item, helpString ) ) );
#else
    THIS->PrependRadioItem( id, item, helpString );
#endif

void
wxMenu::PrependSeparator()
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(),
            THIS->PrependSeparator() ) );
#else
    THIS->PrependSeparator();
#endif

wxMenuItem*
wxMenu::RemoveId( id )
    int id
  CODE:
    RETVAL = THIS->Remove( id );
  OUTPUT:
    RETVAL

wxMenuItem*
wxMenu::RemoveItem( item )
    wxMenuItem* item
  CODE:
    RETVAL = THIS->Remove( item );
  OUTPUT:
    RETVAL

void
wxMenu::SetHelpString( id, helpString )
    int id
    wxString helpString

void
wxMenu::SetLabel( id, label )
    int id
    wxString label

void
wxMenu::SetTitle( title )
    wxString title

void
wxMenu::UpdateUI( source = 0 )
    wxEvtHandler* source

MODULE=Wx PACKAGE=Wx::MenuBar

wxMenuBar*
wxMenuBar::new( style = 0 )
    long style

bool
wxMenuBar::Append( menu, title )
    wxMenu* menu
    wxString title

void
wxMenuBar::Check( id, check )
    int id
    bool check

void
wxMenuBar::Enable( id, enable )
    int id
    bool enable

void
wxMenuBar::EnableTop( pos, enable )
    int pos
    bool enable

void
wxMenu::FindItem( id )
    int id
  PPCODE:
    wxMenu* submenu;
    wxMenuItem* ret;

    ret = THIS->FindItem( id, &submenu );

    SV* mi = sv_newmortal();

    if( GIMME_V == G_ARRAY ) {
      EXTEND( SP, 2 );
      SV* sm = sv_newmortal();

      PUSHs( wxPli_object_2_sv( aTHX_ mi, ret ) );
      PUSHs( wxPli_object_2_sv( aTHX_ sm, submenu ) );
    }
    else {
      EXTEND( SP, 1 );
      PUSHs( wxPli_object_2_sv( aTHX_ mi, ret ) );
    }

int
wxMenuBar::FindMenu( title )
    wxString title

int
wxMenuBar::FindMenuItem( menuString, itemString )
    wxString menuString
    wxString itemString

wxString
wxMenuBar::GetHelpString( id )
    int id

wxString
wxMenuBar::GetLabel( id )
    int id

wxString
wxMenuBar::GetLabelTop( id )
    int id

wxMenu*
wxMenuBar::GetMenu( index )
    int index

int
wxMenuBar::GetMenuCount()

bool
wxMenuBar::Insert( pos, menu, title )
    int pos
    wxMenu* menu
    wxString title

bool
wxMenuBar::IsChecked( id )
    int id

bool
wxMenuBar::IsEnabled( id )
    int id

void
wxMenuBar::Refresh()

wxMenu*
wxMenuBar::Remove( pos )
    int pos

wxMenu*
wxMenuBar::Replace( pos, menu, title )
    int pos
    wxMenu* menu
    wxString title

void
wxMenuBar::SetHelpString( id, helpString )
    int id
    wxString helpString

void
wxMenuBar::SetLabel( id, label )
    int id
    wxString label

void
wxMenuBar::SetLabelTop( pos, label )
    int pos
    wxString label

bool
wxMenuBar::IsEnabledTop( id )
    int id

MODULE=Wx PACKAGE=Wx::MenuItem

wxMenuItem*
wxMenuItem::new( parentMenu = 0, id = -1, text = wxEmptyString, helpString = wxEmptyString, itemType = wxITEM_NORMAL, subMenu = 0 )
     wxMenu* parentMenu
     int id
     wxString text
     wxString helpString
     wxItemKind itemType
     wxMenu* subMenu

void
wxMenuItem::Check( check )
    bool check

# void
# wxMenuItem::DeleteSubMenu()

void
wxMenuItem::Enable( enable )
    bool enable

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

wxColour*
wxMenuItem::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
   RETVAL

wxFont*
wxMenuItem::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

#endif

#if defined( __WXMSW__ ) || \
 defined( __WXGTK__ ) || \
 defined( __WXPERL_FORCE__ )

wxBitmap*
wxMenuItem::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

#endif

wxString
wxMenuItem::GetHelp()

int
wxMenuItem::GetId()

wxItemKind
wxMenuItem::GetKind()

wxString
wxMenuItem::GetLabel()

wxString
GetLabelFromText( text )
    wxString text
  CODE:
    RETVAL = wxMenuItem::GetLabelFromText( text );
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
wxMenuItem::GetMarginWidth()

#endif

wxString
wxMenuItem::GetText()

wxMenu*
wxMenuItem::GetSubMenu()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

wxColour*
wxMenuItem::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

#endif 

bool
wxMenuItem::IsCheckable()

bool
wxMenuItem::IsChecked()

bool
wxMenuItem::IsEnabled()

bool
wxMenuItem::IsSeparator()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxMenuItem::SetBackgroundColour( colour )
    wxColour* colour
  CODE:
    THIS->SetBackgroundColour( *colour );

void
wxMenuItem::SetFont( font )
    wxFont* font
  CODE:
    THIS->SetFont( *font );

#endif

void
wxMenuItem::SetHelp( helpString )
    wxString helpString

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxMenuItem::SetMarginWidth( width )
    int width

# void
# wxMenuItem::SetName( text )
#     wxString text

void
wxMenuItem::SetTextColour( colour )
    wxColour* colour
  CODE:
    THIS->SetTextColour( *colour );

void
wxMenuItem::SetBitmaps( checked, unchecked = (wxBitmap*)&wxNullBitmap )
    wxBitmap* checked
    wxBitmap* unchecked
  CODE:
    THIS->SetBitmaps( *checked, *unchecked );

#endif

#if defined( __WXMSW__ ) || defined( __WXGTK__ )

void
wxMenuItem::SetBitmap( bitmap )
    wxBitmap* bitmap
  CODE:
    THIS->SetBitmap( *bitmap );

#endif
