#############################################################################
## Name:        Icon.pm
## Purpose:     Wx::Icon class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Icon;

use strict;

sub new {
  shift;

  @_ == 0                             && return Wx::Icon::newNull();
  Wx::_match( @_, $Wx::_s_n_n_n, 2, 1 )  && return Wx::Icon::newFile( @_ );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
