#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';
use Tests_Helper 'test_frame';

package MyFrame;

use base 'Wx::Frame';
use Test::More 'tests' => 8;

sub new {
my $this = shift->SUPER::new( undef, -1, 'a' );
# $class, @args
my( @tests ) = ( [ 'Wx::MessageDialog', [ $this, 'dummy' ] ],
                 [ 'Wx::Wizard',        [ $this ] ],
                 [ 'Wx::WizardPage',    [ Wx::Wizard->new( $this ) ] ],
                 [ 'Wx::WizardPageSimple', [ Wx::Wizard->new( $this ) ] ],
                );

foreach my $t ( @tests ) {
  my $class = ${$t}[0];
  my @args = @{${$t}[1]};

  my $obj = $class->new( @args );
  isa_ok( $obj, $class, "$class: new returns an object of the correct class" );

  $obj->Destroy();
  ok( 1, "    got there after $class->Destroy" );
}

Wx::Event::EVT_IDLE( $this,
                     sub { $this->Destroy } );
$this->Destroy if Wx::wxMSW || Wx::wxGTK;
};

package main;

test_frame( 'MyFrame' );
Wx::wxTheApp()->MainLoop();

# local variables:
# mode: cperl
# end:
