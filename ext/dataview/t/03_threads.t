#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use if Wx::wxMOTIF, 'Test::More' => skip_all => 'Hangs under Motif';
use Test::More tests => 4;
use Wx::DataView;

my $app = Wx::App->new( sub { 1 } );
my $dvr = Wx::DataViewTextRenderer->new;
my $dvr2 = Wx::DataViewTextRenderer->new;
my $dvc = Wx::DataViewColumn->new( 'a', $dvr, 0 );
my $dvc2 = Wx::DataViewColumn->new( 'a', $dvr2, 0 );

undef $dvr2;
undef $dvc2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
