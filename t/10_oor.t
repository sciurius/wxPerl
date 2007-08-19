#!/usr/bin/perl -w

# tests that Original Object Return works
# only tests a few classes

use strict;
use Wx;
use lib './t';
use Tests_Helper 'test_frame';

package MyListBox;

use base 'Wx::ListBox';

package MyFrame;

use base 'Wx::Frame';
use Test::More 'tests' => 58;

sub new {
my $this = shift->SUPER::new( undef, -1, 'a' );

# class, params
my @data = ( [ 'Wx::Button', [ 'a' ] ],
             [ 'Wx::BitmapButton', [ Wx::Bitmap->new( 10, 10 ) ] ],
             [ 'Wx::CheckBox', [ 'foo' ] ],
             [ 'Wx::CheckListBox', [ [-1, -1], [-1, -1], [1] ] ],
             [ 'Wx::Choice', [] ],
             [ 'Wx::ComboBox', [ 'a' ] ],
             [ 'Wx::Gauge', [ 1 ] ],
             [ 'Wx::ListBox', [] ],
             [ 'Wx::ListCtrl', [] ],
             [ 'Wx::ListView', [] ],
             [ 'Wx::MiniFrame', [ 'a' ], 'SKIP' ],
             [ 'Wx::Notebook', [] ],
             [ 'Wx::RadioBox', [ 'a', [-1, -1], [-1, -1], [ 'a' ] ] ],
             [ 'Wx::RadioButton', [ 'a' ] ],
             [ 'Wx::SashWindow', [] ],
             [ 'Wx::ScrollBar', [] ],
             [ 'Wx::SpinButton', [] ],
             [ 'Wx::SpinCtrl', [ 'aaa' ] ],
             [ 'Wx::SplitterWindow', [] ],
             [ 'Wx::Slider', [ 3, 2, 4 ] ],
             [ 'Wx::StaticBitmap', [ Wx::Bitmap->new( 10, 10 ) ], 'SKIP' ],
             [ 'Wx::StaticBox', [ 'a' ], 'SKIP' ],
             [ 'Wx::StaticLine', [], 'SKIP' ],
             [ 'Wx::StaticText', [ 'a' ], 'SKIP' ],
             [ 'Wx::StatusBar', [], 'SKIP' ],
             [ 'Wx::TextCtrl', [ 'a' ] ],
             [ 'Wx::TreeCtrl', [] ],
             [ 'Wx::Window', [] ],
           );

foreach my $d ( @data ) {
    my( $class, $args, $skip_phase ) = @$d;

  SKIP: {
      # simple creation
      skip "Some controls are weird", 2
        if Wx::wxMOTIF() && $class eq 'Wx::StaticLine'
        or Wx::wxMOTIF() && $class eq 'Wx::SpinCtrl'
        or Wx::wxGTK() && $class =~ m/^Wx::(MiniFrame|StatusBar)/
        or Wx::wxMAC() && $class eq 'Wx::SpinCtrl';
      skip "Segfaults under wxMotif 2.6.x", 2
        if Wx::wxMOTIF() && $class eq 'Wx::StaticBitmap'
           && Wx::wxVERSION < 2.008;

      my $lb = $class->new( $this, -1, @$args );
      my $lb2 = ($this->GetChildren)[-1];

      is( $lb2, $lb, "objects reference the same hash ($class)" );

      $lb->Destroy;

      skip "Skipping two-phase creation for $class", 1
        if $skip_phase;

      # test double-phase creation
      $lb = $class->new;
      $lb->Create( $this, -1, @$args );
      $lb2 = ($this->GetChildren)[-1];

      is( $lb2, $lb, "objects reference the same hash ($class) (2 phase) " );

      $lb->Destroy;
  }
}

my $lb = MyListBox->new( $this, -1 );
$lb->{MYDATA} = 'some data';

my $lb2 = ($this->GetChildren)[-1];

is( $lb2, $lb, "objects reference the same hash" );
is( $lb2->{MYDATA}, $lb->{MYDATA}, "sanity check" );

$lb->Destroy;

Wx::Event::EVT_IDLE( $this,
                     sub { $this->Destroy } );
$this->Destroy if ( Wx::wxMSW || Wx::wxGTK || Wx::wxMOTIF )
               && Wx::wxVERSION() < 2.005;
};

package main;

test_frame( 'MyFrame' );
Wx::wxTheApp()->MainLoop();

# local variables:
# mode: cperl
# end:
