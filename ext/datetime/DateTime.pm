#############################################################################
## Name:        DateTime.pm
## Purpose:     Wx::DateTime
## Author:      Mattia Barbon
## Modified by:
## Created:     22/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::DateTime;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::DateTime', $VERSION );

#
# properly setup inheritance tree
#

no strict;

1;

# local variables:
# mode: cperl
# end:
