#############################################################################
## Name:        Brush.pm
## Purpose:     Wx::Brush class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Brush;

use strict;

sub new {
  shift;

  Wx::_match( @_, $Wx::_wbmp, 1 )   && return Wx::Brush::newBitmap( @_ );
  Wx::_match( @_, $Wx::_wcol_n, 2 ) && return Wx::Brush::newColour( @_ );
  Wx::_match( @_, $Wx::_s_n, 2 )    && return Wx::Brush::newName( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub SetColour {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n_n, 3 ) && ( $this->SetColourRGB( @_ ), return );
  Wx::_match( @_, $Wx::_wcol, 1 )  && ( $this->SetColourColour( @_ ), return );
  Wx::_match( @_, $Wx::_s, 1 )     && ( $this->SetColourName( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
