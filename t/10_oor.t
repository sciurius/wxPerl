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
use Test::More 'tests' => 28;

sub new {
my $this = shift->SUPER::new( undef, -1, 'a' );

# class, params
my @data = ( [ 'Wx::Button', [ 'a' ] ],
             [ 'Wx::BitmapButton', [ Wx::Bitmap->new( 10, 10 ) ] ],
             [ 'Wx::CheckBox', [ 'foo' ] ],
             [ 'Wx::CheckListBox', [] ],
             [ 'Wx::Choice', [] ],
             [ 'Wx::ComboBox', [ 'a' ] ],
             [ 'Wx::Gauge', [ 1 ] ],
             [ 'Wx::ListBox', [] ],
             [ 'Wx::ListCtrl', [] ],
             [ 'Wx::ListView', [] ],
             [ 'Wx::Notebook', [] ],
             [ 'Wx::RadioBox', [ 'a', [-1, -1], [-1, -1], [ 'a' ] ] ],
             [ 'Wx::RadioButton', [ 'a' ] ],
             [ 'Wx::SashWindow', [] ],
             [ 'Wx::ScrollBar', [] ],
             [ 'Wx::SpinButton', [] ],
             [ 'Wx::SpinCtrl', [ 'aaa' ] ],
             [ 'Wx::SplitterWindow', [] ],
             [ 'Wx::Slider', [ 3, 2, 4 ] ],
             [ 'Wx::StaticBitmap', [ Wx::Bitmap->new( 10, 10 ) ] ],
             [ 'Wx::StaticBox', [ 'a' ] ],
             [ 'Wx::StaticLine', [] ],
             [ 'Wx::StaticText', [ 'a' ] ],
             [ 'Wx::StatusBar', [] ],
             [ 'Wx::TextCtrl', [ 'a' ] ],
             [ 'Wx::TreeCtrl', [] ],
           );

foreach my $d ( @data ) {
    my( $class, $args ) = @$d;

  SKIP: {
      skip "Generic wxStaticLine is weird", 1
        if Wx::wxMOTIF() && $class eq 'Wx::StaticLine';

      my $lb = $class->new( $this, -1, @$args );

      my $lb2 = ($this->GetChildren)[0];

      is( $lb2, $lb, "$class:\t\tobjects reference the same hash" );

      $lb->Destroy;
  }
}

my $lb = MyListBox->new( $this, -1 );
$lb->{MYDATA} = 'some data';

my $lb2 = ($this->GetChildren)[0];

is( $lb2, $lb, "objects reference the same hash" );
is( $lb2->{MYDATA}, $lb->{MYDATA}, "sanity check" );

$lb->Destroy;

Wx::Event::EVT_IDLE( $this,
                     sub { $this->Destroy } );
$this->Destroy if Wx::wxMSW || Wx::wxGTK || Wx::wxMOTIF;
};

package main;

test_frame( 'MyFrame' );
Wx::wxTheApp()->MainLoop();

# local variables:
# mode: cperl
# end:
