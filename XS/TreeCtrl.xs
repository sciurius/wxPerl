#############################################################################
## Name:        XS/TreeCtrl.xs
## Purpose:     XS for Wx::TreeCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     04/02/2001
## RCS-ID:      $Id: TreeCtrl.xs,v 1.21 2003/08/16 21:26:28 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/treectrl.h>
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::TreeItemData

Wx_TreeItemData*
Wx_TreeItemData::new( data = 0 )
    SV_null* data
  CODE:
    RETVAL = new wxPliTreeItemData( data );
  OUTPUT:
    RETVAL

void
Wx_TreeItemData::Destroy()
  CODE:
    delete THIS;

SV_null*
Wx_TreeItemData::GetData()
  CODE:
    RETVAL = THIS->m_data;
  OUTPUT:
    RETVAL

void
Wx_TreeItemData::SetData( data = 0 )
    SV_null* data
  CODE:
    THIS->SetData( data );

Wx_TreeItemId*
Wx_TreeItemData::GetId()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetId() );
  OUTPUT:
    RETVAL

void
Wx_TreeItemData::SetId( id )
    Wx_TreeItemId* id
  CODE:
    THIS->SetId( *id );

MODULE=Wx PACKAGE=Wx::TreeItemId

void
Wx_TreeItemId::DESTROY()

bool
Wx_TreeItemId::IsOk()

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
        Wx_TreeItemId* id1 = (Wx_TreeItemId*)
            wxPli_sv_2_object( aTHX_ tid1, "Wx::TreeItemId" );
        Wx_TreeItemId* id2 = (Wx_TreeItemId*)
            wxPli_sv_2_object( aTHX_ tid2, "Wx::TreeItemId" );

        RETVAL = *id1 == *id2 ? 0 : 1;
    } else
      RETVAL = 1;
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::TreeEvent

Wx_TreeEvent*
Wx_TreeEvent::new( commandType = wxEVT_NULL, id = 0 )
    wxEventType commandType
    int id

Wx_TreeItemId*
Wx_TreeEvent::GetItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetItem() );
  OUTPUT:
    RETVAL

int
Wx_TreeEvent::GetKeyCode()

Wx_TreeItemId*
Wx_TreeEvent::GetOldItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetOldItem() );
  OUTPUT:
    RETVAL

Wx_Point*
Wx_TreeEvent::GetPoint()
  CODE:
    RETVAL = new wxPoint( THIS->GetPoint() );
  OUTPUT:
    RETVAL

bool
Wx_TreeEvent::IsEditCancelled()

wxString
Wx_TreeEvent::GetLabel()

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

Wx_TreeCtrl*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTR_HAS_BUTTONS, validator = (wxValidator*)&wxDefaultValidator, name = wxT("treeCtrl") )
    PlClassName CLASS
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
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

Wx_TreeItemId*
Wx_TreeCtrl::AddRoot( text, image = -1, selImage = -1, data = 0 )
    wxString text
    int image
    int selImage
    Wx_TreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->AddRoot( text, image, selImage, data ) );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::AppendItem( parent, text, image = -1, selImage = -1, data = 0 )
    Wx_TreeItemId* parent
    wxString text
    int image
    int selImage
    Wx_TreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->AppendItem( *parent, text, image,
        selImage, data ) );
  OUTPUT:
    RETVAL

void
Wx_TreeCtrl::Collapse( item )
    Wx_TreeItemId* item
  CODE:
    THIS->Collapse( *item );

void
Wx_TreeCtrl::CollapseAndReset( item )
    Wx_TreeItemId* item
  CODE:
    THIS->CollapseAndReset( *item );

void
Wx_TreeCtrl::Delete( item )
    Wx_TreeItemId* item
  CODE:
    THIS->Delete( *item );

void
wxTreeCtrl::DeleteChildren( item )
    wxTreeItemId* item;
  CODE:
    THIS->DeleteChildren( *item );

void
Wx_TreeCtrl::DeleteAllItems()

void
Wx_TreeCtrl::EditLabel( item )
    Wx_TreeItemId* item
  CODE:
    THIS->EditLabel( *item );

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_TreeCtrl::EndEditLabel( cancelEdit )
    bool cancelEdit

#endif

void
Wx_TreeCtrl::EnsureVisible( item )
    Wx_TreeItemId* item
  CODE:
    THIS->EnsureVisible( *item );

void
Wx_TreeCtrl::Expand( item )
    Wx_TreeItemId* item
  CODE:
    THIS->Expand( *item );

void
Wx_TreeCtrl::GetBoundingRect( item, textOnly = FALSE )
    Wx_TreeItemId* item
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
Wx_TreeCtrl::GetChildrenCount( item, recursively = TRUE )
    Wx_TreeItemId* item
    bool recursively
  CODE:
    RETVAL = THIS->GetChildrenCount( *item, recursively );
  OUTPUT:
    RETVAL

int
Wx_TreeCtrl::GetCount()

Wx_TreeItemData*
Wx_TreeCtrl::GetItemData( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = (wxPliTreeItemData*) THIS->GetItemData( *item );
  OUTPUT:
    RETVAL

SV_null*
Wx_TreeCtrl::GetPlData( item )
    Wx_TreeItemId* item
  CODE:
    wxPliTreeItemData* data = (wxPliTreeItemData*) THIS->GetItemData( *item );
    RETVAL = data ? data->m_data : 0;
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

Wx_TextCtrl*
Wx_TreeCtrl::GetEditControl()

#endif

void
Wx_TreeCtrl::GetFirstChild( item )
    Wx_TreeItemId* item
  PREINIT:
#if WXPERL_W_VERSION_GE( 2, 5, 0 )
    void* cookie;
#else
    long cookie;
#endif
  PPCODE:
    wxTreeItemId ret = THIS->GetFirstChild( *item, cookie );
#if !WXPERL_W_VERSION_GE( 2, 5, 0 )
    if( !ret.IsOk() ) cookie = -1;
#endif
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
#if WXPERL_W_VERSION_GE( 2, 5, 0 )
    PUSHs( sv_2mortal( newSViv( PTR2IV( cookie ) ) ) );
#else
    PUSHs( sv_2mortal( newSViv( cookie ) ) );
#endif

Wx_TreeItemId*
Wx_TreeCtrl::GetFirstVisibleItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetFirstVisibleItem() );
  OUTPUT:
    RETVAL

wxImageList*
wxTreeCtrl::GetImageList()
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), FALSE );

int
Wx_TreeCtrl::GetIndent()

int
Wx_TreeCtrl::GetItemImage( item, which = wxTreeItemIcon_Normal )
    Wx_TreeItemId* item
    wxTreeItemIcon which
  CODE:
    RETVAL = THIS->GetItemImage( *item, which );
  OUTPUT:
    RETVAL

wxString
Wx_TreeCtrl::GetItemText( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = THIS->GetItemText( *item );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::GetLastChild( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetLastChild( *item ) );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 0 )

void
Wx_TreeCtrl::GetNextChild( item, cookie )
    Wx_TreeItemId* item
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
Wx_TreeCtrl::GetNextChild( item, cookie )
    Wx_TreeItemId* item
    long cookie
  PPCODE:
    wxTreeItemId ret = THIS->GetNextChild( *item, cookie );
    EXTEND( SP, 2 );
    PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                  new wxTreeItemId( ret ),
                                  "Wx::TreeItemId" ) );
    PUSHs( sv_2mortal( newSViv( cookie ) ) );

#endif

Wx_TreeItemId*
Wx_TreeCtrl::GetNextSibling( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetNextSibling( *item ) );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::GetNextVisible( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetNextVisible( *item ) );
  OUTPUT:
    RETVAL

void
wxTreeCtrl::GetParent( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( Wx::Window::GetParent )
        MATCH_REDISP( wxPliOvl_wtid, GetItemParent )
    END_OVERLOAD( Wx::TreeCtrl::GetParent )

Wx_TreeItemId*
Wx_TreeCtrl::GetItemParent( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( 
       THIS->GetItemParent( *item )
     );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::GetPrevSibling( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetPrevSibling( *item ) );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::GetPrevVisible( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetPrevVisible( *item ) );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::GetRootItem()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetRootItem() );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::GetSelection()
  CODE:
    RETVAL = new wxTreeItemId( THIS->GetSelection() );
  OUTPUT:
    RETVAL

void
Wx_TreeCtrl::GetSelections()
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
    wxPli_object_set_deleteable( aTHX_ ST(0), FALSE );

void
Wx_TreeCtrl::HitTest( point )
    Wx_Point point
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

Wx_TreeItemId*
Wx_TreeCtrl::InsertItemPrev( parent, previous, text, image = -1, selImage = -1, data = 0 )
    Wx_TreeItemId* parent
    Wx_TreeItemId* previous
    wxString text
    int image
    int selImage
    Wx_TreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->InsertItem( *parent, *previous, text,
                image, selImage, data ) );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::InsertItemBef( parent, before, text, image = -1, selImage = -1, data = 0 )
    Wx_TreeItemId* parent
    size_t before
    wxString text
    int image
    int selImage
    Wx_TreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->InsertItem( *parent, before, text,
                image, selImage, data ) );
  OUTPUT:
    RETVAL

bool
Wx_TreeCtrl::IsBold( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = THIS->IsBold( *item );
  OUTPUT:
    RETVAL

bool
Wx_TreeCtrl::IsExpanded( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = THIS->IsExpanded( *item );
  OUTPUT:
    RETVAL

bool
Wx_TreeCtrl::IsSelected( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = THIS->IsSelected( *item );
  OUTPUT:
    RETVAL

bool
Wx_TreeCtrl::IsVisible( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = THIS->IsVisible( *item );
  OUTPUT:
    RETVAL

bool
Wx_TreeCtrl::ItemHasChildren( item )
    Wx_TreeItemId* item
  CODE:
    RETVAL = THIS->ItemHasChildren( *item );
  OUTPUT:
    RETVAL

int
Wx_TreeCtrl::OnCompareItems( item1, item2 )
    Wx_TreeItemId* item1
    Wx_TreeItemId* item2
  CODE:
    RETVAL = THIS->wxTreeCtrl::OnCompareItems( *item1, *item2 );
  OUTPUT:
    RETVAL

Wx_TreeItemId*
Wx_TreeCtrl::PrependItem( parent, text, image = -1, selImage = -1, data = 0 )
    Wx_TreeItemId* parent
    wxString text
    int image
    int selImage
    Wx_TreeItemData* data
  CODE:
    RETVAL = new wxTreeItemId( THIS->PrependItem( *parent, text, image,
         selImage, data ) );
  OUTPUT:
    RETVAL

void
Wx_TreeCtrl::ScrollTo( item )
    Wx_TreeItemId* item
  CODE:
    THIS->ScrollTo( *item );

void
Wx_TreeCtrl::SelectItem( item )
    Wx_TreeItemId* item
  CODE:
    THIS->SelectItem( *item );

void
Wx_TreeCtrl::SetIndent( indent )
    int indent

void
Wx_TreeCtrl::SetImageList( list )
    Wx_ImageList* list

void
Wx_TreeCtrl::SetItemBackgroundColour( item, col )
    Wx_TreeItemId* item
    Wx_Colour col
  CODE:
    THIS->SetItemBackgroundColour( *item, col );

void
Wx_TreeCtrl::SetItemBold( item, bold = TRUE )
    Wx_TreeItemId* item
    bool bold
  CODE:
    THIS->SetItemBold( *item, bold );

void
Wx_TreeCtrl::SetItemData( item, data )
    Wx_TreeItemId* item
    Wx_TreeItemData* data
  CODE:
    wxTreeItemData* tid = THIS->GetItemData( *item );
    if( tid ) delete tid;
    THIS->SetItemData( *item, data );

void
Wx_TreeCtrl::SetPlData( item, data )
    Wx_TreeItemId* item
    SV_null* data
  CODE:
    wxTreeItemData* tid = THIS->GetItemData( *item );
    if( tid ) delete tid;
    THIS->SetItemData( *item, data ? new wxPliTreeItemData( data ) : 0 );

void
Wx_TreeCtrl::SetItemFont( item, font )
    Wx_TreeItemId* item
    Wx_Font* font
  CODE:
    THIS->SetItemFont( *item, *font );

void
Wx_TreeCtrl::SetItemHasChildren( item, hasChildren = TRUE )
    Wx_TreeItemId* item
    bool hasChildren
  CODE:
    THIS->SetItemHasChildren( *item, hasChildren );

void
Wx_TreeCtrl::SetItemImage( item, image, which = wxTreeItemIcon_Normal )
    Wx_TreeItemId* item
    int image
    wxTreeItemIcon which
  CODE:
    THIS->SetItemImage( *item, image, which );

void
Wx_TreeCtrl::SetItemText( item, text )
    Wx_TreeItemId* item
    wxString text
  CODE:
    THIS->SetItemText( *item, text );

void
Wx_TreeCtrl::SetItemTextColour( item, col )
    Wx_TreeItemId* item
    Wx_Colour col
  CODE:
    THIS->SetItemTextColour( *item, col );

void
Wx_TreeCtrl::SetStateImageList( imagelist )
    Wx_ImageList* imagelist

void
Wx_TreeCtrl::SortChildren( item )
    Wx_TreeItemId* item
  CODE:
    THIS->SortChildren( *item );

void
Wx_TreeCtrl::Toggle( item )
    Wx_TreeItemId* item
  CODE:
    THIS->Toggle( *item );

void
Wx_TreeCtrl::Unselect()

void
Wx_TreeCtrl::UnselectAll()
