#############################################################################
## Name:        Calendar.pm
## Purpose:     Wx::CalendarCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:      5/10/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Calendar;

use Wx::DateTime;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::Calendar', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::CalendarCtrl;  @ISA = 'Wx::Control';
package Wx::CalendarEvent; @ISA = 'Wx::CommandEvent';
1;

# local variables:
# mode: cperl
# end:
