#############################################################################
## Name:        Menu.pm
## Purpose:     Wx::Menu class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Menu;

use strict;
use Carp;

sub Append {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_s_wmen, 3, 1 ) && ( $this->AppendSubMenu( @_ ), return );
  Wx::_match( @_, $Wx::_n_s, 2, 1 )      && ( $this->AppendString( @_ ), return );
  Wx::_match( @_, $Wx::_wmit, 1 )        && ( $this->AppendItem( @_ ), return );
  croak Wx::_ovl_error;
}

sub Delete {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wmit, 1 ) && ( $this->DeleteItem( @_ ), return );
  Wx::_match( @_, $Wx::_n, 1 )    && ( $this->DeleteId( @_ ), return );
  croak Wx::_ovl_error;
}

sub Destroy {
  my( $this ) = shift;

  @_ == 0                     && ( $this->DestoryMenu(), return );
  Wx::_match( @_, $Wx::_wmit, 1 ) && ( $this->DestroyItem( @_ ), return );
  Wx::_match( @_, $Wx::_n, 1 )    && ( $this->DestroyId( @_ ), return );
  croak Wx::_ovl_error;
}

sub Remove {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wmit, 1 ) && return $this->RemoveItem( @_ );
  Wx::_match( @_, $Wx::_n, 1 )    && return $this->RemoveId( @_ );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
