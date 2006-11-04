#!/usr/bin/perl -w

# tests the ability of sending events directly
# to windows

use strict;
use Wx;
use lib './t';
use Test::More 'tests' => 7;
use Tests_Helper qw(test_frame);

test_frame( 'MyFrame' );

package MyEvent;

use base 'Wx::PlCommandEvent';

our $destroyed; BEGIN { $destroyed = 0 };

sub DESTROY {
    $destroyed++;
    $_[0]->SUPER::DESTROY;
}

package MyFrame;

use base 'Wx::Frame';
use Wx::Event qw(EVT_BUTTON);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, 'Test' );

  my $button = Wx::Button->new( $this, -1, 'Button' );

  my $var = 0;

  EVT_BUTTON( $this, $button,
              sub {
                  my( $this, $evt ) = @_;

                  $var = 1;
              } );

  {
      my $event = Wx::CommandEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                         $button->GetId() );

      $button->GetEventHandler->ProcessEvent( $event );
  }

  main::ok( $var, "event succesfully received" );
  main::is( $MyEvent::destroyed, 0 );

  $var = 0;

  {
      my $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                $button->GetId() );

      $button->GetEventHandler->ProcessEvent( $event );
  }

  main::ok( $var, "event succesfully received (no crash)" );
  main::is( $MyEvent::destroyed, 1 );

  $var = 0;

  EVT_BUTTON( $this, $button, undef );

  {
      my $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                $button->GetId() );

  }

  main::is( $MyEvent::destroyed, 2 );

  {
      my $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                $button->GetId() );

      $button->GetEventHandler->ProcessEvent( $event );
  }

  main::ok( !$var, "event handler disconnected" );
  main::is( $MyEvent::destroyed, 3 );

  $this->Destroy;
}

# Local variables: #
# mode: cperl #
# End: #
