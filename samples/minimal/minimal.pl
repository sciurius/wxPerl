#!/usr/bin/perl
#############################################################################
## Name:        minimal.pl
## Purpose:     Minimal wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

# every program must have a Wx::App-derive class
package MyApp;

use strict;
use vars qw(@ISA);

@ISA=qw(Wx::App);

# this is called automatically on object creation
sub OnInit {
  my( $this ) = @_;

  # create new MyFrame
  my( $frame ) = MyFrame->new( "Minimal wxPerl app",
			       Wx::Point->new( 50, 50 ),
			       Wx::Size->new( 450, 350 )
                             );

  # set it as top window (so the app will automatically close when
  # the last top window is closed)
  $this->SetTopWindow( $frame );
  # show the frame
  $frame->Show( 1 );

  1;
}

package MyFrame;

use strict;
use vars qw(@ISA);

@ISA=qw(Wx::Frame);

use Wx::Event qw(EVT_MENU);
use Wx qw(wxBITMAP_TYPE_ICO wxMENU_TEAROFF);

# Parameters: title, position, size
sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );

  # load an icon and set it as frame icon
  $this->SetIcon( Wx::GetWxPerlIcon() );

  # create the menus
  my( $mfile ) = Wx::Menu->new( undef, wxMENU_TEAROFF );
  my( $mhelp ) = Wx::Menu->new();

  my( $ID_ABOUT, $ID_EXIT ) = ( 1, 2 );
  $mhelp->Append( $ID_ABOUT, "&About...\tCtrl-A", "Show about dialog" );
  $mfile->Append( $ID_EXIT, "E&xit\tAlt-X", "Quit this program" );

  my( $mbar ) = Wx::MenuBar->new();

  $mbar->Append( $mfile, "&File" );
  $mbar->Append( $mhelp, "&Help" );

  $this->SetMenuBar( $mbar );

  # declare that events coming from menu items with the given
  # id will be handled by these routines
  EVT_MENU( $this, $ID_EXIT, \&OnQuit );
  EVT_MENU( $this, $ID_ABOUT, \&OnAbout );

  # create a status bar (note that the status bar that gets created
  # has three panes, see the OnCreateStatusBar callback below
  $this->CreateStatusBar( 2 );
  # and show a message
  $this->SetStatusText( "Welcome to wxWindows!", 1 );

  $this;
}

# this is an addition to demonstrate virtual callbacks...
# it ignores all parameters and creates a status bar with three fields
sub OnCreateStatusBar {
  my( $this ) = shift;
  my( $status ) = Wx::StatusBar->new( $this, -1 );

  $status->SetFieldsCount( 3 );

  $status;
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
  Wx::MessageBox( "This is the about dialog of minimal sample.\n" .
		  "Welcome to wxPerl " . $Wx::VERSION . "\n" .
		  wxVERSION_STRING,
		  "About minimal", wxOK | wxICON_INFORMATION,
		  $this );
}

package main;

# create an instance of the Wx::App-derived class
my( $app ) = MyApp->new();
# start processing events
$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
