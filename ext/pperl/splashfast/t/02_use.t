#!/usr/bin/perl -w

use lib '../../../t';
use Test::More ( $^O eq 'MSWin32' && $] == 5.008000 ) ?
               ( 'skip_all' => 'Bug with Win32 WM_TIMER handling in 5.8.0' ) :
               ( 'tests' => 1 );

use Wx::Perl::SplashFast '../../../demo/data/logo.jpg', 800;
use Wx 'wxTheApp';

ok( 1, "use Splashfast with arguments" );

use Tests_Helper qw(app_timeout);

app_timeout( 500 );
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
