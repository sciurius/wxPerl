#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';
use Tests_Helper qw(test_app);
use Test::More 'tests' => 6;

use Wx::Event qw(EVT_TIMER);

my $app = test_app(
    sub {
        Wx::Frame->new( undef, -1, 'X' )->Show( 1 ); # to appease wxGTK
    } );

my $timer = Wx::Timer->new($app, 123);

sub onTimer0 {
    ok( 1, 'Timer fired' );
    eval 'BEGIN { die "Fatal!" }';
    ok( $@, 'Error was generated and trapped' );

    EVT_TIMER( $app, 123, undef ); # disconnect
    EVT_TIMER( $app, 123, \&onTimer1 );
    $timer->Start( 20, 1 );
}

sub onTimer1 {
    ok( 1, 'Second timer fired' );
    eval 'use ThisModuleDoesNotExist';
    ok( $@, 'Error was generated and trapped' );

    EVT_TIMER( $app, 123, undef ); # disconnect
    EVT_TIMER( $app, 123, \&onTimer2 );
    $timer->Start( 20, 1 );
}

sub onTimer2 {
    ok( 1, 'Third timer fired' );
    die "I am going away...";
    fail( 'panic: die() did not work' );
}

EVT_TIMER( $app, 123, \&onTimer0 );
$timer->Start( 10, 1 );

eval { $app->MainLoop };

like( $@, qr/^I am going away\.\.\./, 'Exception correctly propagated' );

