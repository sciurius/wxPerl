#############################################################################
## Name:        ListCtrl.xs
## Purpose:     XS for Wx::ListCtrl, Wx::ListItem
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/listctrl.h>

MODULE=Wx_Evt PACKAGE=Wx::ListEvent

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

long
Wx_ListEvent::GetCacheFrom()

long
Wx_ListEvent::GetCacheTo()

#endif

int
Wx_ListEvent::GetCode()

long
Wx_ListEvent::GetIndex()

long
Wx_ListEvent::GetOldIndex()

int
Wx_ListEvent::GetColumn()

bool
Wx_ListEvent::Cancelled()

Wx_Point*
Wx_ListEvent::GetPoint()
  CODE:
    RETVAL = new wxPoint( THIS->GetPoint() );
  OUTPUT:
    RETVAL

wxString
Wx_ListEvent::GetLabel()

wxString
Wx_ListEvent::GetText()

int
Wx_ListEvent::GetImage()

long
Wx_ListEvent::GetData()

long
Wx_ListEvent::GetMask()

Wx_ListItem*
Wx_ListEvent::GetItem()
  CODE:
    RETVAL = new wxListItem( THIS->GetItem() );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::ListItem

Wx_ListItem*
Wx_ListItem::new()

void
Wx_ListItem::DESTROY()

void
Wx_ListItem::Clear()

void
Wx_ListItem::ClearAttributes()

void
Wx_ListItem::SetMask( mask )
    long mask

void
Wx_ListItem::SetId( id )
    long id

void
Wx_ListItem::SetColumn( column )
    int column

void
Wx_ListItem::SetState( state )
   long state

void
Wx_ListItem::SetStateMask( stateMask )
    long stateMask

void
Wx_ListItem::SetText( text )
    wxString text

void
Wx_ListItem::SetImage( image )
     int image

void
Wx_ListItem::SetData( data )
    long data

void
Wx_ListItem::SetWidth( width )
    int width

void
Wx_ListItem::SetAlign( align )
    wxListColumnFormat align

void
Wx_ListItem::SetTextColour( colour )
    Wx_Colour colour

void
Wx_ListItem::SetBackgroundColour( colour )
    Wx_Colour colour

void
Wx_ListItem::SetFont( font )
    Wx_Font* font
  CODE:
    THIS->SetFont( *font );

long
Wx_ListItem::GetMask()

long
Wx_ListItem::GetId()

int
Wx_ListItem::GetColumn()

long
Wx_ListItem::GetState()

wxString
Wx_ListItem::GetText()

int
Wx_ListItem::GetImage()

long
Wx_ListItem::GetData()

int
Wx_ListItem::GetWidth()

wxListColumnFormat
Wx_ListItem::GetAlign()

Wx_Colour*
Wx_ListItem::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_ListItem::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

Wx_Font*
Wx_ListItem::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::ListItemAttr

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_ListItemAttr*
Wx_ListItemAttr::new( ... )
  CASE: items == 1
    CODE:
      RETVAL = new wxListItemAttr();
    OUTPUT:
      RETVAL
  CASE: items == 4
    INPUT:
      Wx_Colour text = NO_INIT
      Wx_Colour back = NO_INIT
      Wx_Font* font = NO_INIT
    CODE:
      text = *(Wx_Colour *) wxPli_sv_2_object( ST(1), wxPlColourName );
      back = *(Wx_Colour *) wxPli_sv_2_object( ST(2), wxPlColourName );
      font = (Wx_Font *) wxPli_sv_2_object( ST(3), wxPlFontName );
      RETVAL = new wxListItemAttr( text, back, *font );
    OUTPUT:
      RETVAL
  CASE:
    CODE:
      croak( "Usage: Wx::ListItemAttr::new(THIS [, text, back, font ] )" );

void
Wx_ListItemAttr::DESTROY()

void
Wx_ListItemAttr::SetTextColour( text )
    Wx_Colour text

void
Wx_ListItemAttr::SetBackgroundColour( back )
    Wx_Colour back

void
Wx_ListItemAttr::SetFont( font )
    Wx_Font* font
  CODE:
    THIS->SetFont( *font );

bool
Wx_ListItemAttr::HasTextColour()

bool
Wx_ListItemAttr::HasBackgroundColour()

bool
Wx_ListItemAttr::HasFont()

