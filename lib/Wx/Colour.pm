#############################################################################
## Name:        Colour.pm
## Purpose:     Wx::Colour class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Colour;

use strict;

sub new {
  shift;
  if( @_ == 3 ) { return Wx::Colour::newRGB( @_ ) }
  else { return Wx::Colour::newName( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
