#############################################################################
## Name:        DC.pm
## Purpose:     Wx::DC class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::DC;

use strict;

sub DrawCheckMark {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && ( $this->DrawCheckMarkXYWH( @_ ), return );
  Wx::_match( @_, $Wx::_wrec, 1 )    && ( $this->DrawCheckMarkRect( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

sub SetClippingRegion {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 ) && ( $this->SetClippingRegionXYWH( @_ ), return );
  Wx::_match( @_, $Wx::_wreg, 1 )  && ( $this->SetClippingRegionRegion( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
