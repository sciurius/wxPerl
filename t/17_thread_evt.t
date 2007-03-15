#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;
use threads::shared;

use Wx;
use if !Wx::wxTHREADS(), 'Test::More' => skip_all => 'No thread support';

use Test::More tests => 2;

{
    package MyFrame;

    use base 'Wx::Frame';
}

my $app = Wx::App->new( sub { 1 } );
my $frame = MyFrame->new( undef, -1, 'Test' );
my $timer = Wx::Timer->new( $frame );

my $TEST_DONE_EVENT : shared = Wx::NewEventType;

# avoid use()ing Wx::Event on purpose
Wx::Event::EVT_COMMAND( $frame, -1, $TEST_DONE_EVENT, \&got_thread_event );
Wx::Event::EVT_TIMER( $frame, -1, \&got_timer_event );

$timer->Start( 800, 1 );
$app->MainLoop;

pass; # ended successfully

sub got_timer_event {
    my( $frame, $event ) = @_; @_ = (); # hack to avoid "Scalars leaked"

    start_thread( $frame );
}

sub start_thread {
    my( $frame ) = @_;

    my $thread = threads->new( \&send_thread_event, $frame );
    $thread->join;
}

sub send_thread_event {
    my( $frame ) = @_;

    my $threvent = new Wx::PlThreadEvent( -1, $TEST_DONE_EVENT, 123 );
    Wx::PostEvent( $frame, $threvent );
}

sub got_thread_event {
    pass;

    $frame->Destroy;
}

