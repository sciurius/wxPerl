#############################################################################
## Name:        ext/print/lib/Wx/Print.pm
## Purpose:     Wx::Print ( pulls in all Print framework )
## Author:      Mattia Barbon
## Modified by:
## Created:     04/05/2001
## RCS-ID:      $Id: Print.pm,v 1.9 2004/03/01 21:24:10 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Print;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::Print', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::PageSetupDialog;    @ISA = qw(Wx::Dialog);
package Wx::PrintDialog;  @ISA = qw(Wx::Dialog);
package Wx::GenericPageSetupDialog; @ISA = qw(Wx::Dialog);
package Wx::GenericPrintDialog; @ISA = qw(Wx::Dialog);
package Wx::PrinterDC;    @ISA = qw(Wx::DC);
package Wx::PreviewControlBar; @ISA = qw(Wx::Window);
package Wx::PreviewCanvas; @ISA = qw(Wx::Window);
package Wx::PrintDialog;  @ISA = qw(Wx::Dialog);
package Wx::PreviewFrame; @ISA = qw(Wx::Frame);
package Wx::WindowsPrintPreview; @ISA = qw(Wx::PrintPreview);
package Wx::PostScriptPrintPreview; @ISA = qw(Wx::PrintPreview);
package Wx::WindowsPrinter; @ISA = qw(Wx::Printer);
package Wx::PostScriptPrinter; @ISA = qw(Wx::Printer);
package Wx::PostScriptDC; @ISA = qw(Wx::DC);

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #
