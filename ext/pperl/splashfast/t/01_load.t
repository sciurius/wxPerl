#!/usr/bin/perl -w

use Test::More ( $^O eq 'MSWin32' && $] == 5.008000 ) ?
               ( 'skip_all' => 'Bug with Win32 WM_TIMER handling in 5.8.0' ) :
               ( 'tests' => 1 );

use Wx::Perl::SplashFast;
use Wx;

ok( 1, "module compiles" );

# local variables:
# mode: cperl
# end:
