#############################################################################
## Name:        ScreenDC.pm
## Purpose:     Wx::ScreenDC class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ScreenDC;

use strict;
use Carp;

sub StartDrawingOnTop {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wwin, 1 ) && return $this->StartDrawingOnTopWindow( @_ );
  Wx::_match( @_, $Wx::_wrec, 1 ) && return $this->StartDrawingOnTopRect( @_ );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
