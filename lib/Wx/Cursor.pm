#############################################################################
## Name:        Cursor.pm
## Purpose:     Wx::Cursor class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Cursor;

use strict;

sub new {
  shift;

  Wx::_match( @_, $Wx::_n, 1 )          && return Wx::Cursor::newId( @_ );
  Wx::_match( @_, $Wx::_wimg, 1 )       && return Wx::Cursor::newFile( @_ );
  Wx::_match( @_, $Wx::_s_n_n_n, 2, 1 ) && return Wx::Cursor::newFile( @_ );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
