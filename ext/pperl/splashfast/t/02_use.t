#!/usr/bin/perl -w

use lib '../../../build';
use Test::More 'tests' => 1;

use Wx::Perl::SplashFast '../../../demo/data/logo.jpg', 400;
use Wx 'wxTheApp';

ok( 1, "use Splashfast with arguments" );

Wx::WakeUpIdle();
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
