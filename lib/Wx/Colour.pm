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
use Carp;

sub new {
  shift;

  Wx::_match( @_, $Wx::_n_n_n, 3 ) && return Wx::Colour::newRGB( @_ );
  Wx::_match( @_, $Wx::_s, 1 )     && return Wx::Colour::newName( @_ );
  croak Wx::_ovl_error 'Wx::Colour::new';
}

1;

# Local variables: #
# mode: cperl #
# End: #
