#!/usr/bin/perl -w

use lib '../../../build';
use Test::More 'tests' => 1;

use Wx::Perl::SplashFast '../../../demo/data/logo.jpg', 400;
use Wx 'wxTheApp';

ok( 1, "use Splashfast with arguments" );

use Tests_Helper qw(app_timeout);

app_timeout( 500 );
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
