#############################################################################
## Name:        XS/ListCtrl.xs
## Purpose:     XS for Wx::ListCtrl, Wx::ListItem
## Author:      Mattia Barbon
## Modified by:
## Created:     04/02/2001
## RCS-ID:      $Id: ListCtrl.xs,v 1.31 2004/02/28 22:59:06 mbarbon Exp $
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/colour.h>
#include <wx/listctrl.h>

MODULE=Wx_Evt PACKAGE=Wx::ListEvent

Wx_ListEvent*
Wx_ListEvent::new( eventType = wxEVT_NULL, id = 0 )
    wxEventType eventType
    int id

long
Wx_ListEvent::GetCacheFrom()

long
Wx_ListEvent::GetCacheTo()

long
Wx_ListEvent::GetIndex()

int
Wx_ListEvent::GetColumn()

int
Wx_ListEvent::GetKeyCode()

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
      text = *(Wx_Colour *) wxPli_sv_2_object( aTHX_ ST(1), "Wx::Colour" );
      back = *(Wx_Colour *) wxPli_sv_2_object( aTHX_ ST(2), "Wx::Colour" );
      font = (Wx_Font *) wxPli_sv_2_object( aTHX_ ST(3), "Wx::Font" );
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

MODULE=Wx PACKAGE=Wx::ListCtrl

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::ListCtrl::new" )

wxListCtrl*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliListCtrl( CLASS );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxListCtrl*
newFull( CLASS, parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_ICON, validator = (wxValidator*)&wxDefaultValidator, name = wxT("listCtrl") )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxPliListCtrl( CLASS, parent, id, pos, size, style,
        *validator, name );
  OUTPUT:
    RETVAL

bool
wxListCtrl::Create( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_ICON, validator = (wxValidator*)&wxDefaultValidator, name = wxT("listCtrl") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, pos, size, style, *validator, name

bool
wxListCtrl::Arrange( flag = wxLIST_ALIGN_DEFAULT )
    int flag

void
wxListCtrl::ClearAll()

bool
wxListCtrl::DeleteItem( item )
    long item

bool
wxListCtrl::DeleteAllItems()

bool
wxListCtrl::DeleteColumn( col )
    int col

void
wxListCtrl::EditLabel( item )
    long item

bool
wxListCtrl::EnsureVisible( item )
    long item

long
wxListCtrl::FindItem( start, str, partial = FALSE )
    long start
    wxString str
    bool partial
  CODE:
    RETVAL = THIS->FindItem( start, str, partial );
  OUTPUT:
    RETVAL

long
wxListCtrl::FindItemData( start, data )
    long start
    long data
  CODE:
    RETVAL = THIS->FindItem( start, data );
  OUTPUT:
    RETVAL

long
wxListCtrl::FindItemAtPos( start, pt, direction )
    long start
    wxPoint pt
    int direction
  CODE:
    RETVAL = THIS->FindItem( start, pt, direction );
  OUTPUT:
    RETVAL

wxListItem*
wxListCtrl::GetColumn( col )
    int col
  PREINIT:
    wxListItem item;
  CODE:
    item.SetMask( wxLIST_MASK_TEXT|wxLIST_MASK_IMAGE|wxLIST_MASK_FORMAT );
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
wxListCtrl::GetColumnCount()

int
wxListCtrl::GetColumnWidth( col )
    int col

int
wxListCtrl::GetCountPerPage()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

wxTextCtrl*
wxListCtrl::GetEditControl()

#endif

wxImageList*
wxListCtrl::GetImageList( which )
    int which
  CODE:
    RETVAL = (wxImageList*)THIS->GetImageList( which );
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), FALSE );

wxListItem*
wxListCtrl::GetItem( id, col = -1 )
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
wxListCtrl::GetItemData( item )
    long item

wxPoint*
wxListCtrl::GetItemPosition( item )
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

wxRect*
wxListCtrl::GetItemRect( item )
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
wxListCtrl::GetItemState( item, stateMask )
    long item
    long stateMask

int
wxListCtrl::GetItemCount()

#if WXPERL_W_VERSION_LE( 2, 5, 1 )

int
wxListCtrl::GetItemSpacing( isSmall )
    bool isSmall

#else

wxSize
wxListCtrl::GetItemSpacing()
  CODE:
    RETVAL = new wxSize( THIS->GetItemSpacing() );
  OUTPUT: RETVAL

#endif

wxString
wxListCtrl::GetItemText( item )
    long item

wxColour*
wxListCtrl::GetItemTextColour( item )
    long item
  CODE:
    RETVAL = new wxColour( THIS->GetItemTextColour( item ) );
  OUTPUT:
    RETVAL

wxColour*
wxListCtrl::GetItemBackgroundColour( item )
    long item
  CODE:
    RETVAL = new wxColour( THIS->GetItemBackgroundColour( item ) );
  OUTPUT:
    RETVAL

void
wxListCtrl::SetItemTextColour( item, colour )
    long item
    wxColour* colour
  CODE:
    THIS->SetItemTextColour( item, *colour );

void
wxListCtrl::SetItemBackgroundColour( item, colour )
    long item
    wxColour* colour
  CODE:
    THIS->SetItemBackgroundColour( item, *colour );

long
wxListCtrl::GetNextItem( item, geometry = wxLIST_NEXT_ALL, state = wxLIST_STATE_DONTCARE )
    long item
    int geometry
    int state

int
wxListCtrl::GetSelectedItemCount()

wxColour*
wxListCtrl::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

long
wxListCtrl::GetTopItem()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxRect*
wxListCtrl::GetViewRect()
  CODE:
    RETVAL = new wxRect( THIS->GetViewRect() );
  OUTPUT: RETVAL

#endif

void
wxListCtrl::HitTest( point )
    wxPoint point
  PREINIT:
    int flags;
    long item;
  PPCODE:
    item = THIS->HitTest( point, flags );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( item ) ) );
    PUSHs( sv_2mortal( newSViv( flags ) ) );

void
wxListCtrl::InsertColumn( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_wlci, InsertColumnInfo )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_s_n_n, InsertColumnString, 2 )
    END_OVERLOAD( Wx::ListCtrl::InsertColumn )

long
wxListCtrl::InsertColumnInfo( col, info )
    int col
    wxListItem* info
  CODE:
    RETVAL = THIS->InsertColumn( col, *info );
  OUTPUT:
    RETVAL

long
wxListCtrl::InsertColumnString( col, heading, format = wxLIST_FORMAT_LEFT, width = -1 )
    int col
    wxString heading
    int format
    int width
  CODE:
    RETVAL = THIS->InsertColumn( col, heading, format, width );
  OUTPUT:
    RETVAL

long
wxListCtrl::InsertItem( info )
    wxListItem* info
  CODE:
    RETVAL = THIS->InsertItem( *info );
  OUTPUT:
    RETVAL

long
wxListCtrl::InsertStringItem( index, label )
    long index
    wxString label
  CODE:
    RETVAL = THIS->InsertItem( index, label );
  OUTPUT:
    RETVAL

long
wxListCtrl::InsertImageItem( index, image )
    long index
    int image
  CODE:
    RETVAL = THIS->InsertItem( index, image );
  OUTPUT:
    RETVAL

long
wxListCtrl::InsertImageStringItem( index, label, image )
    long index
    wxString label
    int image
  CODE:
    RETVAL = THIS->InsertItem( index, label, image );
  OUTPUT: 
    RETVAL

bool
wxListCtrl::IsVirtual()

void
wxListCtrl::RefreshItem( item )
    long item

void
wxListCtrl::RefreshItems( itemFrom, itemTo )
    long itemFrom
    long itemTo

bool
wxListCtrl::ScrollList( dx, dy )
    int dx
    int dy

bool
wxListCtrl::SetColumn( col, item )
    int col
    wxListItem* item
  CODE:
    RETVAL = THIS->SetColumn( col, *item );
  OUTPUT:
    RETVAL

bool
wxListCtrl::SetColumnWidth( col, width )
    int col
    int width

void
wxListCtrl::SetImageList( imagelist, which )
    wxImageList* imagelist
    int which

void
wxListCtrl::SetItemCount( count )
    long count

void
wxListCtrl::SetItem( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wlci, SetItemInfo )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_s_n, SetItemString, 3 )
    END_OVERLOAD( Wx::ListCtrl::SetItem )

bool
wxListCtrl::SetItemInfo( info )
    wxListItem* info
  CODE:
    RETVAL = THIS->SetItem( *info );
  OUTPUT:
    RETVAL

bool
wxListCtrl::SetItemString( index, col, label, image = -1 )
    long index
    int col
    wxString label
    int image
  CODE:
    RETVAL = THIS->SetItem( index, col, label, image );
  OUTPUT:
    RETVAL

bool
wxListCtrl::SetItemData( item, data )
    long item
    long data

bool
wxListCtrl::SetItemImage( item, image, selImage )
    long item
    int image
    int selImage

bool
wxListCtrl::SetItemPosition( item, pos )
    long item
    wxPoint pos

bool
wxListCtrl::SetItemState( item, state, stateMask )
    long item
    long state
    long stateMask

void
wxListCtrl::SetItemText( item, text )
    long item
    wxString text

void
wxListCtrl::SetSingleStyle( style, add = TRUE )
    long style
    bool add

void
wxListCtrl::SetTextColour( colour )
    wxColour colour

void
wxListCtrl::SetWindowStyleFlag( style )
    long style

bool
wxListCtrl::SortItems( function )
    SV* function
  CODE:
    RETVAL = THIS->SortItems( (wxListCtrlCompare)&ListCtrlCompareFn,
        (long)function );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::ListView

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::ListView::new" )

wxListView*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxListView();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxListView*
newFull( CLASS, parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_REPORT, validator = (wxValidator*)&wxDefaultValidator, name = wxT("listCtrl") )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxListView( parent, id, pos, size, style,
        *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxListView::Create( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_REPORT, validator = (wxValidator*)&wxDefaultValidator, name = wxT("listCtrl") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, pos, size, style, *validator, name

void
wxListView::Select( n, on )
    long n
    bool on

void
wxListView::SetColumnImage( col, image )
    int col
    int image

void
wxListView::ClearColumnImage( col )
    int col

void
wxListView::Focus( index )
    long index

long
wxListView::GetFocusedItem()

long
wxListView::GetFirstSelected()

long
wxListView::GetNextSelected( item )
    long item

bool
wxListView::IsSelected( index )
    long index
