#############################################################################
## Name:        Cursor.pm
## Purpose:     Wx::Cursor class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Cursor;

use strict;

sub new {
  shift;
  if( @_ == 1 ) { return Wx::Cursor::newId( @_ ) }
  else { return Wx::Cursor::newFile( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
