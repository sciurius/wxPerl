#!/usr/bin/perl
#############################################################################
## Name:        listctrl.pl
## Purpose:     ListCtrl wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:      6/ 2/2001
## RCS-ID:      $Id: listctrl.pl,v 1.5 2003/05/04 17:35:18 mbarbon Exp $
## Copyright:   (c) 2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyFrame;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::Frame);

use Wx qw(:everything);

my( $id_about, $id_quit, $id_listctrl, $id_iconview , $id_listview,
    $id_reportview , $id_icontextview , $id_smalliconview,
    $id_smallicontextview , $id_togglefirst , $id_deselectall,
    $id_selectall , $id_showcolinfo , $id_sort , $id_deleteall,
    $id_togglemultisel , $id_setfgcol , $id_setbgcol ) = ( 1 .. 100 );

Wx::InitAllImageHandlers();

sub ICON($) {
  if( Wx::wxMSW() ) {
    Wx::Icon->new( "bitmaps/$_[0].ico", wxBITMAP_TYPE_ICO );
  } else {
    Wx::Icon->new( "bitmaps/$_[0].xpm", wxBITMAP_TYPE_XPM );
  }
}

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], [ @_[1, 2] ],
                                    [ @_[3, 4] ] );

  $this->SetIcon( Wx::GetWxPerlIcon() );

  $this->{IMAGELISTNORMAL} = Wx::ImageList->new( 32, 32, 1 );
  $this->{IMAGELISTSMALL} = Wx::ImageList->new( 16, 16, 1 );

  foreach ( qw(toolbrai toolchar tooldata toolnote tooltodo toolchec toolgame
               tooltime toolword) ) {
    $this->{IMAGELISTNORMAL}->Add( ICON( $_ ) );
  }

  $this->{IMAGELISTSMALL}->Add( Wx::GetWxPerlIcon( 1 ) );

  my( $file ) = Wx::Menu->new;
  $file->Append( $id_about, "&About" );
  $file->AppendSeparator;
  $file->Append( $id_quit, "E&xit\tAlt-X" );

  my( $view ) = Wx::Menu->new;
  $view->Append( $id_listview, "&List view\tF1" );
  $view->Append( $id_reportview, "&Report view\tF2" );
  $view->Append( $id_iconview, "&Icon view\tF3" );
  $view->Append( $id_icontextview, "Icon view with &text\tF4" );
  $view->Append( $id_smalliconview, "&Small icon view\tF6" );
  $view->Append( $id_smallicontextview, "&Small icon &view with text\tF7" );

  my( $list ) = Wx::Menu->new;
  $list->Append( $id_togglefirst, "&Toggle first item\tCtrl-T" );
  $list->Append( $id_deselectall, "&Deselect All\tCtrl-D" );
  $list->Append( $id_selectall, "S&elect All\tCtrl-A" );
  $list->Append( $id_showcolinfo, "Show &column info\tCtrl-C" );
  $list->AppendSeparator;
  $list->Append( $id_sort, "&Sort\tCtrl-S" );
  $list->AppendSeparator;
  $list->Append( $id_deleteall, "Delete &all items" );
  $list->AppendSeparator;
  $list->Append( $id_togglemultisel, "&Multiple selection\tCtrl-M",
                 "Toggle multiple selection", 1 );

  my( $col ) = Wx::Menu->new;
  $col->Append( $id_setfgcol, "&Foreground colour..." );
  $col->Append( $id_setbgcol, "&Background colour..." );

  my( $menubar ) = Wx::MenuBar->new;
  $menubar->Append( $file, "&File" );
  $menubar->Append( $view, "&View" );
  $menubar->Append( $list, "&List" );
  $menubar->Append( $col, "&Colour" );
  $this->SetMenuBar( $menubar );

  $this->{LISTCTRL} = MyListCtrl->new( $this, $id_listctrl, wxDefaultPosition,
                                       wxDefaultSize, wxLC_LIST|
                                       wxSUNKEN_BORDER|wxLC_EDIT_LABELS|
                                       wxLC_SINGLE_SEL );
  $this->{LOGWINDOW} = Wx::TextCtrl->new( $this, -1, '', wxDefaultPosition,
                                          wxDefaultSize, wxTE_MULTILINE|
                                          wxSUNKEN_BORDER );

  $this->{LOGOLD} = Wx::Log::SetActiveTarget
    ( Wx::LogTextCtrl->new( $this->{LOGWINDOW} ) );

  my( $topsizer ) = Wx::BoxSizer->new( wxVERTICAL );

  $topsizer->Add( $this->{LISTCTRL}, 2, wxGROW );
  $topsizer->Add( $this->{LOGWINDOW}, 1, wxGROW );
  $this->SetSizer( $topsizer );
  $this->SetAutoLayout( 1 );

  my( $idx );

  foreach my $i ( 0 .. 100 ) {
    $idx = $this->{LISTCTRL}->InsertStringImageItem( $i, "Item $i", $i );
    $this->{LISTCTRL}->SetItemData( $idx, $i * $i );
  }

  $this->CreateStatusBar( 3 );

  use Wx::Event qw(EVT_MENU EVT_UPDATE_UI);

  EVT_MENU( $this, $id_quit, \&OnQuit );
  EVT_MENU( $this, $id_about, \&OnAbout );
  EVT_MENU( $this, $id_listview, \&OnListView );
  EVT_MENU( $this, $id_reportview, \&OnReportView );
  EVT_MENU( $this, $id_iconview, \&OnIconView );
  EVT_MENU( $this, $id_icontextview, \&OnIconTextView );
  EVT_MENU( $this, $id_smalliconview, \&OnSmallIconView );
  EVT_MENU( $this, $id_smallicontextview, \&OnSmallIconTextView );
  EVT_MENU( $this, $id_togglefirst, \&OnToggleFirstSel );
  EVT_MENU( $this, $id_deselectall, \&OnDeselectAll );
  EVT_MENU( $this, $id_selectall, \&OnSelectAll );
  EVT_MENU( $this, $id_deleteall, \&OnDeleteAll );
  EVT_MENU( $this, $id_sort, \&OnSort );
  EVT_MENU( $this, $id_setfgcol, \&OnSetFgColour );
  EVT_MENU( $this, $id_setbgcol, \&OnSetBgColour );
  EVT_MENU( $this, $id_togglemultisel, \&OnToggleMultiSel );
  EVT_MENU( $this, $id_showcolinfo, \&OnShowColInfo );
  EVT_UPDATE_UI( $this, $id_showcolinfo, \&OnUpdateShowColInfo );

  $this;
}

