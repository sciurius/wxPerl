#############################################################################
## Name:        Print.pm
## Purpose:     Wx::XRC ( pulls in all wxWindows XML Resources )
## Author:      Mattia Barbon
## Modified by:
## Created:     27/ 7/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::XRC;

use Wx;
use strict;

require DynaLoader;

use vars qw(@ISA $VERSION);

$VERSION = '0.01';

@ISA = qw(DynaLoader);

bootstrap Wx::XRC;

# init wxModules
Wx::XmlInitXmlModule();
Wx::XmlInitResourceModule();

#
# properly setup inheritance tree
#

no strict;

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #

