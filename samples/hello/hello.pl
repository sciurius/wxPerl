#!/usr/bin/perl
#############################################################################
## Name:        hello.pl
## Purpose:     Hello wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:      2/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Wx;

# every program must have a Wx::App-derive class
package MyApp;

use vars qw(@ISA);

@ISA = qw(Wx::App);

# this is called automatically on object creation
sub OnInit {
  my( $this ) = shift;

  # create a new frame
  my( $frame ) = MyFrame->new();

  # set as top frame
  $this->SetTopWindow( $frame );
  # show it
  $frame->Show( 1 );
}

package MyFrame;

use vars qw(@ISA);

@ISA = qw(Wx::Frame);

use Wx::Event qw(EVT_PAINT);
# this imports some constants
use Wx qw(wxDECORATIVE wxNORMAL wxBOLD);
use Wx qw(wxDefaultPosition);
use Wx qw(wxWHITE);

sub new {
  # new frame with no parent, id -1, title 'Hello, world!'
  # default position and size 350, 100
  my( $this ) = shift->SUPER::new( undef, -1, 'Hello, world!',
                                   wxDefaultPosition , [350, 100] );

  # create a new font object and store it
  $this->{FONT} = Wx::Font->new( 40, wxDECORATIVE, wxNORMAL, wxBOLD, 0 );
  # set background colour
  $this->SetBackgroundColour( wxWHITE );

  # declare that all paint events will be handled with the OnPaint method
  EVT_PAINT( $this, \&OnPaint );

  return $this;
}

sub OnPaint {
  my( $this, $event ) = @_;
  # create a device context (DC) used for drawing
  my( $dc ) = Wx::PaintDC->new( $this );

  # select the font
  $dc->SetFont( $this->font );
  # darw a friendly message
  $dc->DrawText( 'Hello, world!', 10, 10 );
}

sub font {
  $_[0]->{FONT};
}

package main;

# create an instance of the Wx::App-derived class
my( $app ) = MyApp->new();
# start processing events
$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
