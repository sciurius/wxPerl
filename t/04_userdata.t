#!/usr/bin/perl -w

# tests the ability of sending events directly
# to windows

use strict;
use Wx;
use lib "build";
use Test::More 'tests' => 6;
use Tests_Helper qw(test_frame);
use Wx::Event qw(EVT_BUTTON);

package DataFrame;

use strict;
use base 'Wx::Frame';
use vars '$TODO';

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, 'Test!' );

  my $tree = Wx::TreeCtrl->new( $this, -1 );
  my $root = $tree->AddRoot( 'Root', -1, -1, Wx::TreeItemData->new( 'Frobnicate' ) );

  my $trdata = $tree->GetItemData( $root );
  my $data = $trdata->GetData();
  main::is( $data, 'Frobnicate', "Wx::TreeItemData::GetData" );
  $data = $trdata->GetData();
 TODO: {
    local $DataFrame::TODO = "Bug with Perl 5.004" if $] < 5.005;

    main::is( $data, 'Frobnicate', "Wx::TreeItemData::GetData (again)" );
    $data = $tree->GetPlData( $root );
    main::is( $data, 'Frobnicate', "Wx::TreeCtrl::GetPlData" );
  }

  $trdata = $tree->GetItemData( $root );
  $trdata->SetData( 'Baz' );
  $trdata = $tree->GetItemData( $root );
  $data = $trdata->GetData();
  main::is( $data, 'Baz', "Wx::TreeItemData::SetData" );
  $tree->SetItemData( $root, Wx::TreeItemData->new( 'Boo' ) );
  $data = $tree->GetPlData( $root );
  main::is( $data, 'Boo', "Wx::TreeCtrl::SetItemData" );
  $tree->SetPlData( $root, 'XyZ' );
  $data = $tree->GetPlData( $root );
  main::is( $data, 'XyZ', "Wx::TreeCtrl::SetPlData" );

  $this->Destroy;

  return $this;
}

package main;

test_frame( 'DataFrame' );

exit 0;

# Local variables: #
# mode: cperl #
# End: #

