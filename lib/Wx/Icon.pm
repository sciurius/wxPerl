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
#  if( 0 && $_[0] =~m/^\s*\d+\s*$/ ) { return Wx::Icon::newEmpty( @_ ) }
#  else { 
return Wx::Icon::newFile( @_ )
# }
}

1;

# Local variables: #
# mode: cperl #
# End: #
