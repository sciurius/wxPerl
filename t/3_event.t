#!/usr/bin/perl

# tests the ability of sending events directly
# to windows

BEGIN { print "1..1\n"; }

use strict;
use lib 'build';
use Wx;
use Tests_Helper qw(test_frame);

test_frame( 'MyFrame' );

package MyFrame;

use base 'Wx::Frame';
use Wx::Event qw(EVT_BUTTON);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, 'Test' );

  my $button = Wx::Button->new( $this, -1, 'Button' );

  my $var = 'not ok';

  EVT_BUTTON( $this, $button, sub { $var = 'ok' } );

  my $event = Wx::CommandEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED,
                                     $button->GetId() );

  $button->GetEventHandler->ProcessEvent( $event );

  print $var, "\n";

  $this->Destroy;
}

# Local variables: #
# mode: cperl #
# End: #
