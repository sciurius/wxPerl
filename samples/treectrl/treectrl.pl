#!/usr/bin/perl
#############################################################################
## Name:        samples/treectrl/treectrl.pl
## Purpose:     TreeCtrl wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     17/02/2001
## RCS-ID:      $Id: treectrl.pl,v 1.4 2004/10/19 20:28:15 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyFrame;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::Frame);

my( $ID_ABOUT, $ID_QUIT, $ID_RENAME, $ID_SELECT, $ID_DESELECT, $ID_DESELECTALL,
    $ID_ASCENDING, $ID_DESCENDING, $ID_TRAVERSE, $ID_TOGGLE_MULTI ) =
  ( 1 .. 100 );

use Wx qw(:treectrl :window :textctrl :sizer
          wxDefaultPosition wxDefaultSize);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, $_[0], [ @_[1, 2] ],
                                 [ @_[3, 4] ] );

  $this->SetIcon( Wx::GetWxPerlIcon() );

  my $sizer = Wx::BoxSizer->new( wxVERTICAL );

  $this->{TREECTRL} =
    MyTreeCtrl->new( $this, -1, wxDefaultPosition, wxDefaultSize,
                     wxTR_HAS_BUTTONS|wxTR_EDIT_LABELS|wxSUNKEN_BORDER );

  $this->{TEXTCTRL} =
    Wx::TextCtrl->new( $this, -1, '', wxDefaultPosition, wxDefaultSize,
                       wxTE_MULTILINE|wxSUNKEN_BORDER );

  $sizer->Add( $this->{TREECTRL}, 2, wxGROW );
  $sizer->Add( $this->{TEXTCTRL}, 1, wxGROW );

  $this->SetSizer( $sizer );
  $this->SetAutoLayout( 1 );

  $this->CreateStatusBar( 3 );

  $this->{OLDLOG} = Wx::Log::SetActiveTarget
    ( Wx::LogTextCtrl->new( $this->{TEXTCTRL} ) );

  my $file = Wx::Menu->new;
  $file->Append( $ID_ABOUT, "&About" );
  $file->AppendSeparator;
  $file->Append( $ID_QUIT, "E&xit" );

  my $tree = Wx::Menu->new;
  $tree->Append( $ID_TRAVERSE, "Traverse" );
  $tree->Append( $ID_TOGGLE_MULTI, "Toggle Multiple Selection", '', 1 );

  my $item = Wx::Menu->new;
  $item->Append( $ID_RENAME, "Rename" );
  $item->Append( $ID_ASCENDING, "Sort childs Ascending" );
  $item->Append( $ID_DESCENDING, "Sort childs Descending" );
  $item->AppendSeparator;
  $item->Append( $ID_SELECT, "Select" );
  $item->Append( $ID_DESELECT, "Deselect" );
  $item->Append( $ID_DESELECTALL, "Deslect All" );

  my $bar = Wx::MenuBar->new;
  $bar->Append( $file, "&File" );
  $bar->Append( $tree, "&Tree" );
  $bar->Append( $item, "&Item" );

  $this->SetMenuBar( $bar );

  use Wx::Event qw(EVT_MENU EVT_UPDATE_UI);

  EVT_MENU( $this, $ID_ABOUT, \&OnAbout );
  EVT_MENU( $this, $ID_QUIT, \&OnQuit );

  EVT_MENU( $this, $ID_TRAVERSE, \&OnTraverse );
  EVT_MENU( $this, $ID_TOGGLE_MULTI, \&OnToggleMultiSel );

  EVT_MENU( $this, $ID_RENAME, \&OnRename );
  EVT_MENU( $this, $ID_SELECT, \&OnSelect );
  EVT_MENU( $this, $ID_DESELECT, \&OnDeselect );
  EVT_MENU( $this, $ID_DESELECTALL, \&OnDeselectAll );
  EVT_MENU( $this, $ID_ASCENDING, \&OnSortAscending );
  EVT_MENU( $this, $ID_DESCENDING, \&OnSortDescending );

  EVT_UPDATE_UI( $this, $ID_SELECT, \&OnUpdateMulti );
  EVT_UPDATE_UI( $this, $ID_DESELECT, \&OnUpdateMulti );
  EVT_UPDATE_UI( $this, $ID_RENAME, \&OnUpdateMulti );

  $this;
}

sub DESTROY {
  my $this = shift;

  Wx::Log::SetActiveTarget( $this->{OLDLOG} )->Destroy;
}

sub OnQuit {
  my( $this, $event ) = @_;

  $this->Close( 1 );
}

sub OnAbout {
  my( $this, $event ) = @_;

  use Wx qw(wxOK);

  Wx::MessageBox( "Wx::TreeCtrl sample", "About sample", wxOK, $this );
}

sub OnRename {
  my( $this, $event ) = @_;
  my $item = $this->{TREECTRL}->GetSelection;

  if( !$item->IsOk ) { Wx::MessageBox( "Must select an item, first!" );return }
  $this->{TREECTRL}->EditLabel( $item );
}

sub OnSortAscending {
  $_[0]->DoSort( 1 );
}

sub OnSortDescending {
  $_[0]->DoSort( 0 );
}

sub DoSort {
  my( $this, $ascending ) = @_;
  my $item = $this->{TREECTRL}->GetSelection;

  if( !$item->IsOk ) { Wx::MessageBox( "Must select an item, first!" );return }
  $this->{TREECTRL}->DoSortChildren( $item, $ascending );
}

sub OnSelect {
  my( $this, $event ) = @_;

  $this->{TREECTRL}->SelectItem( $this->{TREECTRL}->GetSelection );
}

sub OnTraverse {
  my( $this, $item ) = @_;

  $this->{TREECTRL}->GetItemsRecursively( $this->{TREECTRL}->GetRootItem, -1 );
}

sub OnDeselect {
  my( $this, $event ) = @_;

  $this->{TREECTRL}->Unselect;
}

sub OnDeselectAll {
  my( $this, $event ) = @_;

  $this->{TREECTRL}->UnselectAll;
}

sub OnUpdateMulti {
  my( $this, $event ) = @_;

  $event->Enable( !( $this->{TREECTRL}->GetWindowStyleFlag & wxTR_MULTIPLE ) );
}

sub OnToggleMultiSel {
  my( $this, $event ) = @_;
  my $style = $this->{TREECTRL}->GetWindowStyleFlag;

  $style ^= wxTR_MULTIPLE;
  $this->{TREECTRL}->Destroy;
  $this->{TREECTRL} = MyTreeCtrl->new( $this, -1, wxDefaultPosition,
                                       wxDefaultSize, $style );

  $this->Layout();
}

package MyTreeCtrl;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::TreeCtrl);

sub ResizeTo {
  my( $image, $size ) = @_;

  if( $image->GetWidth != $size || $image->GetHeight != $size ) {
    return Wx::Bitmap->new
      ( Wx::Image->new( $image )->Rescale( $size, $size ) );
  }

  return $image;
}

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  $this->{IMAGELIST} = Wx::ImageList->new( 16, 16, 1 );
  $this->{IMAGELIST}->Add( Wx::GetWxPerlIcon( 1 ) );
  $this->{IMAGELIST}->Add
    ( ResizeTo( Wx::wxTheApp()->GetStdIcon( Wx::wxICON_EXCLAMATION() ), 16 ) );

  $this->SetImageList( $this->{IMAGELIST} );
  $this->PopulateTree( 2, 3 );

  use Wx::Event qw(EVT_TREE_BEGIN_DRAG EVT_TREE_END_DRAG
                   EVT_TREE_SEL_CHANGED);

  EVT_TREE_BEGIN_DRAG( $this, $this, \&OnBeginDrag );
  EVT_TREE_END_DRAG( $this, $this, \&OnEndDrag );
  EVT_TREE_SEL_CHANGED( $this, $this, \&OnSelChange );

  $this;
}

sub PopulateTree {
  my( $this, $childs, $depth ) = @_;

  my $root = $this->AddRoot( 'Root', -1, -1, Wx::TreeItemData->new( 'Data' ) );

  $this->PopulateRecursively( $root, $childs, $depth );
}

