#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';
use Test::More Wx::wxMAC() ? ( 'skip_all' => 'Hangs on wxMac' ) :
                             ( 'tests'    => 2 );
use Tests_Helper qw(test_app);

my $frame;

# test with Notify

package MyTimer;

use vars qw(@ISA); @ISA = qw(Wx::Timer);

sub Notify {
  main::ok( 1, "Overriding Notify works" );
}

package main;

# test with owner

package MyHandler;

use base qw(Wx::EvtHandler);
use Wx::Event qw(EVT_TIMER);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  EVT_TIMER( $this, -1, \&OnTimer );

  return $this;
}

sub OnTimer {
  main::ok( 1, "EVT_TIMER works" );
  $frame->{T1}->Destroy;
  $frame->{T2}->Destroy;
  $frame->Destroy;
  Wx::WakeUpIdle;
}

package MyFrame;

use base qw(Wx::Frame);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  my $timer2 = Wx::Timer->new( MyHandler->new );
  $timer2->Start( 800, 1 );

  my $timer1 = MyTimer->new;
  $timer1->Start( 100, 1 );

  $this->{T1} = $timer1;
  $this->{T2} = $timer2;

  return $this;
}

package main;

use Wx qw(wxTheApp);

my $app = test_app( sub {
                      $frame = MyFrame->new( undef, -1, 'boo' );
                      $frame->Show( 1 );
                      return 1;
                    } );

$app->MainLoop;

# Local variables: #
# mode: cperl #
# End: #

