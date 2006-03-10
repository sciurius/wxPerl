#############################################################################
## Name:        ext/media/lib/Wx/Media.pm
## Purpose:     Wx::Media (pulls in Wx::MediaCtrl)
## Author:      Mattia Barbon
## Modified by:
## Created:     04/03/2006
## RCS-ID:      $Id: Media.pm,v 1.1 2006/03/10 19:25:34 mbarbon Exp $
## Copyright:   (c) 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Media;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::load_dll( 'media' );
Wx::wx_boot( 'Wx::Media', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::MediaCtrl; @ISA = qw(Wx::Control);

use strict;

1;
