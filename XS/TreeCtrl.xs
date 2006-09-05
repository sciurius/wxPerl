#############################################################################
## Name:        XS/TreeCtrl.xs
## Purpose:     XS for Wx::TreeCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     04/02/2001
## RCS-ID:      $Id: TreeCtrl.xs,v 1.31 2006/09/05 10:24:29 netcon Exp $
## Copyright:   (c) 2001-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/treectrl.h>
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::TreeItemData

wxTreeItemData*
wxPliTreeItemData::new( data = 0 )
    SV_null* data
  CODE:
    RETVAL = new wxPliTreeItemData( data );
  OUTPUT:
    RETVAL

void
wxTreeItemData::Destroy()
  CODE:
    delete THIS;

SV_null*
wxTreeItemData::GetData()
  CODE:
    RETVAL = ((wxPliTreeItemData*)THIS)->m_data;
  OUTPUT:
    RETVAL

void
wxTreeItemData::SetData( data = 0 )
    SV_null* data
  CODE:
    ((wxPliTreeItemData*)THIS)->SetData( data );

wxTreeItemId*
wxTreeItemData::GetId()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetId() );
  OUTPUT:
    RETVAL

void
wxTreeItemData::SetId( id )
    wxTreeItemId* id
  C_ARGS: *id

MODULE=Wx PACKAGE=Wx::TreeItemId

## // thread KO
void
wxTreeItemId::DESTROY()

bool
wxTreeItemId::IsOk()

int
tiid_spaceship( tid1, tid2, ... )
    SV* tid1
    SV* tid2
  CODE:
    // this is not a proper spaceship method
    // it just allows autogeneration of != and ==
    // anyway, comparing ids is useless
    RETVAL = -1;
    if( SvROK( tid1 ) && SvROK( tid2 ) &&
        sv_derived_from( tid1, CHAR_P "Wx::TreeItemId" ) &&
        sv_derived_from( tid2, CHAR_P "Wx::TreeItemId" ) )
    {
        wxTreeItemId* id1 = (wxTreeItemId*)
            wxPli_sv_2_object( aTHX_ tid1, "Wx::TreeItemId" );
        wxTreeItemId* id2 = (wxTreeItemId*)
            wxPli_sv_2_object( aTHX_ tid2, "Wx::TreeItemId" );

        RETVAL = *id1 == *id2 ? 0 : 1;
    } else
      RETVAL = 1;
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::TreeEvent

wxTreeEvent*
wxTreeEvent::new( commandType = wxEVT_NULL, id = 0 )
    wxEventType commandType
    int id

wxTreeItemId*
wxTreeEvent::GetItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetItem() );
  OUTPUT:
    RETVAL

int
wxTreeEvent::GetKeyCode()

wxTreeItemId*
wxTreeEvent::GetOldItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetOldItem() );
  OUTPUT:
    RETVAL

wxPoint*
wxTreeEvent::GetPoint()
  CODE:
    RETVAL = new wxPoint( THIS->GetPoint() );
  OUTPUT:
    RETVAL

bool
wxTreeEvent::IsEditCancelled()

wxString
wxTreeEvent::GetLabel()

MODULE=Wx PACKAGE=Wx::TreeCtrl

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::TreeCtrl::new" )

wxTreeCtrl*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliTreeCtrl( CLASS );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxTreeCtrl*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTR_HAS_BUTTONS, validator = (wxValidator*)&wxDefaultValidator, name = wxT("treeCtrl") )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxPliTreeCtrl( CLASS, parent, id, pos, size,
        style, *validator, name );
  OUTPUT:
    RETVAL

