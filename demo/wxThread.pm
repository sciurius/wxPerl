#############################################################################
## Name:        demo/wxThread.pm
## Purpose:     wxPerl demo helper for threads
## Author:      Mattia Barbon
## Modified by:
## Created:     30/03/2002
## RCS-ID:      $Id: wxThread.pm,v 1.4 2004/11/09 20:56:51 mbarbon Exp $
## Copyright:   (c) 2002-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package ThreadDemo;

use 5.007003;
use strict;
use threads;
use threads::shared;

sub window {
  shift;
  my $parent = shift;

  my $window = ThreadsDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
EOT
}

package ThreadsDemoWin;

use base qw(Wx::Panel);
use Wx::Event qw(EVT_COMMAND EVT_IDLE EVT_CLOSE);
use threads;
use threads::shared;

use vars qw($MY_ID $keep_going $joined);

$ThreadDemoWin::MY_ID = 2345;

# race conditions? what are race conditions?
$keep_going = 1;
$joined = 0;
threads::shared::share( $keep_going );
threads::shared::share( $joined );

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  EVT_COMMAND( $this, -1, $ThreadDemoWin::MY_ID, \&OnThreadEvent );

  $this->{TEXT} = Wx::TextCtrl->new( $this, -1, 'Foo' );
  my @threads;
  $this->{THREADS} = \@threads;

  push @threads, threads->create( \&entry_point, $this, "1 - Foo" );
  push @threads, threads->create( \&entry_point, $this, "2 - Bar" );
#  push @threads, threads->create( \&entry_point, $this, "3 - Baz" );
#  push @threads, threads->create( \&entry_point, $this, "4 - Flu" );
#  push @threads, threads->create( \&entry_point, $this, "5 - Xyz" );

  return $this;
}

sub OnThreadEvent {
  my( $this, $event ) = @_;

  $this->{TEXT}->SetLabel( $event->GetData() );
}

sub DESTROY {
  my( $this, $event ) = @_;

  threads::shared::lock_enabled( $joined );
  #print "Join begin\n";
  $keep_going = 0;
  if( !$joined ) {
    #print "Join start\n";
    $joined = 1;
    foreach my $i ( @{$this->{THREADS}} ) {
      $i->join();
    }
    #print "Join end\n";
  }

  $this->SUPER::DESTROY();
  #print "Join leave\n";
}

# this should really do something useful, really
sub entry_point {
  my $handler = shift;
  my $value = shift;

  threads::shared::share( $value );

  for(;;) {
    Wx::MilliSleep( 200 + rand( 1000 ) );

    last unless $keep_going;
    my $x = Wx::PlThreadEvent->new( -1, $ThreadDemoWin::MY_ID, $value );
    Wx::PostEvent( $handler, $x );
  }

  #return 123;
}

1;

# local variables: #
# mode: cperl #
# end: #
