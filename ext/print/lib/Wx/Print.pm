#############################################################################
## Name:        Print.pm
## Purpose:     Wx::Print ( pulls in all Print framework )
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 5/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Print;

use Wx;
use strict;

require DynaLoader;

use vars qw(@ISA $VERSION);

$VERSION = '0.01';

@ISA = qw(DynaLoader);

bootstrap Wx::Print;

#
# properly setup inheritance tree
#

no strict;

package Wx::PageSetupDialog;    @ISA = qw(Wx::Dialog);
package Wx::PrinterDC;    @ISA = qw(Wx::DC);
package Wx::PreviewControlBar; @ISA = qw(Wx::Window);
package Wx::PreviewCanvas; @ISA = qw(Wx::Window);
package Wx::PrintDialog;  @ISA = qw(Wx::Dialog);
package Wx::PreviewFrame; @ISA = qw(Wx::Frame);

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #
