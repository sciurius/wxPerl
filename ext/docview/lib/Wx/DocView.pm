#############################################################################
## Name:        DocView.pm
## Purpose:     Wx::DocView
## Author:      Simon Flack
## Modified by:
## Created:     11/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2002 Simon Flack
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::DocView;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::DocView', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::DocManager;                 @ISA = qw(Wx::EvtHandler);
package Wx::View;                       @ISA = qw(Wx::EvtHandler);
package Wx::Document;                   @ISA = qw(Wx::EvtHandler);
package Wx::DocPrintout;                @ISA = qw(Wx::Printout);
package Wx::DocChildFrame;              @ISA = qw(Wx::Frame);
package Wx::DocParentFrame;             @ISA = qw(Wx::Frame);
package Wx::DocMDIChildFrame;           @ISA = qw(Wx::MDIChildFrame);
package Wx::DocMDIParentFrame;          @ISA = qw(Wx::MDIParentFrame);

1;

# Local variables: #
# mode: cperl #
# End: #
