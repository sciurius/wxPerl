#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use if Wx::wxMOTIF, 'Test::More' => skip_all => 'Hangs under Motif';
use Test::More tests => 4;
use Wx::Socket;

my $app = Wx::App->new( sub { 1 } );
my $sk = Wx::IPV4address->new;
my $sk2 = Wx::IPV4address->new;

undef $sk2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