sub DESTROY {
  my $this = shift;

  Wx::Log::SetActiveTarget( $this->{LOGOLD} )->Destroy;
}

sub OnQuit {
  $_[0]->Close( 1 );
}

sub OnAbout {
  my( $dialog ) = Wx::MessageDialog->new( $_[0], "ListCtrl sample",
                                          "About ListCtrl Sample", wxOK );

  $dialog->ShowModal;
  $dialog->Destroy;
}

sub OnToggleFirstSel {
  $_[0]->{LISTCTRL}->SetItemState( 0, wxLIST_STATE_SELECTED,
                                   wxLIST_STATE_SELECTED );
}

sub OnDeselectAll {
  my( $this, $event ) = @_;

  foreach ( 0 .. $this->{LISTCTRL}->GetItemCount - 1 ) {
    $this->{LISTCTRL}->SetItemState( $_, 0, wxLIST_STATE_SELECTED );
  }
}

sub OnSelectAll {
  my( $this, $event ) = @_;

  foreach ( 0 .. $this->{LISTCTRL}->GetItemCount - 1 ) {
    $this->{LISTCTRL}->SetItemState( $_, wxLIST_STATE_SELECTED,
                                     wxLIST_STATE_SELECTED );
  }
}

sub OnListView {
  my( $this, $event ) = @_;

  $this->{LOGWINDOW}->Clear;
  $this->{LISTCTRL}->ClearAll;

  $this->{LISTCTRL}->SetSingleStyle( wxLC_LIST );
  $this->{LISTCTRL}->SetImageList( undef, wxIMAGE_LIST_NORMAL );
  $this->{LISTCTRL}->SetImageList( undef, wxIMAGE_LIST_SMALL );

  foreach ( 1 .. 29 ) {
    $this->{LISTCTRL}->InsertStringItem( $_, "Item $_" );
  }
}

sub OnReportView {
  my( $this, $event ) = @_;

  $this->{LOGWINDOW}->Clear;
  $this->{LISTCTRL}->ClearAll;

  $this->{LISTCTRL}->SetSingleStyle( wxLC_REPORT );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTNORMAL}, wxIMAGE_LIST_NORMAL );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTSMALL}, wxIMAGE_LIST_SMALL );

  $this->{LISTCTRL}->InsertColumn( 0, "Column 1" );
  $this->{LISTCTRL}->InsertColumn( 1, "Column 2" );
  $this->{LISTCTRL}->InsertColumn( 2, "One more column" );

  # control hidden to speed up insertion
  $this->{LISTCTRL}->Show( 0 );

  my( $watch ) = Wx::StopWatch->new;

  $watch->Start;

  my( $id );
  my( $elements ) = 300;

  foreach ( 1 .. $elements - 1 ) {
    $id = $this->{LISTCTRL}->InsertStringImageItem( $_, "This is item $_", 0 );
    $this->{LISTCTRL}->SetItemData( $id, $_ );
    $this->{LISTCTRL}->SetItem( $id, 1, "Col 1, Item $_" );
    $this->{LISTCTRL}->SetItem( $id, 2, "Item $_ in column 2" );
  }

  Wx::LogMessage( "Inserted %d elements in %d milliseconds",
                  $elements, $watch->Time );

  $this->{LISTCTRL}->Show( 1 );

  my( $item ) = Wx::ListItem->new;
  $item->SetId( 0 );
  $item->SetTextColour( wxRED );
  $this->{LISTCTRL}->SetItem( $item );

  $item->SetId( 2 );
  $item->SetTextColour( wxGREEN );
  $this->{LISTCTRL}->SetItem( $item );

  $item->SetId( 4 );
  $item->SetTextColour( wxLIGHT_GREY );
  $item->SetFont( wxITALIC_FONT );
  $item->SetBackgroundColour( wxRED );
  $this->{LISTCTRL}->SetItem( $item );

  $this->{LISTCTRL}->SetTextColour( wxBLUE );
  $this->{LISTCTRL}->SetBackgroundColour( wxLIGHT_GREY );

  $this->{LISTCTRL}->SetColumnWidth( 0, wxLIST_AUTOSIZE );
  $this->{LISTCTRL}->SetColumnWidth( 1, wxLIST_AUTOSIZE );
  $this->{LISTCTRL}->SetColumnWidth( 2, wxLIST_AUTOSIZE );
}

sub OnIconView {
  my( $this, $event ) = @_;

  $this->{LOGWINDOW}->Clear;
  $this->{LISTCTRL}->ClearAll;

  $this->{LISTCTRL}->SetSingleStyle( wxLC_ICON );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTNORMAL}, wxIMAGE_LIST_NORMAL );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTSMALL}, wxIMAGE_LIST_SMALL );

  foreach ( 1 .. 8 ) {
    $this->{LISTCTRL}->InsertImageItem( $_, $_ );
  }
}

sub OnIconTextView {
  my( $this, $event ) = @_;

  $this->{LOGWINDOW}->Clear();
  $this->{LISTCTRL}->ClearAll();

  $this->{LISTCTRL}->SetSingleStyle( wxLC_ICON );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTNORMAL}, wxIMAGE_LIST_NORMAL );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTSMALL}, wxIMAGE_LIST_SMALL );

  foreach ( 1 .. 8 ) {
    $this->{LISTCTRL}->InsertStringImageItem( $_, "Label $_", $_ );
  }
}

sub OnSmallIconView {
  my( $this, $event ) = @_;

  $this->{LOGWINDOW}->Clear;
  $this->{LISTCTRL}->ClearAll;

  $this->{LISTCTRL}->SetSingleStyle( wxLC_SMALL_ICON );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTNORMAL}, wxIMAGE_LIST_NORMAL );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTSMALL}, wxIMAGE_LIST_SMALL );

  foreach ( 0 .. 8 ) {
    $this->{LISTCTRL}->InsertImageItem( $_, 0 );
  }
}

sub OnSmallIconTextView {
  my( $this, $event ) = @_;

  $this->{LOGWINDOW}->Clear;
  $this->{LISTCTRL}->ClearAll;

  $this->{LISTCTRL}->SetSingleStyle( wxLC_SMALL_ICON );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTNORMAL}, wxIMAGE_LIST_NORMAL );
  $this->{LISTCTRL}->SetImageList( $this->{IMAGELISTSMALL}, wxIMAGE_LIST_SMALL );

  foreach ( 0 .. 8 ) {
    $this->{LISTCTRL}->InsertImageStringItem( $_, "Label $_", 0 );
  }
}

sub OnShowColInfo {
  my( $this, $event ) = @_;
  my( $n ) = $this->{LISTCTRL}->GetColumnCount;

  Wx::LogMessage( "$n columns:" );
  foreach ( 0 .. $n - 1 ) {
    Wx::LogMessage( "\t column %d has width %d", $_,
                    $this->{LISTCTRL}->GetColumnWidth( $_ ) );
  }
}

sub OnUpdateShowColInfo {
  my( $this, $event ) = @_;

  $event->Enable( $this->{LISTCTRL}->GetWindowStyleFlag & wxLC_REPORT );
}

sub Cmp { $_[0] < $_[1] };

sub OnSort {
  my( $this ) = @_;

  $this->{LISTCTRL}->SortItems( \&Cmp );
}

sub OnToggleMultiSel {
  my( $this, $event ) = @_;

  $this->{LOGWINDOW}->WriteText( "Current selection mode: " );
  my( $flag ) = $this->{LISTCTRL}->GetWindowStyleFlag;

  if( $flag & wxLC_SINGLE_SEL ) {
    $this->{LISTCTRL}->SetWindowStyleFlag( $flag & ~wxLC_SINGLE_SEL );
    $this->{LOGWINDOW}->WriteText( "multiple" );
  } else {
    $this->{LISTCTRL}->SetWindowStyleFlag( $flag | wxLC_SINGLE_SEL );
    $this->{LOGWINDOW}->WriteText( "single" );
  }

  $this->{LOGWINDOW}->WriteText( "\nRecreate the control now\n" );
}

sub OnDeleteAll {
  my( $this, $event ) = @_;

  my( $watch ) = Wx::StopWatch->new;

  $this->{LISTCTRL}->DeleteAllItems;

  Wx::LogMessage( "Deleted all items in %d milliseconds",
                  $watch->Time() );
}

sub OnSetFgColour {
  my( $this, $event ) = @_;

  $this->{LISTCTRL}->SetForegroundColour( Wx::GetColourFromUser( $this ) );
  $this->{LISTCTRL}->Refresh();
}

sub OnSetBgColour {
  my( $this, $event ) = @_;

  $this->{LISTCTRL}->SetBackgroundColour( Wx::GetColourFromUser( $this ) );
  $this->{LISTCTRL}->Refresh();
}

package MyListCtrl;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::ListCtrl);

use Wx::Event qw{EVT_LIST_BEGIN_DRAG EVT_LIST_BEGIN_RDRAG
  EVT_LIST_BEGIN_LABEL_EDIT EVT_LIST_END_LABEL_EDIT EVT_LIST_DELETE_ITEM
  EVT_LIST_DELETE_ALL_ITEMS EVT_LIST_GET_INFO EVT_LIST_SET_INFO
  EVT_LIST_ITEM_SELECTED EVT_LIST_ITEM_DESELECTED EVT_LIST_KEY_DOWN
  EVT_LIST_ITEM_ACTIVATED EVT_LIST_COL_CLICK EVT_CHAR};

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( @_ );

  EVT_LIST_BEGIN_DRAG( $this, $this, \&OnBeginDrag);
  EVT_LIST_BEGIN_RDRAG( $this, $this, \&OnBeginRDrag );
  EVT_LIST_BEGIN_LABEL_EDIT( $this, $this, \&OnBeginLabelEdit );
  EVT_LIST_END_LABEL_EDIT( $this, $this, \&OnEndLabelEdit );
  EVT_LIST_DELETE_ITEM( $this, $this, \&OnDeleteItem );
  EVT_LIST_DELETE_ALL_ITEMS( $this, $this, \&OnDeleteAllItems );
  EVT_LIST_GET_INFO( $this, $this, \&OnGetInfo );
  EVT_LIST_SET_INFO( $this, $this, \&OnSetInfo );
  EVT_LIST_ITEM_SELECTED( $this, $this, \&OnSelected );
  EVT_LIST_ITEM_DESELECTED( $this, $this, \&OnDeselected );
  EVT_LIST_KEY_DOWN( $this, $this, \&OnListKeyDown );
  EVT_LIST_ITEM_ACTIVATED( $this, $this, \&OnActivated );
  EVT_LIST_COL_CLICK( $this, $this, \&OnColClick );
  EVT_CHAR( $this, \&OnChar );

  $this
}

