#!/usr/bin/perl

# tests the ability of sending events directly
# to windows

BEGIN { print "1..5\n"; }

use strict;
use Wx;
use lib "build";
use Tests_Helper qw(test_frame);
use Wx::Event qw(EVT_BUTTON);

package DataFrame;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Frame);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, 'Test!' );

  my $tree = Wx::TreeCtrl->new( $this, -1 );
  my $root = $tree->AddRoot( 'Root', -1, -1, Wx::TreeItemData->new( 'Frobnicate' ) );

  my $trdata = $tree->GetItemData( $root );
  my $data = $trdata->GetData();

  print( ( ( $data eq 'Frobnicate' ) ? '' : 'not ' ) . "ok 1\n" );

  $data = $tree->GetPlData( $root );

  print( ( ( $data eq 'Frobnicate' ) ? '' : 'not ' ) . "ok 2\n" );

  $trdata = $tree->GetItemData( $root );
  $trdata->SetData( 'Baz' );
  $trdata = $tree->GetItemData( $root );
  $data = $trdata->GetData();

  print( ( ( $data eq 'Baz' ) ? '' : 'not ' ) . "ok 3\n" );

  $tree->SetItemData( $root, Wx::TreeItemData->new( 'Boo' ) );
  $data = $tree->GetPlData( $root );

  print( ( ( $data eq 'Boo' ) ? '' : 'not ' ) . "ok 4\n" );

  $tree->SetPlData( $root, 'XyZ' );
  $data = $tree->GetPlData( $root );

  print( ( ( $data eq 'XyZ' ) ? '' : 'not ' ) . "ok 5\n" );

  $this->Destroy;

  return $this;
}

package main;

test_frame( 'DataFrame' );

exit 0;

# Local variables: #
# mode: cperl #
# End: #

