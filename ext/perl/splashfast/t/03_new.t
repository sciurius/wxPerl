#!/usr/bin/perl -w

use Test;
BEGIN { plan tests => 2 }

use Wx::Perl::SplashFast;

BEGIN {
  my $splash = Wx::Perl::SplashFast->new( '../../../demo/data/logo.jpg', 100 );
  ok( defined $splash && ref $splash );
}

use Wx 'wxTheApp';

ok( 1 );

Wx::WakeUpIdle();
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