sub OnColClick {
  my( $this, $event ) = @_;

  Wx::LogMessage( "OnClumnClick at %d.", $event->GetColumn );
}

sub OnBeginDrag {
  my( $this, $event ) = @_;

  Wx::LogMessage( "OnBeginDrag ad ( %d, %d ).",
                  $event->GetPoint->x,
                  $event->GetPoint->y );
}

sub OnBeginRDrag {
  my( $this, $event ) = @_;

  Wx::LogMessage( "OnBeginRDrag ad ( %d, %d ).",
                  $event->GetPoint->x,
                  $event->GetPoint->y );
}

sub OnBeginLabelEdit {
  my( $this, $event ) = @_;

  Wx::LogMessage( "OnBeginLabelEdit: %s",
                  $event->GetItem->GetText );
}

sub OnEndLabelEdit {
  my( $this, $event ) = @_;


  Wx::LogMessage( "OnBeginLabelEdit: %s",
                  $event->GetItem->GetText );
}

sub OnDeleteItem {
  my( $this, $event ) = @_;

  $this->LogEvent( $event, "OnDeleteItem" );
}

sub OnDeleteAllItems {
  my( $this, $event ) = @_;

  $this->LogEvent( $event, "OnDeleteAllItems" );
}

use Wx qw(:listctrl);

sub OnGetInfo {
  my( $this, $event ) = @_;
  my( $item ) = $event->GetItem;
  my( $mask ) = $item->GetMask;
  my( $msg );

  $msg = sprintf "OnGetInfo( %d, %d )", $item->GetId, $item->GetColumn;
  $mask & wxLIST_MASK_STATE and $msg .= " wxLIST_MASK_STATE";
  $mask & wxLIST_MASK_TEXT  and $msg .= " wxLIST_MASK_TEXT";
  $mask & wxLIST_MASK_IMAGE and $msg .= " wxLIST_MASK_IMAGE";
  $mask & wxLIST_MASK_DATA  and $msg .= " wxLIST_MASK_DATA";
  $mask & wxLIST_SET_ITEM   and $msg .= " wxLIST_SET_ITEM";
  $mask & wxLIST_MASK_WIDTH and $msg .= " wxLIST_MASK_WIDTH";
  $mask & wxLIST_MASK_FORMAT and $msg .= " wxLIST_MASK_FORMAT";

  Wx::LogMessage( $msg );
}

sub OnSetInfo {
  $_[0]->LogEvent( $_[1], "OnSetInfo" );
}

sub OnSelected {
  my( $this, $event ) = @_;

  $this->LogEvent( $event, "OnSelected" );

  if( $this->GetWindowStyleFlag && wxLC_REPORT ) {
    my( $info );

    if( $info = ( $this->GetItem( $event->GetIndex, 1 ) ) ) {
      Wx::LogMessage( "Value of the second field of the selected item: %s",
                      $info->GetText );
    } else {
      #die;
    }
  }
}

sub OnDeselected {
  $_[0]->LogEvent( $_[1], "OnDeselected" );
}

sub OnActivated {
  $_[0]->LogEvent( $_[1], "OnActivated" );
}

sub OnListKeyDown {
  my( $this, $event ) = @_;

  $this->LogEvent( $event, "OnListKeyDown" );
  $event->Skip;
}

sub OnChar {
  my( $this, $event ) = @_;

  Wx::LogMessage( "OnChar" );
  $event->Skip;
}

sub LogEvent {
  my( $this, $event, $name ) = @_;

  Wx::LogMessage( "Item %d: %s ( item text = %s, data = %d )",
                  $event->GetIndex, $name,
                  $event->GetText, $event->GetData );
}

package MyApp;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::App);

sub OnInit {
  my( $this ) = @_;
  my( $frame ) = MyFrame->new( 'wxPerl ListCtrl Test', 50, 50, 450, 340 );

  $frame->Show( 1 );

  $this->SetTopWindow( $frame );

  1;
}

package main;

my( $app ) = MyApp->new;
$app->MainLoop;

# Local variables: #
# mode: cperl #
# End: #

