#############################################################################
## Name:        ComboBox.pm
## Purpose:     Wx::ComboBox class
## Author:      Mattia Barbon
## Modified by:
## Created:      8/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ComboBox;

use strict;
use Carp;

sub Append {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_s, 1 )   && ( $this->AppendString( @_ ), return );
  Wx::_match( @_, $Wx::_s_s, 2 ) && ( $this->AppendData( @_ ), return );
  croak Wx::_ovl_error;
}

sub SetSelection {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n, 2 ) && ( $this->SetMark( @_ ), return );
  Wx::_match( @_, $Wx::_n, 1 )   && ( $this->SetSelectionN( @_ ), return );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
