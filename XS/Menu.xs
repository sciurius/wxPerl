#############################################################################
## Name:        Menu.xs
## Purpose:     XS for Wx::Menu, Wx::MenuBar, Wx::MenuItem
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Menu.xs,v 1.18 2003/05/17 13:20:13 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/menu.h>

MODULE=Wx PACKAGE=Wx::Menu

Wx_Menu*
Wx_Menu::new( title = wxEmptyString, style = 0)
    wxString title
    long style

void
Wx_Menu::AppendString( id, item, help = wxEmptyString, kind = wxITEM_NORMAL )
    int id
    wxString item
    wxString help
    wxItemKind kind
  CODE:
    THIS->Append( id, item, help, kind );

void
Wx_Menu::AppendSubMenu( id, item, subMenu, helpString = wxEmptyString )
    int id
    wxString item
    Wx_Menu* subMenu
    wxString helpString
  CODE:
    THIS->Append( id, item, subMenu, helpString );

void
Wx_Menu::AppendItem( menuItem )
    Wx_MenuItem* menuItem
  CODE:
    THIS->Append( menuItem );

void
Wx_Menu::AppendCheckItem( id, item, helpString = wxEmptyString )
    int id
    wxString item
    wxString helpString

void
Wx_Menu::AppendRadioItem( id, item, helpString = wxEmptyString )
    int id
    wxString item
    wxString helpString

void
Wx_Menu::AppendSeparator()

void
Wx_Menu::Break()

void
Wx_Menu::Check( id, check )
    int id
    bool check

void
Wx_Menu::DeleteId( id )
    int id
  CODE:
    THIS->Delete( id );

void
Wx_Menu::DeleteItem( item )
    Wx_MenuItem* item
  CODE:
    THIS->Delete( item );

void
Wx_Menu::DestroyMenu()
  CODE:
    delete THIS;

void
Wx_Menu::DestroyId( id )
    int id
  CODE:
    THIS->Destroy( id );

void
Wx_Menu::DestroyItem( item )
    Wx_MenuItem* item
  CODE:
    THIS->Destroy( item );

void
Wx_Menu::Enable( id, enable )
    int id
    bool enable

void
Wx_Menu::FindItem( item )
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
Wx_Menu::GetHelpString( id )
    int id

wxString
Wx_Menu::GetLabel( id )
    int id

int
Wx_Menu::GetMenuItemCount()

void
Wx_Menu::GetMenuItems()
  PPCODE:
    wxMenuItemList& data = THIS->GetMenuItems();
    wxMenuItemList::Node* node;
 
    EXTEND( SP, (IV) data.GetCount() );
    for( node = data.GetFirst(); node; node = node->GetNext() )
    {
      PUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), node->GetData() ) );
    }

wxString
Wx_Menu::GetTitle()

bool
Wx_Menu::InsertItem( pos, item )
    int pos
    Wx_MenuItem* item
  CODE:
    RETVAL = THIS->Insert( pos, item );
  OUTPUT:
    RETVAL

void
Wx_Menu::InsertString( pos, id, item, helpString = wxEmptyString, kind = wxITEM_NORMAL )
    int pos
    int id
    wxString item
    wxString helpString
    wxItemKind kind
  CODE:
    THIS->Insert( pos, id, item, helpString, kind );

void
wxMenu::InsertSubMenu( pos, id, text, submenu, help = wxEmptyString )
    int pos
    int id
    wxString text
    wxMenu* submenu
    wxString help
  CODE:
    THIS->Insert( pos, id, text, submenu, help );

void
Wx_Menu::InsertCheckItem( pos, id, item, helpString )
     size_t pos
     int id
     wxString item
     wxString helpString

void
Wx_Menu::InsertRadioItem( pos, id, item, helpString )
     size_t pos
     int id
     wxString item
     wxString helpString

void
Wx_Menu::InsertSeparator( pos )
    size_t pos

bool
Wx_Menu::IsChecked( id )
    int id

bool
Wx_Menu::IsEnabled( id )
    int id

void
Wx_Menu::PrependString( id, item, help = wxEmptyString, kind = wxITEM_NORMAL )
    int id
    wxString item
    wxString help
    wxItemKind kind
  CODE:
    THIS->Prepend( id, item, help, kind );

void
Wx_Menu::PrependItem( menuItem )
    Wx_MenuItem* menuItem
  CODE:
    THIS->Prepend( menuItem );

void
Wx_Menu::PrependSubMenu( id, item, subMenu, helpString = wxEmptyString )
    int id
    wxString item
    Wx_Menu* subMenu
    wxString helpString
  CODE:
    THIS->Prepend( id, item, subMenu, helpString );

void
Wx_Menu::PrependCheckItem( id, item, helpString = wxEmptyString )
    int id
    wxString item
    wxString helpString

void
Wx_Menu::PrependRadioItem( id, item, helpString = wxEmptyString )
    int id
    wxString item
    wxString helpString

void
Wx_Menu::PrependSeparator()

Wx_MenuItem*
Wx_Menu::RemoveId( id )
    int id
  CODE:
    RETVAL = THIS->Remove( id );
  OUTPUT:
    RETVAL

Wx_MenuItem*
Wx_Menu::RemoveItem( item )
    Wx_MenuItem* item
  CODE:
    RETVAL = THIS->Remove( item );
  OUTPUT:
    RETVAL

void
Wx_Menu::SetHelpString( id, helpString )
    int id
    wxString helpString

void
Wx_Menu::SetLabel( id, label )
    int id
    wxString label

void
Wx_Menu::SetTitle( title )
    wxString title

void
Wx_Menu::UpdateUI( source = 0 )
    Wx_EvtHandler* source

MODULE=Wx PACKAGE=Wx::MenuBar

Wx_MenuBar*
Wx_MenuBar::new( style = 0 )
    long style

bool
Wx_MenuBar::Append( menu, title )
    Wx_Menu* menu
    wxString title

void
Wx_MenuBar::Check( id, check )
    int id
    bool check

void
Wx_MenuBar::Enable( id, enable )
    int id
    bool enable

void
Wx_MenuBar::EnableTop( pos, enable )
    int pos
    bool enable

void
Wx_Menu::FindItem( id )
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
Wx_MenuBar::FindMenu( title )
    wxString title

int
Wx_MenuBar::FindMenuItem( menuString, itemString )
    wxString menuString
    wxString itemString

wxString
Wx_MenuBar::GetHelpString( id )
    int id

wxString
Wx_MenuBar::GetLabel( id )
    int id

wxString
Wx_MenuBar::GetLabelTop( id )
    int id

Wx_Menu*
Wx_MenuBar::GetMenu( index )
    int index

int
Wx_MenuBar::GetMenuCount()

bool
Wx_MenuBar::Insert( pos, menu, title )
    int pos
    Wx_Menu* menu
    wxString title

bool
Wx_MenuBar::IsChecked( id )
    int id

bool
Wx_MenuBar::IsEnabled( id )
    int id

void
Wx_MenuBar::Refresh()

Wx_Menu*
Wx_MenuBar::Remove( pos )
    int pos

Wx_Menu*
Wx_MenuBar::Replace( pos, menu, title )
    int pos
    Wx_Menu* menu
    wxString title

void
Wx_MenuBar::SetHelpString( id, helpString )
    int id
    wxString helpString

void
Wx_MenuBar::SetLabel( id, label )
    int id
    wxString label

void
Wx_MenuBar::SetLabelTop( pos, label )
    int pos
    wxString label

MODULE=Wx PACKAGE=Wx::MenuItem

Wx_MenuItem*
Wx_MenuItem::new( parentMenu = 0, id = -1, text = wxEmptyString, helpString = wxEmptyString, itemType = wxITEM_NORMAL, subMenu = 0 )
     Wx_Menu* parentMenu
     int id
     wxString text
     wxString helpString
     wxItemKind itemType
     Wx_Menu* subMenu

void
Wx_MenuItem::Check( check )
    bool check

# void
# Wx_MenuItem::DeleteSubMenu()

void
Wx_MenuItem::Enable( enable )
    bool enable

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

Wx_Colour*
Wx_MenuItem::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
   RETVAL

Wx_Font*
Wx_MenuItem::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

#endif

#if defined( __WXMSW__ ) || \
 defined( __WXGTK__ ) || \
 defined( __WXPERL_FORCE__ )

Wx_Bitmap*
Wx_MenuItem::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

#endif

wxString
Wx_MenuItem::GetHelp()

int
Wx_MenuItem::GetId()

wxItemKind
Wx_MenuItem::GetKind()

wxString
Wx_MenuItem::GetLabel()

wxString
GetLabelFromText( text )
    wxString text
  CODE:
    RETVAL = wxMenuItem::GetLabelFromText( text );
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
Wx_MenuItem::GetMarginWidth()

#endif

wxString
Wx_MenuItem::GetText()

Wx_Menu*
Wx_MenuItem::GetSubMenu()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

Wx_Colour*
Wx_MenuItem::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

#endif 

bool
Wx_MenuItem::IsCheckable()

bool
Wx_MenuItem::IsChecked()

bool
Wx_MenuItem::IsEnabled()

bool
Wx_MenuItem::IsSeparator()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_MenuItem::SetBackgroundColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetBackgroundColour( *colour );

void
Wx_MenuItem::SetFont( font )
    Wx_Font* font
  CODE:
    THIS->SetFont( *font );

#endif

void
Wx_MenuItem::SetHelp( helpString )
    wxString helpString

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_MenuItem::SetMarginWidth( width )
    int width

# void
# Wx_MenuItem::SetName( text )
#     wxString text

void
Wx_MenuItem::SetTextColour( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetTextColour( *colour );

void
Wx_MenuItem::SetBitmaps( checked, unchecked = (wxBitmap*)&wxNullBitmap )
    Wx_Bitmap* checked
    Wx_Bitmap* unchecked
  CODE:
    THIS->SetBitmaps( *checked, *unchecked );

#endif

#if defined( __WXMSW__ ) || defined( __WXGTK__ )

void
Wx_MenuItem::SetBitmap( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SetBitmap( *bitmap );

#endif
