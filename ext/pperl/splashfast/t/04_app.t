#!/usr/bin/perl -w

use lib '../../../t';
use Test::More ( $^O eq 'MSWin32' && $] == 5.008000 ) ?
               ( 'skip_all' => 'Bug with Win32 WM_TIMER handling in 5.8.0' ) :
               ( 'tests' => 5 );

use Wx::Perl::SplashFast '../../../demo/data/logo.jpg', 800;

package myApp;

use base 'Wx::App';

sub OnInit {
  my $this = shift;

  $this->{FOO} = 'bar';
  main::ok( 1, "OnInit was called" ); # OnInit called

  my $timer = Wx::Timer->new( $this );

  Wx::Event::EVT_TIMER( $this, -1, sub {
                          $this->ExitMainLoop;
                        } );

  $timer->Start( 500, 1 );
  Wx::WakeUpIdle;

  1;
}

package main;

use Wx 'wxTheApp';

ok( 1, "compilation OK" ); # got there

my $app = myApp->new;

isa_ok( $app, 'myApp' );
is( $app->{FOO}, 'bar', "fields are preserved" );
is( wxTheApp, $app, "wxTheApp and myApp->new return the same value" );

wxTheApp->MainLoop();

# local variables:
# mode: cperl
# end:
