#############################################################################
## Name:        ControlWithitems.pm
## Purpose:     Wx::ControlWithItems class
## Author:      Mattia Barbon
## Modified by:
## Created:      8/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ControlWithItems;

use strict;
use Carp;

sub Append {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_s_s, 2 ) && ( $this->AppendData( @_ ), return );
  Wx::_match( @_, $Wx::_s, 1 )   && ( $this->AppendString( @_ ), return );
  croak Wx::_ovl_error 'Wx::ControlWithItems::Append';
}

1;

# Local variables: #
# mode: cperl #
# End: #