sub PopulateRecursively {
  my( $this, $parent, $childs, $depth ) = @_;
  my( $text, $item );

  use Wx qw(wxITALIC_FONT wxRED wxBLUE);

  foreach my $i ( 1 .. $childs ) {
    my $text = ( $depth > 0 ) ? "Node $i/$childs" : "Leaf $i/$childs";

    $item = $this->AppendItem( $parent, $text, 0, 1,
                               Wx::TreeItemData->new( $text ) );
    $this->SetItemFont( $item, wxITALIC_FONT ) if $depth == 0;
    $this->SetItemBackgroundColour( $item, wxBLUE ) if $depth == 1;
    $this->SetItemTextColour( $item, wxRED ) if $depth == 2;

    if( $i == 2 ) {
      my $t = Wx::TreeItemData->new; $t->SetData( "Foo $i" );
      $this->SetItemData( $item, $t );
    }
    $this->SetPlData( $item, "Bar $i" )
      if $i == 3;
    #FIXME// see bugs.txt
#    $this->GetItemData( $item )->SetData( "A" )
#      if $i == 4;

    $this->PopulateRecursively( $item, $childs + 1, $depth - 1 )
      if $depth >= 1;
  }
}

sub DoSortChildren {
  my( $this, $item, $ascending ) = @_;

  $this->{REVERSESORT} = !$ascending;
  $this->SortChildren( $item );
}

sub OnCompareItems {
  my( $this, $item1, $item2 ) = @_;

  if( $this->{REVERSESORT} ) {
    return $this->SUPER::OnCompareItems( $item2, $item1 );
  } else {
    return $this->SUPER::OnCompareItems( $item1, $item2 );
  }
}

sub GetItemsRecursively {
  my( $this, $parent, $cookie ) = @_;
  my $id;

  if( $cookie <= 0 ) { ( $id, $cookie ) = $this->GetFirstChild( $parent ) }
  else { ( $id, $cookie ) = $this->GetNextChild( $parent, $cookie ) }

  return unless $id->IsOk;

  Wx::LogMessage( "%s", $this->GetItemText( $id ) );

  if( $this->ItemHasChildren( $id ) ) {
    $this->GetItemsRecursively( $id, -1 );
  }

  $this->GetItemsRecursively( $id, $cookie );
}

sub OnBeginDrag {
  my( $this, $event ) = @_;

  if( $event->GetItem != $this->GetRootItem ) {
    $this->{DRAGGEDITEM} = $event->GetItem;

    Wx::LogMessage( "Dragging %s",
                    $this->GetItemText( $this->{DRAGGEDITEM} ) );

    $event->Allow;
  } else {
    Wx::LogMessage( "This item can't be dragged" );
  }
}

# this is only a test: a real implementation probably will
# move ( mot copy ) a node, and probably the node childrens, too
# and drop the item at the right place ( not just append it )
sub OnEndDrag {
  my( $this, $event ) = @_;
  my( $src, $dst ) = ( $this->{DRAGGEDITEM}, $event->GetItem );

  if( $dst->IsOk && !$this->ItemHasChildren( $dst ) ) {
    # copy to parent
    $dst = $this->GetParent( $dst );
  }

  if( !$dst->IsOk ) {
    Wx::LogMessage( "Can't drop here" );
    return;
  }

  my $text = $this->GetItemText( $src );
  Wx::LogMessage( "'%s' copied to '%s'", $text, $this->GetItemText( $dst ) );
  $this->AppendItem( $dst, $text, -1 );
}

sub OnSelChange {
  my( $this, $event ) = @_;
  my $item = $event->GetItem;
  my $data;

  Wx::LogMessage( 'Text: %s', $this->GetItemText( $item ) );
  if( $data = $this->GetItemData( $item ) ) {
    Wx::LogMessage( 'Data: %s', $data->GetData );
  }
  Wx::LogMessage( 'Data: %s', $this->GetPlData( $item ) );
}

package MyApp;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::App);

sub OnInit {
  my $this = shift;

  my $frame = MyFrame->new( "Wx::TreeCtrl test", 50, 50, 450, 450 );
  $frame->Show( 1 );

  $this->SetTopWindow( $frame );

  1;
}

package main;

my $app = MyApp->new;
$app->MainLoop;

# Local variables: #
# mode: cperl #
# End: #
