#!/usr/bin/perl -w

# some basic tests that
# interface parsing worked OK

use strict;
use Wx;
use lib './t';
use Tests_Helper 'test_frame';

package MyFrame;

use base 'Wx::Frame';
use Test::More 'tests' => 1;

sub new {
my $this = shift->SUPER::new( undef, -1, 'Test Frame' );

# we don't use Frame for Wx::Button::GetDefaultSize test
# but perhaps we will add more tests in future

# button GetDefaultSize ----------------------
my $buttonsize = undef;
eval {
    my $wxbsize = Wx::Button::GetDefaultSize;
    $buttonsize = $wxbsize->x;
};

ok(defined($buttonsize), 'Interface Wx::Button::GetDefaultSize');


return $this;
};

package main;

test_frame( 'MyFrame', 1 );
Wx::wxTheApp()->MainLoop();

# local variables:
# mode: cperl
# end:
