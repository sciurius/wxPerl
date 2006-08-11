#!/usr/bin/perl -w

use strict;
use warnings;
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;
use Wx::XRC;

my $app = Wx::App->new( sub { 1 } );
my $xr = Wx::XmlResource->new;
my $xr2 = Wx::XmlResource->new;

undef $xr2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
