#!/usr/bin/perl -w

use Test;
BEGIN { plan tests => 1 }

use Wx::Perl::SplashFast '../../../demo/data/logo.jpg', 100;
use Wx 'wxTheApp';

ok( 1 );

Wx::WakeUpIdle();
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