Wx_Colour*
Wx_ListItemAttr::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_ListItemAttr::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

Wx_Font*
Wx_ListItemAttr::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

#endif

MODULE=Wx PACKAGE=Wx::ListCtrl

Wx_ListCtrl*
Wx_ListCtrl::new( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_ICON, validator = (wxValidator*)&wxDefaultValidator, name = "listCtrl" )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new wxPliListCtrl( CLASS, parent, id, pos, size, style,
        *validator, name );
  OUTPUT:
    RETVAL

bool
Wx_ListCtrl::Arrange( flag = wxLIST_ALIGN_DEFAULT )
    int flag

void
Wx_ListCtrl::ClearAll()

bool
Wx_ListCtrl::DeleteItem( item )
    long item

bool
Wx_ListCtrl::DeleteAllItems()

bool
Wx_ListCtrl::DeleteColumn( col )
    int col

void
Wx_ListCtrl::EditLabel( item )
    long item

bool
Wx_ListCtrl::EnsureVisible( item )
    long item

long
Wx_ListCtrl::FindItem( start, str, partial = FALSE )
    long start
    wxString str
    bool partial
  CODE:
    RETVAL = THIS->FindItem( start, str, partial );
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::FindItemData( start, data )
    long start
    long data
  CODE:
    RETVAL = THIS->FindItem( start, data );
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::FindItemAtPos( start, pt, direction )
    long start
    Wx_Point pt
    int direction
  CODE:
    RETVAL = THIS->FindItem( start, pt, direction );
  OUTPUT:
    RETVAL

Wx_ListItem*
Wx_ListCtrl::GetColumn( col )
    int col
  PREINIT:
    wxListItem item;
  CODE:
    if( THIS->GetColumn( col, item ) )
    {
      RETVAL = new wxListItem( item );
    }
    else
    {
      RETVAL = 0;
    }
  OUTPUT:
    RETVAL

int
Wx_ListCtrl::GetColumnCount()

int
Wx_ListCtrl::GetColumnWidth( col )
    int col

int
Wx_ListCtrl::GetCountPerPage()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

Wx_TextCtrl*
Wx_ListCtrl::GetEditControl()

#endif

Wx_ImageList*
Wx_ListCtrl::GetImageList( which )
    int which

Wx_ListItem*
Wx_ListCtrl::GetItem( id, col = -1 )
    long id
    int col
  PREINIT:
    wxListItem item;
  CODE:
    item.SetId( id );
    if( col != -1 ) { item.SetColumn( col ); }
    item.SetMask( wxLIST_MASK_TEXT|wxLIST_MASK_DATA|wxLIST_MASK_IMAGE|
        wxLIST_MASK_STATE );
    if( THIS->GetItem( item ) )
    {
      RETVAL = new wxListItem( item );
    }
    else
    {
      RETVAL = 0;
    }
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::GetItemData( item )
    long item

Wx_Point*
Wx_ListCtrl::GetItemPosition( item )
    long item
  PREINIT:
    wxPoint point;
  CODE:
    if( THIS->GetItemPosition( item, point ) )
    {
      RETVAL = new wxPoint( point );
    }
    else
    {
      RETVAL = 0;
    }
  OUTPUT:
    RETVAL

Wx_Rect*
Wx_ListCtrl::GetItemRect( item )
    long item
  PREINIT:
    wxRect rect;
  CODE:
    if( THIS->GetItemRect( item, rect ) )
    {
      RETVAL = new wxRect( rect );
    }
    else
    {
      RETVAL = 0;
    }
  OUTPUT:
    RETVAL

int
Wx_ListCtrl::GetItemState( item, stateMask )
    long item
    long stateMask

int
Wx_ListCtrl::GetItemCount()

int
Wx_ListCtrl::GetItemSpacing( isSmall )
    bool isSmall

wxString
Wx_ListCtrl::GetItemText( item )
    long item

long
Wx_ListCtrl::GetNextItem( item, geometry = wxLIST_NEXT_ALL, state = wxLIST_STATE_DONTCARE )
    long item
    int geometry
    int state

int
Wx_ListCtrl::GetSelectedItemCount()

Wx_Colour*
Wx_ListCtrl::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::GetTopItem()

void
Wx_ListCtrl::HitTest( point )
    Wx_Point point
  PREINIT:
    int flags;
    long item;
  PPCODE:
    item = THIS->HitTest( point, flags );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( item ) ) );
    PUSHs( sv_2mortal( newSViv( flags ) ) );

long
Wx_ListCtrl::InsertColumnInfo( col, info )
    int col
    Wx_ListItem* info
  CODE:
    RETVAL = THIS->InsertColumn( col, *info );
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::InsertColumnString( col, heading, format = wxLIST_FORMAT_LEFT, width = -1 )
    int col
    wxString heading
    int format
    int width
  CODE:
    RETVAL = THIS->InsertColumn( col, heading, format, width );
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::InsertItem( info )
    Wx_ListItem* info
  CODE:
    RETVAL = THIS->InsertItem( *info );
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::InsertStringItem( index, label )
    long index
    wxString label
  CODE:
    RETVAL = THIS->InsertItem( index, label );
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::InsertImageItem( index, image )
    long index
    int image
  CODE:
    RETVAL = THIS->InsertItem( index, image );
  OUTPUT:
    RETVAL

long
Wx_ListCtrl::InsertImageStringItem( index, label, image )
    long index
    wxString label
    int image
  CODE:
    RETVAL = THIS->InsertItem( index, label, image );
  OUTPUT: 
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

bool
Wx_ListCtrl::IsVirtual()

void
Wx_ListCtrl::RefreshItem( item )
    long item

void
Wx_ListCtrl::RefreshItems( itemFrom, itemTo )
    long itemFrom
    long itemTo

#endif

bool
Wx_ListCtrl::ScrollList( dx, dy )
    int dx
    int dy

bool
Wx_ListCtrl::SetColumn( col, item )
    int col
    Wx_ListItem* item
  CODE:
    RETVAL = THIS->SetColumn( col, *item );
  OUTPUT:
    RETVAL

bool
Wx_ListCtrl::SetColumnWidth( col, width )
    int col
    int width

void
Wx_ListCtrl::SetImageList( imagelist, which )
    Wx_ImageList* imagelist
    int which

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

void
Wx_ListCtrl::SetItemCount( count )
    long count

#endif

bool
Wx_ListCtrl::SetItemInfo( info )
    Wx_ListItem* info
  CODE:
    RETVAL = THIS->SetItem( *info );
  OUTPUT:
    RETVAL

bool
Wx_ListCtrl::SetItemString( index, col, label, image = -1 )
    long index
    int col
    wxString label
    int image
  CODE:
    RETVAL = THIS->SetItem( index, col, label, image );
  OUTPUT:
    RETVAL

bool
Wx_ListCtrl::SetItemData( item, data )
    long item
    long data

bool
Wx_ListCtrl::SetItemImage( item, image, selImage )
    long item
    int image
    int selImage

bool
Wx_ListCtrl::SetItemPosition( item, pos )
    long item
    Wx_Point pos

bool
Wx_ListCtrl::SetItemState( item, state, stateMask )
    long item
    long state
    long stateMask

void
Wx_ListCtrl::SetItemText( item, text )
    long item
    wxString text

void
Wx_ListCtrl::SetSingleStyle( style, add = TRUE )
    long style
    bool add

void
Wx_ListCtrl::SetTextColour( colour )
    Wx_Colour colour

void
Wx_ListCtrl::SetWindowStyleFlag( style )
    long style

bool
Wx_ListCtrl::SortItems( function )
    SV* function
  CODE:
    RETVAL = THIS->SortItems( (wxListCtrlCompare)&ListCtrlCompareFn,
        (long)function );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::ListView

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

Wx_ListView*
Wx_ListView::new( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_REPORT, validator = (wxValidator*)&wxDefaultValidator, name = "listCtrl" )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new wxPliListView( CLASS, parent, id, pos, size, style,
        *validator, name );
  OUTPUT:
    RETVAL

void
Wx_ListView::Select( n, on )
    long n
    bool on

void
Wx_ListView::SetColumnImage( col, image )
    int col
    int image

void
Wx_ListView::ClearColumnImage( col )
    int col

void
Wx_ListView::Focus( index )
    long index

long
Wx_ListView::GetFocusedItem()

long
Wx_ListView::GetFirstSelected()

long
Wx_ListView::GetNextSelected( item )
    long item

bool
Wx_ListView::IsSelected( index )
    long index

#endif
