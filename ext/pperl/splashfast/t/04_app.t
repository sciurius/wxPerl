#!/usr/bin/perl -w

use Test;
BEGIN { plan tests => 5 }

use Wx::Perl::SplashFast '../../../demo/data/logo.jpg', 400;

package myApp;

use base 'Wx::App';

sub OnInit {
  my $this = shift;

  $this->{FOO} = 'bar';
  main::ok( 1 ); # OnInit called
}

package main;

use Wx 'wxTheApp';

ok( 1 ); # got there

my $app = myApp->new;

ok( 'myApp' eq ref $app );
ok( $app->{FOO} eq 'bar' );
ok( wxTheApp eq $app );

Wx::WakeUpIdle();
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
