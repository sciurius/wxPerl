#############################################################################
## Name:        Caret.pm
## Purpose:     Wx::Caret classes
## Author:      Mattia Barbon
## Modified by:
## Created:     29/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Caret;

use strict;
use Carp;

sub new {
  shift;

  Wx::_match( @_, $Wx::_wwin_n_n, 3 ) && return Wx::Caret::newWH( @_ );
  Wx::_match( @_, $Wx::_wwin_wsiz, 2 ) && return Wx::Caret::newSize( @_ );
  croak Wx::_ovl_error;
}

sub Move {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wpoi, 1 ) && ( $this->MovePoint( @_ ), return );
  Wx::_match( @_, $Wx::_n_n, 2 )  && ( $this->MoveXY( @_ ), return );
  croak Wx::_ovl_error;
}

sub SetSize {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wsiz, 1 ) && ( $this->SetSizeSize( @_ ), return );
  Wx::_match( @_, $Wx::_n_n, 2 )  && ( $this->SetSizeWH( @_ ), return );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #


