#!/usr/bin/perl
#############################################################################
## Name:        samples/splitter/splitter.pl
## Purpose:     Wx::SplitterWindow wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     16/12/2000
## RCS-ID:      $Id: splitter.pl,v 1.3 2004/10/19 20:28:14 mbarbon Exp $
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyApp;

use vars qw(@ISA);

@ISA = qw(Wx::App);

sub OnInit {
  my( $this ) = shift;
  my( $frame ) = MyFrame->new( undef, 'Wx::SplitterWindow Example', [50,50],
                               [420, 300] );

  $frame->Show( 1 );
  $this->SetTopWindow( $frame );

  return 1;
}

package MySplitterWindow;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::SplitterWindow);

use Wx qw(:splitterwindow wxDefaultPosition wxDefaultSize);
use Wx::Event qw(EVT_SPLITTER_SASH_POS_CHANGED);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( @_, wxDefaultPosition, wxDefaultSize,
                                    wxSP_3D|wxSP_LIVE_UPDATE );

  $this->{FRAME} = $_[0];

  EVT_SPLITTER_SASH_POS_CHANGED( $this, $this, \&OnSashPositionChange );

  return $this;
}

sub OnSashPositionChange {
  my( $this, $event ) = @_;

  $this->{FRAME}->SetStatusText( sprintf 'Sash position = %d',
                                 $event->GetSashPosition() );
  $event->Skip();
}

package MyFrame;

use strict;
use vars qw(@ISA);
@ISA = qw(Wx::Frame);

use Wx qw(:colour :cursor);

my( $SPLIT_QUIT, $SPLIT_HORIZONTAL, $SPLIT_VERTICAL, $SPLIT_UNSPLIT,
    $SPLIT_SETMINSIZE ) = ( 1 .. 5 );

use Wx::Event qw(EVT_MENU EVT_UPDATE_UI);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( $_[0], -1, @_[1,2,3] );

  $this->CreateStatusBar( 2 );
  $this->SetIcon( Wx::GetWxPerlIcon() );

  my( $filemenu ) = Wx::Menu->new();
  $filemenu->Append( $SPLIT_VERTICAL, "Split &Vertically\tCtrl-V",
                     'Split Vertically' );
  $filemenu->Append( $SPLIT_HORIZONTAL, "Split &Horizontally\tCtrl-H",
                     'Split Horizontally' );
  $filemenu->Append( $SPLIT_UNSPLIT, "&Unsplit\tCtrl-U", 'Unsplit' );
  $filemenu->AppendSeparator();
  $filemenu->Append( $SPLIT_SETMINSIZE, "Set &min size", 
                     'Set minimum pane size' );
  $filemenu->AppendSeparator();
  $filemenu->Append( $SPLIT_QUIT, "E&xit\tAlt-X", 'Exit' );

  my( $menubar ) = Wx::MenuBar->new();
  $menubar->Append( $filemenu, '&File' );

  $this->SetMenuBar( $menubar );

  my( $splitter ) = $this->{SPLITTER} = MySplitterWindow->new( $this, -1 );
  my( $lcanvas ) = $this->{LEFTCANVAS} = MyCanvas->new( $splitter, -1,
                                                        [0,0], [400,400],
                                                        'Test1' );
  $lcanvas->SetBackgroundColour( wxRED );
  $lcanvas->SetScrollbars( 20, 20, 50, 50 );
  $lcanvas->SetCursor( Wx::Cursor->new( wxCURSOR_MAGNIFIER ) );

  my( $rcanvas ) = $this->{RIGHTCANVAS} = MyCanvas->new( $splitter, -1,
                                                         [0,0], [400,400],
                                                         'Test2' );
  $rcanvas->SetBackgroundColour( wxCYAN );
  $rcanvas->SetScrollbars( 20, 20, 50, 50 );
  $rcanvas->Show( 0 );

  $splitter->Initialize( $lcanvas );
  $this->SetStatusText( 'Min pane size = 0', 1 );

  EVT_MENU( $this, $SPLIT_HORIZONTAL, \&SplitHorizontal );
  EVT_MENU( $this, $SPLIT_QUIT, \&Quit );
  EVT_MENU( $this, $SPLIT_VERTICAL, \&SplitVertical );
  EVT_MENU( $this, $SPLIT_UNSPLIT, \&Unsplit );
  EVT_MENU( $this, $SPLIT_SETMINSIZE, \&SetMinSize );

  EVT_UPDATE_UI( $this, $SPLIT_HORIZONTAL, \&UpdateUIHorizontal );
  EVT_UPDATE_UI( $this, $SPLIT_VERTICAL, \&UpdateUIVertical );
  EVT_UPDATE_UI( $this, $SPLIT_UNSPLIT, \&UpdateUIUnsplit );

  return $this;
}

sub Quit {
  $_[0]->Close( 1 );
}

sub SplitHorizontal {
  my( $this, $event ) = @_;

  if( $this->{SPLITTER}->IsSplit() ) { $this->{SPLITTER}->Unsplit() }
  $this->{LEFTCANVAS}->Show( 1 );
  $this->{RIGHTCANVAS}->Show( 1 );
  $this->{SPLITTER}->SplitHorizontally( @{$this}{'LEFTCANVAS','RIGHTCANVAS'} );
  $this->UpdatePosition();
}

sub SplitVertical {
  my( $this, $event ) = @_;

  if( $this->{SPLITTER}->IsSplit() ) { $this->{SPLITTER}->Unsplit() }
  $this->{LEFTCANVAS}->Show( 1 );
  $this->{RIGHTCANVAS}->Show( 1 );
  $this->{SPLITTER}->SplitVertically( @{$this}{'LEFTCANVAS','RIGHTCANVAS'} );
  $this->UpdatePosition();
}

use Wx qw(wxSPLIT_HORIZONTAL wxSPLIT_VERTICAL);

sub UpdateUIHorizontal {
  my( $this, $event ) = @_;
  my( $s ) = $this->{SPLITTER};

  $event->Enable( !$s->IsSplit() || $s->GetSplitMode() != wxSPLIT_VERTICAL );
}

sub UpdateUIVertical {
  my( $this, $event ) = @_;
  my( $s ) = $this->{SPLITTER};

  $event->Enable( !$s->IsSplit() || $s->GetSplitMode() != wxSPLIT_HORIZONTAL );
}

sub UpdateUIUnsplit {
  my( $this, $event ) = @_;
  my( $s ) = $this->{SPLITTER};

  $event->Enable( $s->IsSplit() );
}

sub SetMinSize {
  my( $this, $event ) = @_;

  my( $size ) = Wx::GetNumberFromUser( 'Enter minimal size form panes:',
                                       '', '', $this->{SPLITTER}->GetMinimumPaneSize(), 0, 10000, $this );

  return if $size == -1;
  $this->{SPLITTER}->SetMinimumPaneSize( $size );
  $this->SetStatusText( "Min pane size = $size", 1 );
}

sub Unsplit {
  my( $this, $event ) = @_;

  if( $this->{SPLITTER}->IsSplit() ) { $this->{SPLITTER}->Unsplit() }
  $this->SetStatusText( 'No Splitter' );
}

sub UpdatePosition {
  my( $this ) = @_;

  $this->SetStatusText( sprintf 'Sash position = %d',
                        $this->{SPLITTER}->GetSashPosition() );
}

package MyCanvas;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::ScrolledWindow);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( @_[0,1,2,3], 0, $_[4] );

  return $this;
}

use Wx qw(wxBLACK_PEN wxTRANSPARENT wxRED_PEN wxGREEN_BRUSH
          wxNullPen wxNullBrush);

sub OnDraw {
  my( $this, $dc ) = @_;

  $dc->SetPen( wxBLACK_PEN );
  $dc->DrawLine( 0, 0, 100, 100 );

  $dc->SetBackgroundMode( wxTRANSPARENT );
  $dc->DrawText( 'Testing', 50, 50 );

  $dc->SetPen( wxRED_PEN );
  $dc->SetBrush( wxGREEN_BRUSH );
  $dc->DrawRectangle( 120, 120, 100, 80 );

  $dc->SetPen( wxNullPen );
  $dc->SetBrush( wxNullBrush );
}

package main;

my( $app ) = MyApp->new();
$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
