#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;
use Wx::AUI;

my $app = Wx::App->new( sub { 1 } );
my $auimanager = Wx::AuiManager->new;
my $auimanager2 = Wx::AuiManager->new;
my $auipaneinfo = Wx::AuiPaneInfo->new;
my $auipaneinfo2 = Wx::AuiPaneInfo->new;

undef $auimanager2;
undef $auipaneinfo2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
