#############################################################################
## Name:        XRC.pm
## Purpose:     Wx::XRC ( pulls in all wxWindows XML Resources )
## Author:      Mattia Barbon
## Modified by:
## Created:     27/ 7/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::XRC;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::XRC', $VERSION );

# init wxModules
Wx::XmlInitXmlModule();
Wx::XmlInitResourceModule();

*Wx::XmlResource::GetXMLID = \&Wx::XmlResource::GetXRCID;

#
# properly setup inheritance tree
#

no strict;

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #

