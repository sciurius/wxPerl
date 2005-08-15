#!/usr/bin/perl -w

# tests the ability of sending events directly
# to windows

use strict;
use Wx;
use lib './t';
use Test::More 'tests' => 3;
use Tests_Helper qw(test_frame);

test_frame( 'MyFrame' );

package MyEvent;

use base 'Wx::PlCommandEvent';

package MyFrame;

use base 'Wx::Frame';
use Wx::Event qw(EVT_BUTTON);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, 'Test' );

  my $button = Wx::Button->new( $this, -1, 'Button' );

  my $var = 0;

  EVT_BUTTON( $this, $button, sub { $var = 1 } );

  my $event = Wx::CommandEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                     $button->GetId() );

  $button->GetEventHandler->ProcessEvent( $event );

  main::ok( $var, "event succesfully received" );

  $var = 0;

  $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                         $button->GetId() );

  $button->GetEventHandler->ProcessEvent( $event );

  main::ok( $var, "event succesfully received (no crash)" );

  $var = 0;

  EVT_BUTTON( $this, $button, undef );

  $button->GetEventHandler->ProcessEvent( $event );

  main::ok( !$var, "event handler disconnected" );

  $this->Destroy;
}

# Local variables: #
# mode: cperl #
# End: #