bool
wxTreeCtrl::Create( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTR_HAS_BUTTONS, validator = (wxValidator*)&wxDefaultValidator, name = wxT("treeCtrl") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, pos, size, style, *validator, name

wxTreeItemId*
wxTreeCtrl::AddRoot( text, image = -1, selImage = -1, data = 0 )
    wxString text
    int image
    int selImage
    wxTreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->AddRoot( text, image, selImage, data ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeCtrl::AppendItem( parent, text, image = -1, selImage = -1, data = 0 )
    wxTreeItemId* parent
    wxString text
    int image
    int selImage
    wxTreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->AppendItem( *parent, text, image,
        selImage, data ) );
  OUTPUT:
    RETVAL

void
wxTreeCtrl::Collapse( item )
    wxTreeItemId* item
  CODE:
    THIS->Collapse( *item );

void
wxTreeCtrl::CollapseAndReset( item )
    wxTreeItemId* item
  C_ARGS: *item

void
wxTreeCtrl::Delete( item )
    wxTreeItemId* item
  C_ARGS: *item

void
wxTreeCtrl::DeleteChildren( item )
    wxTreeItemId* item;
  C_ARGS: *item

void
wxTreeCtrl::DeleteAllItems()

void
wxTreeCtrl::EditLabel( item )
    wxTreeItemId* item
  CODE:
    THIS->EditLabel( *item );

#if defined( __WXMSW__ )

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxTreeCtrl::EndEditLabel( item, discardChanges = false )
    wxTreeItemId* item
    bool discardChanges
  C_ARGS: *item, discardChanges

#else

void
wxTreeCtrl::EndEditLabel( cancelEdit )
    bool cancelEdit

#endif

#endif

void
wxTreeCtrl::EnsureVisible( item )
    wxTreeItemId* item
  C_ARGS: *item

void
wxTreeCtrl::Expand( item )
    wxTreeItemId* item
  C_ARGS: *item

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

void
wxTreeCtrl::ExpandAllChildren( item )
    wxTreeItemId* item
  C_ARGS: *item

#endif

void
wxTreeCtrl::GetBoundingRect( item, textOnly = false )
    wxTreeItemId* item
    bool textOnly
  PREINIT:
    wxRect rect;
  PPCODE:
    bool ret = THIS->GetBoundingRect( *item, rect, textOnly );
    if( ret )
    {
        SV* ret = sv_newmortal();
        wxPli_non_object_2_sv( aTHX_ ret, new wxRect( rect ), "Wx::Rect" );
        XPUSHs( ret );
    }
    else
    {
        XSRETURN_UNDEF;
    }

size_t
wxTreeCtrl::GetChildrenCount( item, recursively = true )
    wxTreeItemId* item
    bool recursively
  C_ARGS: *item, recursively

int
wxTreeCtrl::GetCount()

wxTreeItemData*
wxTreeCtrl::GetItemData( item )
    wxTreeItemId* item
  CODE:
    RETVAL = (wxPliTreeItemData*) THIS->GetItemData( *item );
  OUTPUT:
    RETVAL

SV_null*
wxTreeCtrl::GetPlData( item )
    wxTreeItemId* item
  CODE:
    wxPliTreeItemData* data = (wxPliTreeItemData*) THIS->GetItemData( *item );
    RETVAL = data ? data->m_data : 0;
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

wxTextCtrl*
wxTreeCtrl::GetEditControl()

#endif

void
wxTreeCtrl::GetFirstChild( item )
    wxTreeItemId* item
  PREINIT:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    void* cookie;
#else
    long cookie;
#endif
  PPCODE:
    wxTreeItemId ret = THIS->GetFirstChild( *item, cookie );
#if !WXPERL_W_VERSION_GE( 2, 5, 1 )
    if( !ret.IsOk() ) cookie = -1;
#endif
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    PUSHs( sv_2mortal( newSViv( PTR2IV( cookie ) ) ) );
#else
    PUSHs( sv_2mortal( newSViv( cookie ) ) );
#endif

wxTreeItemId*
wxTreeCtrl::GetFirstVisibleItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetFirstVisibleItem() );
  OUTPUT:
    RETVAL

wxImageList*
wxTreeCtrl::GetImageList()
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );

int
wxTreeCtrl::GetIndent()

int
wxTreeCtrl::GetItemImage( item, which = wxTreeItemIcon_Normal )
    wxTreeItemId* item
    wxTreeItemIcon which
  C_ARGS: *item, which

wxString
wxTreeCtrl::GetItemText( item )
    wxTreeItemId* item
  C_ARGS: *item

wxTreeItemId*
wxTreeCtrl::GetLastChild( item )
    wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetLastChild( *item ) );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxTreeCtrl::GetNextChild( item, cookie )
    wxTreeItemId* item
    IV cookie
  PREINIT:
    void* realcookie = INT2PTR( void*, cookie );
  PPCODE:
    wxTreeItemId ret = THIS->GetNextChild( *item, realcookie );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( PTR2IV( realcookie ) ) ) );

#else

void
wxTreeCtrl::GetNextChild( item, cookie )
    wxTreeItemId* item
    long cookie
  PPCODE:
    wxTreeItemId ret = THIS->GetNextChild( *item, cookie );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( cookie ) ) );

#endif

wxTreeItemId*
wxTreeCtrl::GetNextSibling( item )
    wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetNextSibling( *item ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeCtrl::GetNextVisible( item )
    wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetNextVisible( *item ) );
  OUTPUT:
    RETVAL

## DECLARE_OVERLOAD( wtid, Wx::TreeItemId )

void
wxTreeCtrl::GetParent( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( Wx::Window::GetParent )
        MATCH_REDISP( wxPliOvl_wtid, GetItemParent )
    END_OVERLOAD( Wx::TreeCtrl::GetParent )

wxTreeItemId*
wxTreeCtrl::GetItemParent( item )
    wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( 
       THIS->GetItemParent( *item )
     );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeCtrl::GetPrevSibling( item )
    wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetPrevSibling( *item ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeCtrl::GetPrevVisible( item )
    wxTreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetPrevVisible( *item ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeCtrl::GetRootItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetRootItem() );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeCtrl::GetSelection()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetSelection() );
  OUTPUT:
    RETVAL

void
wxTreeCtrl::GetSelections()
  PREINIT:
    wxArrayTreeItemIds selections;
  PPCODE:
    size_t num = THIS->GetSelections( selections );
    EXTEND( SP, (IV)num );
    for( size_t i = 0; i < num; ++i )
    {
        PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                      new wxTreeItemId( selections[i] ),
                                      "Wx::TreeItemId" ) );
    }

wxImageList*
wxTreeCtrl::GetStateImageList()
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );

void
wxTreeCtrl::HitTest( point )
    wxPoint point
  PREINIT:
    int flags;
  PPCODE:
    wxTreeItemId ret = THIS->HitTest( point, flags );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( flags ) ) );

void
wxTreeCtrl::InsertItem( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wtid_wtid_s_n_n, InsertItemPrev, 3 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wtid_n_s_n_n, InsertItemBef, 3 )
    END_OVERLOAD( Wx::TreeCtrl::InsertItem )

wxTreeItemId*
wxTreeCtrl::InsertItemPrev( parent, previous, text, image = -1, selImage = -1, data = 0 )
    wxTreeItemId* parent
    wxTreeItemId* previous
    wxString text
    int image
    int selImage
    wxTreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->InsertItem( *parent, *previous, text,
                image, selImage, data ) );
  OUTPUT:
    RETVAL

wxTreeItemId*
wxTreeCtrl::InsertItemBef( parent, before, text, image = -1, selImage = -1, data = 0 )
    wxTreeItemId* parent
    size_t before
    wxString text
    int image
    int selImage
    wxTreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->InsertItem( *parent, before, text,
                image, selImage, data ) );
  OUTPUT:
    RETVAL

bool
wxTreeCtrl::IsBold( item )
    wxTreeItemId* item
  C_ARGS: *item

bool
wxTreeCtrl::IsExpanded( item )
    wxTreeItemId* item
  C_ARGS: *item

bool
wxTreeCtrl::IsSelected( item )
    wxTreeItemId* item
  C_ARGS: *item

bool
wxTreeCtrl::IsVisible( item )
    wxTreeItemId* item
  C_ARGS: *item

bool
wxTreeCtrl::ItemHasChildren( item )
    wxTreeItemId* item
  C_ARGS: *item

int
wxTreeCtrl::OnCompareItems( item1, item2 )
    wxTreeItemId* item1
    wxTreeItemId* item2
  CODE:
    RETVAL = THIS->wxTreeCtrl::OnCompareItems( *item1, *item2 );
  OUTPUT: RETVAL

wxTreeItemId*
wxTreeCtrl::PrependItem( parent, text, image = -1, selImage = -1, data = 0 )
    wxTreeItemId* parent
    wxString text
    int image
    int selImage
    wxTreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->PrependItem( *parent, text, image,
         selImage, data ) );
  OUTPUT:
    RETVAL

void
wxTreeCtrl::ScrollTo( item )
    wxTreeItemId* item
  C_ARGS: *item

#if WXPERL_W_VERSION_GE( 2, 5, 2 )

void
wxTreeCtrl::SelectItem( item, select = true )
    wxTreeItemId* item
    bool select
  C_ARGS: *item, select

#else

void
wxTreeCtrl::SelectItem( item )
    wxTreeItemId* item
  C_ARGS: *item

#endif

void
wxTreeCtrl::SetIndent( indent )
    int indent

void
wxTreeCtrl::SetImageList( list )
    wxImageList* list

void
wxTreeCtrl::SetItemBackgroundColour( item, col )
    wxTreeItemId* item
    wxColour col
  C_ARGS: *item, col

void
wxTreeCtrl::SetItemBold( item, bold = true )
    wxTreeItemId* item
    bool bold
  C_ARGS: *item, bold

void
wxTreeCtrl::SetItemData( item, data )
    wxTreeItemId* item
    wxTreeItemData* data
  CODE:
    wxTreeItemData* tid = THIS->GetItemData( *item );
    if( tid ) delete tid;
    THIS->SetItemData( *item, data );

void
wxTreeCtrl::SetPlData( item, data )
    wxTreeItemId* item
    SV_null* data
  CODE:
    wxTreeItemData* tid = THIS->GetItemData( *item );
    if( tid ) delete tid;
    THIS->SetItemData( *item, data ? new wxPliTreeItemData( data ) : 0 );

#if defined( __WXMSW__ )

void
wxTreeCtrl::SetItemDropHighlight( item, highlight = true )
    wxTreeItemId* item
    bool highlight
  C_ARGS: *item, highlight

#endif

void
wxTreeCtrl::SetItemFont( item, font )
    wxTreeItemId* item
    wxFont* font
  C_ARGS: *item, *font

void
wxTreeCtrl::SetItemHasChildren( item, hasChildren = true )
    wxTreeItemId* item
    bool hasChildren
  C_ARGS: *item, hasChildren

void
wxTreeCtrl::SetItemImage( item, image, which = wxTreeItemIcon_Normal )
    wxTreeItemId* item
    int image
    wxTreeItemIcon which
  C_ARGS: *item, image, which

void
wxTreeCtrl::SetItemText( item, text )
    wxTreeItemId* item
    wxString text
  C_ARGS: *item, text

void
wxTreeCtrl::SetItemTextColour( item, col )
    wxTreeItemId* item
    wxColour col
  C_ARGS: *item, col

void
wxTreeCtrl::SetStateImageList( imagelist )
    wxImageList* imagelist

void
wxTreeCtrl::SortChildren( item )
    wxTreeItemId* item
  C_ARGS: *item

void
wxTreeCtrl::Toggle( item )
    wxTreeItemId* item
  C_ARGS: *item

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxTreeCtrl::UnselectItem( item )
    wxTreeItemId* item
  C_ARGS: *item

void
wxTreeCtrl::ToggleItemSelection( item )
    wxTreeItemId* item
  C_ARGS: *item

#endif

void
wxTreeCtrl::Unselect()

void
wxTreeCtrl::UnselectAll()
