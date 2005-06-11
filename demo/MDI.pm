#############################################################################
## Name:        demo/MDI.pm
## Purpose:     MDI ( Multiple Document Interface ) Demo
## Author:      Mattia Barbon
## Modified by:
## Created:     17/09/2001
## RCS-ID:      $Id: MDI.pm,v 1.6 2005/06/11 06:43:57 mbarbon Exp $
## Copyright:   (c) 2001, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::MDI;

package MDIDemo;

sub window {
  my( $this, $parent ) = @_;

  my $mdi = MDIDemoWindow->new( $parent, -1, 'wxPerl MDI demo' );
  $mdi->SetSize( 500, 400 );
  $mdi->Show( 1 );

  return undef;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Multiple Document Interface</title>
</head>
<body>
<h3>Multiple Document Interface</h3>

<p>
  MDI (Multiple Document Interface) is an interface style used by mani
  popular Windows programs. Under other platforms it is emulated using
  a Wx::Notebook.
</p>

</body>
</html>
EOT
}

package MDIDemoWindow;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::MDIParentFrame);
use Wx qw( :misc :textctrl :window :frame );

my( $ID_ACT_PREVIOUS, $ID_ACT_NEXT,
    $ID_ARRANGE, $ID_TILE, $ID_CASCADE, $ID_CREATE_CHILD, $ID_CLOSE ) = 
  ( 2000 .. 3000 );

use Wx::Event qw(EVT_MENU EVT_CLOSE EVT_SIZE);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_,  wxDefaultPosition, wxDefaultSize, 
                                 wxDEFAULT_FRAME_STYLE | wxHSCROLL | 
                                 wxVSCROLL| wxNO_FULL_REPAINT_ON_RESIZE );

  my $file = Wx::Menu->new;
  $file->Append( $ID_CREATE_CHILD, "Create a new child" );
  $file->AppendSeparator;
  $file->Append( $ID_CLOSE, "Close frame" );

  $this->{'help'} = new Wx::TextCtrl($this, -1, "A help Window",
                                     wxDefaultPosition, wxDefaultSize,
                                     wxTE_MULTILINE | wxSUNKEN_BORDER);

  #my $childs = Wx::Menu->new;
  #$childs->Append( $ID_ACT_PREVIOUS, "Activate previous" );
  #$childs->Append( $ID_ACT_NEXT, "Activate next" );

  #my $windows = Wx::Menu->new;
  #$windows->Append( $ID_ARRANGE, "Arrange icons" );
  #$windows->Append( $ID_CASCADE, "Cascade" );
  #$windows->Append( $ID_TILE, "Tile" );

  my $bar = Wx::MenuBar->new;
  $bar->Append( $file, "File" );
  #$bar->Append( $childs, "Childs" );
  #$bar->Append( $windows, "Windows" );

  $this->SetMenuBar( $bar );

  EVT_MENU( $this, $ID_CREATE_CHILD, \&OnCreateChild );
  EVT_MENU( $this, $ID_CLOSE, \&OnClose );
  EVT_SIZE( $this, \&OnSize );
  # this is necessary otherwise the default handler
  # will Destroy the window and crash the demo
  # that tries to use it subsequently
  EVT_CLOSE( $this, \&OnClose );

  return $this;
}

sub OnCreateChild {
  my( $this, $event ) = @_;

  my $child = Wx::MDIChildFrame->new( $this, -1, "I'm a child" );
}

sub OnClose {
  my( $this, $event ) = @_;

  $this->Show( 0 );
  # this is taken care by the demo
  #$this->Destroy;

  $event->Skip;
}

sub OnSize {
  my( $this, $event ) = @_;

  my( $x, $y ) = $this->GetClientSizeXY();
  my $client_window = $this->GetClientWindow();
  $client_window->SetSize( 200, 0, $x - 200, $y);
  $this->{'help'}->SetSize( 0, 0, 200, $y);

  $event->Skip;
}

1;

# Local variables: #
# mode: cperl #
# End: #

