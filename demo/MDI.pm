#############################################################################
## Name:        MDI.pm
## Purpose:     MDI ( Multiple Document Interface ) Demo
## Author:      Mattia Barbon
## Modified by:
## Created:     17/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::MDI;

package MDIDemo;

sub window {
  my( $this, $parent ) = @_;

  return MDIDemoWindow->new( $parent, -1, 'wxPerl MDI demo' );
}

sub description {
  return <<EOT;
EOT
}

package MDIDemoWindow;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::MDIParentFrame);

my( $ID_ACT_PREVIOUS, $ID_ACT_NEXT,
    $ID_ARRANGE, $ID_TILE, $ID_CASCADE, $ID_CREATE_CHILD, $ID_CLOSE ) = 
  ( 2000 .. 3000 );

use Wx::Event qw(EVT_MENU EVT_CLOSE);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  my $file = Wx::Menu->new;
  $file->Append( $ID_CREATE_CHILD, "Create a new child" );
  $file->AppendSeparator;
  $file->Append( $ID_CLOSE, "Close frame" );

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
}

1;

# Local variables: #
# mode: cperl #
# End: #

