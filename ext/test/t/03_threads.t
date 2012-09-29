#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;

use Wx::PerlTest;

package MyAbstractNonObject;
use base qw( Wx::PlPerlTestAbstractNonObject );

sub new { shift->SUPER::new( @_ ) }

package MyAbstractObject;
use base qw( Wx::PlPerlTestAbstractObject );

sub new { shift->SUPER::new( @_ ) }

package MyNonObject;
use base qw( Wx::PlPerlTestNonObject );

sub new { shift->SUPER::new( @_ ) }

package main;

my $app = Wx::App->new( sub { 1 } );

my $anonobj =  MyAbstractNonObject->new;
my $aobj    =  MyAbstractObject->new;
my $nonobj  =  MyNonObject->new;
my $obj     =  Wx::PerlTestObject->new;

my $anonobj2 = MyAbstractNonObject->new;
my $aobj2   =  MyAbstractObject->new;
my $nonobj2 =  MyNonObject->new;
my $obj2    =  Wx::PerlTestObject->new;

undef $anonobj2;
undef $aobj2;
undef $nonobj2;
undef $obj2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
