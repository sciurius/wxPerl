#############################################################################
## Name:        Windows.pm
## Purpose:     Wx::Window class
## Author:      Mattia Barbon
## Modified by:
## Created:     30/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Window;

use strict;

use UNIVERSAL qw(isa);

*Wx::Window::Center = \&Wx::Window::Centre;
*Wx::Window::CenterOnParent = \&Wx::Window::CentreOnParent;
*Wx::Window::CenterOnScreen = \&Wx::Window::CentreOnScreen;

sub SetToolTip {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::ToolTip' ) ) { return $this->SetToolTipTip( @_ ) }
  else { return $this->SetToolTipString( @_ ) }
}

sub ClientToScreen {
  my( $this ) = shift;

  if( @_ == 2 ) { return $this->ClientToScreenXY( @_ ) }
  else { return $this->ClientToScreenPoint( @_ ) }
}

sub ConvertDialogToPixels {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Point' ) ) { return $this->ConvertDialogPointToPixels( @_ ) }
  else { $this->ConverDialogSizeToPixels( @_ ) }
}

sub ConvertPixelsToDialog {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Point' ) ) { return $this->ConvertPixelsPointToDialog( @_ ) }
  else { return $this->ConvertPixelsSizeToDialog( @_ ) }
}

sub IsExposed {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Point' ) ) { return $this->IsExposedPoint( @_ ) }
  elsif( isa( $_[0], 'Wx::Rect' ) ) { return $this->IsExposedRect( @_ ) }
  else { return $this->IsExposedXYWH( @_ ) }
}

sub Move {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Point' ) ) { return $this->MovePoint( @_ ) }
  else { return $this->MoveXY( @_ ) }
}

sub PopupMenu {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Point' ) ) { return $this->PopupMenuPoint( @_ ) }
  else { return $this->PopupMenuXY( @_ ) }
}

sub ScreenToClient {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Point' ) ) { return $this->ScreenToClientPoint( @_ ) }
  else { return $this->ScreenToClientXY( @_ ) }
}

sub SetClientSize {
  my( $this ) = @_;

  if( isa( $_[0], 'Wx::Size' ) ) { return $this->SetSizeSize( @_ ) }
  else { return $this->SetSizeWH( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
