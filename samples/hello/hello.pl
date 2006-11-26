#!/usr/bin/perl -w
#############################################################################
## Name:        samples/hello/hello.pl
## Purpose:     Hello wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     02/11/2000
## RCS-ID:      $Id: hello.pl,v 1.4 2006/11/26 17:05:43 mbarbon Exp $
## Copyright:   (c) 2000, 2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyFrame;

use strict;
use base qw(Wx::Frame);

use Wx::Event qw(EVT_PAINT);
# this imports some constants
use Wx qw(wxDECORATIVE wxNORMAL wxBOLD);
use Wx qw(wxDefaultPosition);
use Wx qw(wxWHITE);

sub new {
    my( $class ) = @_;
    # new frame with no parent, id -1, title 'Hello, world!'
    # default position and size 350, 100
    my $this = $class->SUPER::new( undef, -1, 'Hello, world!',
                                   wxDefaultPosition , [350, 100] );

    # create a new font object and store it
    $this->{font} = Wx::Font->new( 40, wxDECORATIVE, wxNORMAL, wxBOLD, 0 );
    # set background colour
    $this->SetBackgroundColour( wxWHITE );

    $this->SetIcon( Wx::GetWxPerlIcon() );

    # declare that all paint events will be handled with the OnPaint method
    EVT_PAINT( $this, \&OnPaint );

    return $this;
}

sub OnPaint {
    my( $this, $event ) = @_;
    # create a device context (DC) used for drawing
    my $dc = Wx::PaintDC->new( $this );

    # select the font
    $dc->SetFont( $this->font );
    # draw a friendly message
    $dc->DrawText( 'Hello, world!', 10, 10 );
}

sub font { $_[0]->{font} }

package main;

my $app  = Wx::SimpleApp->new;
my $frame = MyFrame->new;
$frame->Show;
$app->MainLoop;
