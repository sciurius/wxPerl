#!/usr/bin/perl -w

use Test::More ( $^O eq 'MSWin32' ) ?
               ( 'skip_all' => 'Test is fragile...' ) :
               ( 'tests' => 1 );

use Wx::Perl::SplashFast;
use Wx;

ok( 1, "module compiles" );

# local variables:
# mode: cperl
# end:
