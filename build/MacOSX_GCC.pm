############################################################################
## Name:        MacOSX_GCC.pm
## Purpose:     build helper for Darwin ( Mac OS X )
## Author:      Mattia Barbon
## Modified by:
## Created:     10/11/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package MacOSX_GCC.pm;

use strict;
use wxMMUtils;
use base 'Any_wx_config';

#
# wx-config- like
#
sub my_wx_config {
  my $class = shift;
  my $result = $class->SUPER::my_wx_config( @_ );

  # MakeMaker does not like the "-framework foo" options
  $result =~ s/-framework\s+\w+//g
    if grep { $_ eq 'libs' } @_;

  return $result;
}

sub configure {
  my $this = shift;
  my $result = $this->SUPER::configure( @_ );

  # why this is necessary even when linking with "c++"
  # is totally beyond me
  $result->{LIBS} .= ' -lcc_dynamic ';

  return $result;
}

1;

# Local variables: #
# mode: cperl #
# End: #

