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
use UNIVERSAL qw(isa);

sub SetClippingRegion {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Region' ) ) { $this->SetClippingRegionRegion( @_ ) }
  else { $this->SetClippingRegionXYWH( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
