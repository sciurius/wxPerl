#############################################################################
## Name:        ListCtrl.pm
## Purpose:     Wx::ListCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ListCtrl;

use strict;
use Carp;

*Wx::ListCtrl::InsertStringImageItem = \&InsertImageStringItem;

sub InsertColumn {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_wlci, 2 )     && return $this->InsertColumnInfo( @_ );
  Wx::_match( @_, $Wx::_n_s_n_n, 2, 1 ) && return $this->InsertColumnString( @_ );
  croak Wx::_ovl_error;
}

sub SetItem {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wlci, 1 )       && return $this->SetItemInfo( @_ );
  Wx::_match( @_, $Wx::_n_n_s_n, 3, 1 ) && return $this->SetItemString( @_ );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
