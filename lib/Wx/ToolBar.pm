#############################################################################
## Name:        ToolBar.pm
## Purpose:     Wx::ToolBar class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ToolBar;

use strict;

sub SetMargins {
  my( $this ) = shift;

  if( @_ == 1 ) { $this->SetMarginsSize( @_ ) }
  else { $this->SetMarginsXY( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
