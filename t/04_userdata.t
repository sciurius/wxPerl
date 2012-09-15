#!/usr/bin/perl -w

# test for client data handling in various controls

use strict;
use Wx;
use lib './t';
use Tests_Helper qw(in_frame);
use Wx::Event qw(EVT_BUTTON);

package MyClass;

sub new {
  my $class = shift;
  my $code = shift;
  die "want a CODE reference" unless ref $code eq 'CODE';

  return bless [ $code ], $class;
}

sub DESTROY { &{$_[0][0]} }

package main;

use Test::More 'tests' => 65;

use strict;
#use base 'Wx::Frame';
use vars '$TODO';

sub tdata($) { Wx::TreeItemData->new( MyClass->new( $_[0] ) ) }
sub cdata($) { MyClass->new( $_[0] ) }

sub tests {
  my $this = shift;

  ############################################################################
  # wxTreeCtrl
  ############################################################################

  my $tree = Wx::TreeCtrl->new( $this, -1 );
  my $root = $tree->AddRoot( 'Root', -1, -1,
                             Wx::TreeItemData->new( 'Frobnicate' ) );

  my $trdata = $tree->GetItemData( $root );
  my $data = $trdata->GetData();
  is( $data, 'Frobnicate', "Wx::TreeItemData::GetData" );
  $data = $trdata->GetData();

  is( $data, 'Frobnicate', "Wx::TreeItemData::GetData (again)" );
  $data = $tree->GetPlData( $root );
  is( $data, 'Frobnicate', "Wx::TreeCtrl::GetPlData" );

  $trdata = $tree->GetItemData( $root );
  $trdata->SetData( 'Baz' );
  $trdata = $tree->GetItemData( $root );
  $data = $trdata->GetData();
  is( $data, 'Baz', "Wx::TreeItemData::SetData" );
  $tree->SetItemData( $root, Wx::TreeItemData->new( 'Boo' ) );
  $data = $tree->GetPlData( $root );
  is( $data, 'Boo', "Wx::TreeCtrl::SetItemData" );
  $tree->SetPlData( $root, 'XyZ' );
  $data = $tree->GetPlData( $root );
  is( $data, 'XyZ', "Wx::TreeCtrl::SetPlData" );

  # test deleting and setting again
  my( $deleting, $setting, $ctrldelete ) = ( 0, 0, 0 );

  my $item1 = $tree->AppendItem( $root, 'An item', -1, -1,
                                 tdata sub { $deleting = 1 } );
  my $item2 = $tree->AppendItem( $root, 'An item', -1, -1,
                                 tdata sub { $setting = 1 } );
  my $item3 = $tree->AppendItem( $root, 'An item', -1, -1,
                                 tdata sub { $ctrldelete = 1 } );

  $tree->Delete( $item1 );
  ok( $deleting, 'WxTreeCtrl: deleting an item deletes the data' );
  $tree->SetItemData( $item2, Wx::TreeItemData->new( 'foo' ) );
  ok( $setting, 'Wx::TreeCtrl: setting again item data deletes old data' );
  # and hope the tree is deleted NOW
  $tree->Destroy;
  ok( $ctrldelete, 'Wx::TreeCtrl: deleting the tree deletes the data' );
  
  ############################################################################
  # wxTreeListCtrl
  ############################################################################
  
  SKIP: {
    skip 'No Native Wx::TreeListCtrl', 8 unless defined(&Wx::TreeListCtrl::new);

    my $treelist = Wx::TreeListCtrl->new( $this, -1,  );
    $treelist->AppendColumn("Component",
                       &Wx::wxCOL_WIDTH_AUTOSIZE,
                       &Wx::wxALIGN_LEFT,
                       &Wx::wxCOL_RESIZABLE | &Wx::wxCOL_SORTABLE);
    $treelist->AppendColumn("# Files",
                       $treelist->WidthFor("1,000,000"),
                       &Wx::wxALIGN_RIGHT,
                       &Wx::wxCOL_RESIZABLE | &Wx::wxCOL_SORTABLE);
    $treelist->AppendColumn("Size",
                       $treelist->WidthFor("1,000,000 KiB"),
                       &Wx::wxALIGN_RIGHT,
                       &Wx::wxCOL_RESIZABLE | &Wx::wxCOL_SORTABLE);    
    
    my $tlroot = $treelist->GetRootItem();
    ok( $tlroot->IsOk, 'Wx::TreeListCtrl Root item OK');
    my $tldata = \'Hubris';
    $treelist->SetItemData($tlroot, $tldata);
    
    my $outdata = $treelist->GetItemData($tlroot);
    is( $$outdata, 'Hubris', "Wx::TreeListCtrl::GetItemData" );
    $outdata = $treelist->GetItemData($tlroot);
    is( $$outdata, 'Hubris', "Wx::TreeListCtrl::GetItemData again" );    
    
    $treelist->SetItemData($tlroot, Wx::TreeItemData->new( 'Aghast' ) );
    $outdata = $treelist->GetItemData($tlroot)->GetData;
    is( $outdata, 'Aghast', "Wx::TreeListCtrl::GetItemData From Wx::TreeItemData" );    
    
    ## test deleting and setting again
    my( $tldeleting, $tlsetting, $tlctrldelete ) = ( 0, 0, 0 );
        
    my $tlitem1 = $treelist->AppendItem( $tlroot, 'An item', -1, -1,
                                   cdata sub { $tldeleting = 1 } );
    my $tlitem2 = $treelist->AppendItem( $tlroot, 'An item', -1, -1,
                                   cdata sub { $tlsetting = 1 } );
    my $tlitem3 = $treelist->AppendItem( $tlroot, 'An item', -1, -1,
                                   cdata sub { $tlctrldelete = 1 } );
    
    is( ref($treelist->GetItemData($tlitem1)), 'MyClass', 'Wx::TreeListCtrl Item Data is class');
    
    $treelist->DeleteItem( $tlitem1 );
    
    ok( $tldeleting, 'Wx::TreeListCtrl: deleting an item deletes the data' );
    $treelist->SetItemData( $tlitem2, Wx::TreeItemData->new( 'foo' ) );
    ok( $tlsetting, 'Wx::TreeListCtrl: setting again item data deletes old data' );
    ## and hope the tree is deleted NOW
    $treelist->Destroy;
    ok( $tlctrldelete, 'Wx::TreeListCtrl: deleting the tree deletes the data' );
  };

  ############################################################################
  # wxListBox & co.
  ############################################################################

  my $list = Wx::ListBox->new( $this, -1 );
  my $combo = Wx::ComboBox->new( $this, -1, 'foo' );
  my $choice = Wx::Choice->new( $this, -1 );
  my $checklist = Wx::CheckListBox->new( $this, -1, [-1, -1], [-1, -1], [1] );
  my $odncombo = undef;

  if( defined &Wx::PlOwnerDrawnComboBox::new ) {
      $odncombo = Wx::PlOwnerDrawnComboBox->new( $this, -1, 'foo', [-1, -1],
                                                 [-1, -1], [] );
  }

  # test deleting and setting again
  for my $x ( [ $list, 'Wx::ListBox' ],
              [ $choice, 'Wx::Choice' ],
              [ $combo, 'Wx::ComboBox' ],
              [ $checklist, 'Wx::CheckListBox' ],
              [ $odncombo, 'Wx::OwnerDrawnComboBox' ],
              ) {
    SKIP: {
      my( $list, $name ) = @$x;
      ( $deleting, $setting, $ctrldelete ) = ( 0, 0, 0 );

      skip( $x->[1] . ": not available", 8 )
        if !defined $x->[0];
      skip( "wxMSW wxCheckListBox can't store client data yet", 8 )
        if Wx::wxMSW && $name eq 'Wx::CheckListBox';

      $list->Clear;

      # diag "starting tests for $name";
      my $data = 'Foo';

      $list->Append( 'An item', $data );
      $list->SetClientData( 0, $data ); # workaround bug in HEAD
      $list->Append( 'An item' );

      $data = 'Frobnication';

      is( $list->GetClientData( 0 ), 'Foo', "$name: some client data" );
      is( $list->GetClientData( 1 ), undef, "$name: no client data" );
      $list->SetClientData( 0, 'Bar' );
      $list->SetClientData( 1, 'Baz' );
      is( $list->GetClientData( 0 ), 'Bar', "$name: setting client data" );
      is( $list->GetClientData( 1 ), 'Baz',
          "$name: setting client data (again)" );

      my $x = 1;
      $list->SetClientData( 0, \$x );
      $x = 2;
      is( ${$list->GetClientData( 0 )}, 2,
          "$name: client data is a reference" );

      $list->Append( 'An item', cdata sub { $setting = 1 } );
      $list->Append( 'An item', cdata sub { $ctrldelete = 1 } );
      $list->Append( 'An item', cdata sub { $deleting = 1 } );

      SKIP: {
        skip "delayed on Mac", 1 if Wx::wxMAC && $list->isa( 'Wx::ListBox' );
        $list->Delete( 4 );
        ok( $deleting, "$name: deleting an item deletes the data" );
      }
      $list->SetClientData( 2, 'foo' );
      ok( $setting, "$name: setting again item data deletes old data" );
      # and hope the control is deleted NOW
      $list->Destroy;
      
      TODO: {
        local $TODO = "is it correct to skip as below ? - Fails on osx-cocoa & 2.9.2 all platforms?";
        # skip "delete delayed", 1 if ( $list->isa( 'Wx::ListBox' ) || $list->isa( 'Wx::ComboBox' ) || $list->isa( 'Wx::Choice' ) );
        ok( $ctrldelete, "$name: deleting the control deletes the data" );
      };
    }
  }

  ############################################################################
  # wxListCtrl
  ############################################################################

  my $listctrl = Wx::ListCtrl->new( $this, -1, [-1, -1], [-1, -1],
                                    Wx::wxLC_REPORT() );
  $listctrl->InsertColumn( 1, "Type" );

  $listctrl->InsertStringItem( 0, 'text0' );
  $listctrl->InsertStringItem( 1, 'text1' );
  $listctrl->InsertStringItem( 2, 'text2' );

  $listctrl->SetItemData( 0, 123 );
  $listctrl->SetItemData( 1, 456 );
  $listctrl->SetItemData( 2, 789 );

  is( $listctrl->GetItemData( 0 ), 123, "Wx::ListCtrl first item data" );
  is( $listctrl->GetItemData( 1 ), 456, "Wx::ListCtrl second item data" );
  is( $listctrl->GetItemData( 2 ), 789, "Wx::ListCtrl third item data" );

  $listctrl->SetItemData( 1, 135 );

  is( $listctrl->GetItemData( 1 ), 135, "Wx::ListCtrl, changing item data" );
  
  ############################################################################
  # wxToolBar
  ############################################################################
  my $toolbar = Wx::ToolBar->new( $this, -1);
  my $tool = $toolbar->AddTool(Wx::wxID_ANY(), Wx::Bitmap->new(16,16,1));
  $tool = $toolbar->AddTool(Wx::wxID_ANY(), Wx::Bitmap->new(16,16,1));
  my $toolid = $tool->GetId;
  isnt($toolid, -1, 'Wx::ToolBar got valid tool id');
  $toolbar->SetToolClientData( $toolid, 'Bar' );
  is( $toolbar->GetToolClientData( $toolid ), 'Bar', 'Wx::ToolBar client data set');
  $toolbar->Realize;
  $ctrldelete = 0;
  $toolbar->SetToolClientData( $toolid, cdata( sub { $ctrldelete = 1 } ));
  
  ok( $ctrldelete == 0, 'Wx::ToolBar controldata not deleted' );
  $toolbar->SetToolClientData( $toolid, undef );
  ok( $ctrldelete, 'Wx::ToolBar - setting client data causes previous data deletion' );

}

in_frame( \&tests );

# local variables:
# mode: cperl
# end:

