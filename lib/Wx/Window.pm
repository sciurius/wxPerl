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

*Wx::Window::Center = \&Wx::Window::Centre;
*Wx::Window::CenterOnParent = \&Wx::Window::CentreOnParent;
*Wx::Window::CenterOnScreen = \&Wx::Window::CentreOnScreen;

sub SetToolTip {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wtip, 1 ) && ( $this->SetToolTipTip( @_ ), return );
  Wx::_match( @_, $Wx::_s, 1 )    && ( $this->SetToolTipString( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

sub ClientToScreen {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->ClientToScreenXY( @_ );
  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->ClientToScreenPoint( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub ConvertDialogToPixels {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->ConvertDialogPointToPixels( @_ );
  Wx::_match( @_, $Wx::_wsiz, 1 ) && return $this->ConvertDialogSizeToPixels( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub ConvertPixelsToDialog {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->ConvertPixelsPointToDialog( @_ );
  Wx::_match( @_, $Wx::_wsiz, 1 ) && return $this->ConvertPixelsSizeToDialog( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub IsExposed {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 )    && return $this->IsExposedPoint( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 )    && return $this->IsExposedRect( @_ );
  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && return $this->IsExposedXYWH( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub Move {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && ( $this->MovePoint( @_ ), return );
  Wx::_match( @_, $Wx::_n_n, 2 )  && ( $this->MoveXY( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

sub PopupMenu {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->PopupMenuPoint( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->PopupMenuXY( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub ScreenToClient {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->ScreenToClientPoint( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->ScreenToClientXY( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub SetClientSize {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && return $this->SetClientSizePoint( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return $this->SetClientSizeWH( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub SetSize {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n_n, 4, 1 ) && ( $this->SetSizeXYWHF( @_ ), return );
  Wx::_match( @_, $Wx::_n_n, 2 )          && ( $this->SetSizeWH( @_ ), return );
  Wx::_match( @_, $Wx::_wsiz, 1 )         && ( $this->SetSizeSize( @_ ), return );
  Wx::_match( @_, $Wx::_wrec, 1 )         && ( $this->SetSizeRect( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
