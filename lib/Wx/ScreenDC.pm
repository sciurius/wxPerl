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

use UNIVERSAL qw(isa);

sub StartDrawingOnTop {
  my( $this ) = shift;

  if( isa( $_[1], 'Wx::Window' ) ) { return $this->StartDrawingOnTopWindow( @_ ) }
  else { return $this->StartDrawingOnTopRect( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
