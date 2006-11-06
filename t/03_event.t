#!/usr/bin/perl -w

# tests the ability of sending events directly
# to windows

use strict;
use Wx;
use lib './t';
use Test::More 'tests' => 17;
use Tests_Helper qw(test_frame);

test_frame( 'MyFrame' );

package MyEvent;

use base 'Wx::PlCommandEvent';

our $destroyed; BEGIN { $destroyed = 0 };

sub DESTROY {
    $destroyed++;
    # print "D: $_[0]\n";
    $_[0]->SUPER::DESTROY;
}

sub Clone {
    my( $self ) = @_;
    my $class = ref $self;
    # my $c = $class->new( $self->GetEventType, $self->GetId ); print "C: $c\n"; return $c;
    return $class->new( $self->GetEventType, $self->GetId );
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
  main::is( $MyEvent::destroyed, 0, "no object destroyed" );

  $var = 0;
  {
      my $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                $button->GetId() );

      $button->GetEventHandler->ProcessEvent( $event );
      main::is( $MyEvent::destroyed, 0, "still no object destroyed" );
  }
  main::ok( $var, "event succesfully received" );
  main::is( $MyEvent::destroyed, 1, "one event destroyed" );

  $var = 0;
  {
      my $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                $button->GetId() );
      # print "E: $event\n";
      $button->GetEventHandler->AddPendingEvent( $event );
      main::is( $MyEvent::destroyed, 1, "still one event destroyed" );
  }
  main::is( $MyEvent::destroyed, 2, "original event destroyed" );
  main::ok( !$var, "event not received before yield" );
  Wx::wxTheApp->ProcessPendingEvents;
  main::ok( $var, "event received after yield" );
  main::is( $MyEvent::destroyed, 3, "cloned event destroyed" );

  $var = 0;
  EVT_BUTTON( $this, $button, undef );
  {
      my $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                $button->GetId() );

  }
  main::is( $MyEvent::destroyed, 4 );

  {
      my $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                $button->GetId() );

      $button->GetEventHandler->ProcessEvent( $event );
  }
  main::ok( !$var, "event handler disconnected" );
  main::is( $MyEvent::destroyed, 5 );

  $var = 0;
  {
      my $event = MyEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                $button->GetId() );

      $button->GetEventHandler->AddPendingEvent( $event );
  }
  main::is( $MyEvent::destroyed, 6, "original event destroyed" );
  main::ok( !$var, "event not received before yield" );
  Wx::wxTheApp->ProcessPendingEvents;
  main::ok( !$var, "event not received after yield" );
  main::is( $MyEvent::destroyed, 7, "cloned event destroyed" );

  $this->Destroy;
}

# Local variables: #
# mode: cperl #
# End: #
