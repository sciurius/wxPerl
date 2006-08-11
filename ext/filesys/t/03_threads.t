#!/usr/bin/perl -w

use strict;
use warnings;
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;
use Wx::FS;

my $app = Wx::App->new( sub { 1 } );
my $fs = Wx::FileSystem->new;
my $fs2 = Wx::FileSystem->new;

my $fsfile = $fs->OpenFile( 't/03_threads.t' );
my $fsfile2 = $fs->OpenFile( 't/02_inheritance.t' );

undef $fs2;
undef $fsfile2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
