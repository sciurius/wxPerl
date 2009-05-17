#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;
use Wx::Grid;

my $app = Wx::App->new( sub { 1 } );
my $cc = Wx::GridCellCoords->new( 1, 1 );
my $cc2 = Wx::GridCellCoords->new( 1, 1 );
my $ce = Wx::GridCellNumberEditor->new;
my $ce2 = Wx::GridCellNumberEditor->new;
my $cr = Wx::GridCellStringRenderer->new;
my $cr2 = Wx::GridCellStringRenderer->new;
my $attr = Wx::GridCellAttr->new;
my $attr2 = Wx::GridCellAttr->new;
my $gud;
my $gud2;
if( Wx::wxVERSION >= 2.009 ) {
    $gud = Wx::GridUpdateLocker->new;
    $gud2 = Wx::GridUpdateLocker->new;
}

undef $cc2;
undef $ce2;
undef $cr2;
undef $attr2;
undef $gud2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
