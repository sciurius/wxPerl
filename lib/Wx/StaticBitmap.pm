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
use Carp;

sub new {
  Wx::_match( @_, $Wx::_s_wwin_n_wico, 3, 1 ) && return Wx::StaticBitmap::newIcon( @_ );
  Wx::_match( @_, $Wx::_s_wwin_n_wbmp, 3, 1 ) &&
      return Wx::StaticBitmap::newBitmap( @_ );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
