#############################################################################
## Name:        STC.pm
## Purpose:     Wx::STC
## Author:      Mattia Barbon
## Modified by:
## Created:     23/ 5/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::STC;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::STC', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::StyledTextCtrl;   @ISA = qw(Wx::Control);

1;

# Local variables: #
# mode: cperl #
# End: #
