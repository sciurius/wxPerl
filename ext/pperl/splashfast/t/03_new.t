#!/usr/bin/perl -w

use lib '../../../t';
use Test::More ( $^O eq 'MSWin32' && $] == 5.008000 ) ?
               ( 'skip_all' => 'Bug with Win32 WM_TIMER handling in 5.8.0' ) :
               ( 'tests' => 2 );

use Wx::Perl::SplashFast;

BEGIN {
  my $splash = Wx::Perl::SplashFast->new( '../../../wxpl.xpm', 1200 );
  isa_ok( $splash, 'Wx::SplashScreen' );
}

use Wx 'wxTheApp';

ok( 1, "compilation OK" );

use Tests_Helper 'app_timeout';

app_timeout( 500 );
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
