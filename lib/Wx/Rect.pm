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
use Carp;

sub new {
  shift;

  Wx::_match( @_, $Wx::_n_n_n_n, 4 )   && return Wx::Rect::newXYWH( @_ );
  Wx::_match( @_, $Wx::_wpoi_wsiz, 2 ) && return Wx::Rect::newPS( @_ );
  Wx::_match( @_, $Wx::_wpoi_wpoi, 2 ) && return Wx::Rect::newPP( @_ );
  croak Wx::_ovl_error 'Wx::Rect::new';
}

1;

# Local variables: #
# mode: cperl #
# End: #
