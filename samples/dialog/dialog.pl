#!/usr/bin/perl -w
#############################################################################
## Name:        samples/dialog/dialog.pl
## Purpose:     Dialog wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     12/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000, 2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyDialog;

use strict;
use base qw(Wx::Dialog);

use Wx::Event qw(EVT_CLOSE EVT_BUTTON);
use Wx qw(wxDefaultSize wxDefaultValidator);

sub new {
    my( $class, $label ) = @_;
    my $this = $class->SUPER::new( undef, -1, $label, [-1, -1], [250, 110] );

    $this->SetIcon( Wx::GetWxPerlIcon() );

    # absolute positioning is bad
    my $ct = $this->{celsius} =
      Wx::TextCtrl->new( $this, -1, '0', [20, 20], [100, -1] );
    my $cb = Wx::Button->new( $this, -1, 'To Fahrenheit', [130, 20] );
    my $ft = $this->{fahrenheit} =
      Wx::TextCtrl->new( $this, -1, '32', [20, 50], [100, -1] );
    my $fb = Wx::Button->new( $this, -1, 'To Celsius', [130, 50] );

    EVT_BUTTON( $this, $cb, \&CelsiusToFahrenheit );
    EVT_BUTTON( $this, $fb, \&FahrenheitToCelsius );
    EVT_CLOSE( $this, \&OnClose );

    return $this;
}

sub CelsiusToFahrenheit {
    my( $this, $event ) = @_;

    $this->fahrenheit->SetValue( ( $this->celsius->GetValue /
                                   100.0 ) * 180 + 32 );
}

sub FahrenheitToCelsius {
    my( $this, $event ) = @_;

    $this->celsius->SetValue( ( ( $this->fahrenheit->GetValue - 32 ) /
                                180.0 ) * 100 );
}

sub OnClose {
    my( $this, $event ) = @_;

    $this->Destroy;
}

sub fahrenheit { $_[0]->{fahrenheit} }
sub celsius    { $_[0]->{celsius} }

package main;

my $app = Wx::SimpleApp->new;
my $dialog = MyDialog->new( "wxPerl dialog sample" );
$dialog->Show;
$app->MainLoop;
