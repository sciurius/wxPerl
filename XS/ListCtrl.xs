#############################################################################
## Name:        XS/ListCtrl.xs
## Purpose:     XS for Wx::ListCtrl, Wx::ListItem
## Author:      Mattia Barbon
## Modified by:
## Created:     04/02/2001
## RCS-ID:      $Id: ListCtrl.xs,v 1.44 2007/03/25 10:31:23 mbarbon Exp $
## Copyright:   (c) 2001-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/colour.h>
#include <wx/listctrl.h>

#if WXPERL_W_VERSION_LT( 2, 6, 0 )
#define wxListCtrlNameStr wxT("listCtrl")
#endif

MODULE=Wx_Evt PACKAGE=Wx::ListEvent

wxListEvent*
wxListEvent::new( eventType = wxEVT_NULL, id = 0 )
    wxEventType eventType
    int id

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

bool
wxListEvent::IsEditCancelled()

#endif

long
wxListEvent::GetCacheFrom()

long
wxListEvent::GetCacheTo()

long
wxListEvent::GetIndex()

int
wxListEvent::GetColumn()

int
wxListEvent::GetKeyCode()

wxPoint*
wxListEvent::GetPoint()
  CODE:
    RETVAL = new wxPoint( THIS->GetPoint() );
  OUTPUT:
    RETVAL

wxString
wxListEvent::GetLabel()

wxString
wxListEvent::GetText()

int
wxListEvent::GetImage()

long
wxListEvent::GetData()

long
wxListEvent::GetMask()

wxListItem*
wxListEvent::GetItem()
  CODE:
    RETVAL = new wxListItem( THIS->GetItem() );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::ListItem

wxListItem*
wxListItem::new()

static void
wxListItem::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxListItem::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::ListItem", THIS, ST(0) );
    delete THIS;

void
wxListItem::Clear()

void
wxListItem::ClearAttributes()

void
wxListItem::SetMask( mask )
    long mask

void
wxListItem::SetId( id )
    long id

void
wxListItem::SetColumn( column )
    int column

void
wxListItem::SetState( state )
   long state

void
wxListItem::SetStateMask( stateMask )
    long stateMask

void
wxListItem::SetText( text )
    wxString text

void
wxListItem::SetImage( image )
     int image

void
wxListItem::SetData( data )
    long data

void
wxListItem::SetWidth( width )
    int width

void
wxListItem::SetAlign( align )
    wxListColumnFormat align

void
wxListItem::SetTextColour( colour )
    wxColour colour

void
wxListItem::SetBackgroundColour( colour )
    wxColour colour

void
wxListItem::SetFont( font )
    wxFont* font
  C_ARGS: *font

long
wxListItem::GetMask()

long
wxListItem::GetId()

int
wxListItem::GetColumn()

long
wxListItem::GetState()

wxString
wxListItem::GetText()

int
wxListItem::GetImage()

long
wxListItem::GetData()

int
wxListItem::GetWidth()

wxListColumnFormat
wxListItem::GetAlign()

wxColour*
wxListItem::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

wxColour*
wxListItem::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

wxFont*
wxListItem::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::ListItemAttr

wxListItemAttr*
wxListItemAttr::new( ... )
  CASE: items == 1
    CODE:
      RETVAL = new wxListItemAttr();
    OUTPUT:
      RETVAL
  CASE: items == 4
    INPUT:
      wxColour text = NO_INIT
      wxColour back = NO_INIT
      wxFont* font = NO_INIT
    CODE:
      text = *(wxColour *) wxPli_sv_2_object( aTHX_ ST(1), "Wx::Colour" );
      back = *(wxColour *) wxPli_sv_2_object( aTHX_ ST(2), "Wx::Colour" );
      font = (wxFont *) wxPli_sv_2_object( aTHX_ ST(3), "Wx::Font" );
      RETVAL = new wxListItemAttr( text, back, *font );
    OUTPUT:
      RETVAL
  CASE:
    CODE:
      croak( "Usage: Wx::ListItemAttr::new(THIS [, text, back, font ] )" );

static void
wxListItemAttr::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxListItemAttr::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::ListItemAttr", THIS, ST(0) );
    delete THIS;

void
wxListItemAttr::SetTextColour( text )
    wxColour text

void
wxListItemAttr::SetBackgroundColour( back )
    wxColour back

void
wxListItemAttr::SetFont( font )
    wxFont* font
  CODE:
    THIS->SetFont( *font );

bool
wxListItemAttr::HasTextColour()

bool
wxListItemAttr::HasBackgroundColour()

bool
wxListItemAttr::HasFont()

wxColour*
wxListItemAttr::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

wxColour*
wxListItemAttr::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

wxFont*
wxListItemAttr::GetFont()
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
newFull( CLASS, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_ICON, validator = (wxValidator*)&wxDefaultValidator, name = wxListCtrlNameStr )
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
wxListCtrl::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_ICON, validator = (wxValidator*)&wxDefaultValidator, name = wxListCtrlNameStr )
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
wxListCtrl::AssignImageList( imagelist, which )
    wxImageList* imagelist
    int which
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    THIS->AssignImageList( imagelist, which );

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
wxListCtrl::FindItem( start, str, partial = false )
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
    wxPli_object_set_deleteable( aTHX_ ST(0), false );

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
wxListCtrl::GetItemRect( item, code = wxLIST_RECT_BOUNDS )
    long item
    int code
  PREINIT:
    wxRect rect;
  CODE:
    if( THIS->GetItemRect( item, rect, code ) )
    {
        RETVAL = new wxRect( rect );
    }
    else
    {
        RETVAL = 0;
    }
  OUTPUT: RETVAL

#if WXPERL_W_VERSION_GE( 2, 7, 2 ) && defined(__WXMSW__)

wxRect*
wxListCtrl::GetSubItemRect( item, subItem, code = wxLIST_RECT_BOUNDS )
    long item
    long subItem
    int code
  PREINIT:
    wxRect rect;
  CODE:
    if( THIS->GetSubItemRect( item, subItem, rect, code ) )
    {
        RETVAL = new wxRect( rect );
    }
    else
    {
        RETVAL = 0;
    }
  OUTPUT: RETVAL

#endif

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

wxSize*
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
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
    long subitem;
#endif
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
    item = THIS->HitTest( point, flags, &subitem );
#else
    item = THIS->HitTest( point, flags );
#endif
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( item ) ) );
    PUSHs( sv_2mortal( newSViv( flags ) ) );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
    PUSHs( sv_2mortal( newSViv( subitem ) ) );
#endif

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

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

bool
wxListCtrl::SetItemColumnImage( item, column, image )
    long item
    long column
    int image

#endif

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
wxListCtrl::SetSingleStyle( style, add = true )
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
newFull( CLASS, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_REPORT, validator = (wxValidator*)&wxDefaultValidator, name = wxListCtrlNameStr )
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
wxListView::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLC_REPORT, validator = (wxValidator*)&wxDefaultValidator, name = wxListCtrlNameStr )
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
