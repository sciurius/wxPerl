#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use Wx::IPC;
use if !Wx::_wx_optmod_ipc(), 'Test::More' => skip_all => 'No IPC Support';
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;

my @keeps;
my @undef;

push @keeps, Wx::Connection->new;
push @undef, Wx::Connection->new;
push @keeps, Wx::Server->new;
push @undef, Wx::Server->new;
push @keeps, Wx::Client->new;
push @undef, Wx::Client->new;

while ( my $prop = pop( @undef ) ) {
      undef $prop;
}
undef @undef;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );


END { ok( 1, 'At END' ) };
