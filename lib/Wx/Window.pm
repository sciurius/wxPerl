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
use Carp;

*Wx::Window::Center = \&Wx::Window::Centre;
*Wx::Window::CenterOnParent = \&Wx::Window::CentreOnParent;
*Wx::Window::CenterOnScreen = \&Wx::Window::CentreOnScreen;

sub SetToolTip {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wtip, 1 ) && ( $this->SetToolTipTip( @_ ), return );
  Wx::_match( @_, $Wx::_s, 1 )    && ( $this->SetToolTipString( @_ ), return );
  croak Wx::_ovl_error 'Wx::Window::SetToolTip';
}

sub ClientToScreen {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->ClientToScreenXY( @_ );
  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->ClientToScreenPoint( @_ );
  croak Wx::_ovl_error 'Wx::Window::ClientToScreen';
}

sub ConvertDialogToPixels {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->ConvertDialogPointToPixels( @_ );
  Wx::_match( @_, $Wx::_wsiz, 1 ) && return $this->ConvertDialogSizeToPixels( @_ );
  croak Wx::_ovl_error 'Wx::Window::ConvertDialogToPixels';
}

sub ConvertPixelsToDialog {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->ConvertPixelsPointToDialog( @_ );
  Wx::_match( @_, $Wx::_wsiz, 1 ) && return $this->ConvertPixelsSizeToDialog( @_ );
  croak Wx::_ovl_error 'Wx::Window::ConvertPixelsToDialog';
}

sub IsExposed {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 )    && return $this->IsExposedPoint( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->IsExposedRect( @_ );
  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->IsExposedXYWH( @_ );
  croak Wx::_ovl_error 'Wx::Window::IsExposed';
}

sub Move {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->MovePoint( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->MoveXY( @_ );
  croak Wx::_ovl_error 'Wx::Window::Move';
}

sub PopupMenu {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->PopupMenuPoint( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->PopupMenuXY( @_ );
  croak Wx::_ovl_error 'Wx::Window::PopupMenu';
}

sub ScreenToClient {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->ScreenToClientPoint( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->ScreenToClientXY( @_ );
  croak Wx::_ovl_error 'Wx::Window::ScreenToClient';
}

sub SetClientSize {
  my( $this ) = @_;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->SetClientSizePoint( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->SetClientSizeWH( @_ );
  croak Wx::_ovl_error 'Wx::Window::SetClientSize';
}

sub SetSize {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n_n, 4, 1 ) && ( $this->SetSizeXYWHF( @_ ), return );
  Wx::_match( @_, $Wx::_n_n, 2 )          && ( $this->SetSizeWH( @_ ), return );
  Wx::_match( @_, $Wx::_wsiz, 1 )         && ( $this->SetSizeSize( @_ ), return );
  Wx::_match( @_, $Wx::_wrec, 1 )         && ( $this->SetSizeRect( @_ ), return );
  croak Wx::_ovl_error 'Wx::Window::SetSize';
}

1;

# Local variables: #
# mode: cperl #
# End: #
