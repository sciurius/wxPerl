#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;
use Wx::DocView;

my $app = Wx::App->new( sub { 1 } );
my $cp = Wx::CommandProcessor->new;
my $pc = Wx::PlCommand->new;
my $cp2 = Wx::CommandProcessor->new;
my $pc2 = Wx::PlCommand->new;

undef $cp2;
$pc2->Destroy; # having it DTRT on undef is tricky

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
