#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';
use Tests_Helper 'test_frame';

package MyFrame;

use base 'Wx::Frame';
use Test::More 'tests' => 2;

sub new {
my $this = shift->SUPER::new( undef, -1, 'a' );

my $panel2 = Wx::Panel->new( $this, -1 );
like( "$panel2", qr/^Wx::Panel=HASH/ );

my $panel1 = Wx::Panel->new;
like( "$panel1", qr/^Wx::Panel=HASH/ );

$panel1->Create( $this, -1 );

return $this;
};

package main;

test_frame( 'MyFrame', 1 );
Wx::wxTheApp()->MainLoop();

# local variables:
# mode: cperl
# end:
