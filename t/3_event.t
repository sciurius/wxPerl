#!/usr/bin/perl

# tests the ability of sending events directly
# to windows

BEGIN { print "1..1\n"; }

use strict;
use Wx;
use Wx::Event qw(EVT_BUTTON);

my $frame = Wx::Frame->new( undef, -1, 'Test' );
my $button = Wx::Button->new( $frame, -1, 'Button' );

my $var = 'not ok';

EVT_BUTTON( $frame, $button, sub { $var = 'ok' } );

my $event = Wx::CommandEvent->new( &Wx::wxEVT_COMMAND_BUTTON_CLICKED, $button->GetId() );

$button->GetEventHandler->ProcessEvent( $event );

print $var;

$frame->Destroy;

exit 0;

# Local variables: #
# mode: cperl #
# End: #
