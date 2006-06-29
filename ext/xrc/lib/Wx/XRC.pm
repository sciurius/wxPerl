#############################################################################
## Name:        ext/xrc/lib/Wx/XRC.pm
## Purpose:     Wx::XRC (pulls in all wxWidgets XML Resources)
## Author:      Mattia Barbon
## Modified by:
## Created:     27/07/2001
## RCS-ID:      $Id: XRC.pm,v 1.13 2006/06/29 20:57:52 mbarbon Exp $
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::XRC;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::load_dll( 'xml' );
Wx::load_dll( 'html' );
Wx::load_dll( 'adv' );
Wx::load_dll( 'xrc' );
Wx::wx_boot( 'Wx::XRC', $VERSION );

# init wxModules
Wx::XmlInitXmlModule();
Wx::XmlInitResourceModule();

*Wx::XmlResource::GetXMLID = \&Wx::XmlResource::GetXRCID;

# Wx::XmlResource::AddSubclassFactory( Wx::XmlSubclassFactory->new );

#
# properly setup inheritance tree
#

no strict;

package Wx::PlXmlResourceHandler; @ISA = qw(Wx::XmlResourceHandler);
package Wx::PliXmlSubclassFactory; @ISA = qw(Wx::XmlSubclassFactory);

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #

