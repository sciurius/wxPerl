#!/usr/bin/perl
#############################################################################
## Name:        dialog.pl
## Purpose:     Dialog wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     12/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyApp;

use strict;
use vars qw(@ISA);

@ISA=qw(Wx::App);

use Wx qw(wxDefaultSize wxDefaultPosition);

sub OnInit {
  my( $this ) = @_;

  my( $dialog ) = MyDialog->new( "wxPerl dialog sample",
                                 wxDefaultPosition,
                               );

  $this->SetTopWindow( $dialog );

  $dialog->Show( 1 );

  1;
}

package MyDialog;

use strict;
use vars qw(@ISA);

@ISA=qw(Wx::Dialog);

use Wx::Event qw(EVT_CLOSE EVT_BUTTON);
use Wx qw(wxDefaultSize wxDefaultValidator);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], [250, 110] );

  my( $ct ) = $this->{CELSIUS} =
    Wx::TextCtrl->new( $this, -1, '0', [20, 20], [100, -1] );
  my( $cb ) = Wx::Button->new( $this, -1, 'Celsius', [130, 20] );
  my( $ft ) = $this->{FAHRENHEIT} = 
    Wx::TextCtrl->new( $this, -1, '32', [20, 50], [100, -1] );
  my( $fb ) = Wx::Button->new( $this, -1, 'Fahrenheit', [130, 50] );

  EVT_BUTTON( $this, $cb, \&CelsiusToFahrenheit );
  EVT_BUTTON( $this, $fb, \&FahrenheitToCelsius );

  EVT_CLOSE( $this, \&OnClose );

  $this;
}

sub CelsiusToFahrenheit {
  my( $this, $event ) = @_;

  $this->{FAHRENHEIT}->SetValue( ( $this->{CELSIUS}->GetValue() / 
                                   100.0 ) * 180 + 32 );
}

sub FahrenheitToCelsius {
  my( $this, $event ) = @_;

  $this->{CELSIUS}->SetValue( ( ( $this->{FAHRENHEIT}->GetValue()-32 ) / 
                                180.0 ) * 100 );
}

sub OnClose {
  my( $this, $event ) = @_;

  $this->Destroy();
}

package main;

my( $app ) = MyApp->new();

$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
