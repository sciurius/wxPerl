#############################################################################
## Name:        StaticBitmap.pm
## Purpose:     Wx::StaticBitmap class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::StaticBitmap;

use strict;

sub new {
  if( $_[3]->isa( 'Wx::Icon' ) ) { return Wx::StaticBitmap::newIcon( @_ ) }
  else { return Wx::StaticBitmap::newBitmap( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
