#############################################################################
## Name:        Rect.pm
## Purpose:     Wx::Rect class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Rect;

use strict;

sub new {
  shift;
  if( @_ == 4 ) { return Wx::Rect::newXYWH( @_ ) }
  elsif( $_[1]->isa( 'Wx::Size' ) ) { return Wx::Rect::newPS( @_ ) }
  else { return Wx::Rect::newPP( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
