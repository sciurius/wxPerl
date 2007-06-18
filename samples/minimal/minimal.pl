#!/usr/bin/perl -w
#############################################################################
## Name:        samples/minimal/minimal.pl
## Purpose:     Minimal wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000, 2004, 2005, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyFrame;

use strict;
use base qw(Wx::Frame);

use Wx::Event qw(EVT_MENU);

# Parameters: title, position, size
sub new {
  my( $class, $label ) = @_;
  my $this = $class->SUPER::new( undef, -1, $label );

  # load an icon and set it as frame icon
  $this->SetIcon( Wx::GetWxPerlIcon() );

  # create the menus
  my $mfile = Wx::Menu->new;
  my $mhelp = Wx::Menu->new;

  my( $ID_ABOUT, $ID_EXIT ) = ( 1, 2 );
  $mhelp->Append( $ID_ABOUT, "&About...\tCtrl-A", "Show about dialog" );
  $mfile->Append( $ID_EXIT, "E&xit\tAlt-X", "Quit this program" );

  my $mbar = Wx::MenuBar->new;

  $mbar->Append( $mfile, "&File" );
  $mbar->Append( $mhelp, "&Help" );

  $this->SetMenuBar( $mbar );

  # declare that events coming from menu items with the given
  # id will be handled by these routines
  EVT_MENU( $this, $ID_EXIT, \&OnQuit );
  EVT_MENU( $this, $ID_ABOUT, \&OnAbout );

  $this;
}

# called when the user selects the 'Exit' menu item
sub OnQuit {
    my( $this, $event ) = @_;

    # closes the frame
    $this->Close( 1 );
}

use Wx qw(wxOK wxICON_INFORMATION wxVERSION_STRING);

# called when the user selects the 'About' menu item
sub OnAbout {
    my( $this, $event ) = @_;

    # display a simple about box
    my $message = sprintf <<EOT, $Wx::VERSION, wxVERSION_STRING;
This is the about dialog of minimal sample.
Welcome to wxPerl %.02f
%s
EOT
    Wx::MessageBox( $message, "About minimal", wxOK | wxICON_INFORMATION,
                    $this );
}

package main;

# create an instance of the Wx::App-derived class
my $app = Wx::SimpleApp->new;
my $frame = MyFrame->new( "Minimal wxPerl app" );
$frame->Show;
$app->MainLoop;
