#!/usr/bin/perl -w

use lib '../../../lib';
use Test::More 'tests' => 5;

use Wx::Perl::SplashFast '../../../demo/data/logo.jpg', 400;

package myApp;

use base 'Wx::App';

sub OnInit {
  my $this = shift;

  $this->{FOO} = 'bar';
  main::ok( 1, "OnInit was called" ); # OnInit called
}

package main;

use Wx 'wxTheApp';

ok( 1, "compilation OK" ); # got there

my $app = myApp->new;

isa_ok( $app, 'myApp' );
is( $app->{FOO}, 'bar', "fields are preserved" );
is( wxTheApp, $app, "wxTheApp and myApp->new return the same value" );

Wx::WakeUpIdle();
wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
