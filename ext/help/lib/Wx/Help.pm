#############################################################################
## Name:        Help.pm
## Purpose:     Wx::Help ( pulls in all Wx::Help* stuff )
## Author:      Mattia Barbon
## Modified by:
## Created:     18/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Help;

use Wx;
use strict;

require DynaLoader;

use vars qw(@ISA $VERSION);

$VERSION = '0.01';

@ISA = qw(DynaLoader);

bootstrap Wx::Help;

#
# properly setup inheritance tree
#

no strict;

package Wx::WinHelpController;  @ISA = qw(Wx::HelpControllerBase);
package Wx::HelpControllerHtml; @ISA = qw(Wx::HelpControllerBase);
package Wx::CHMHelpController;  @ISA = qw(Wx::HelpControllerBase);
package Wx::ExtHelpController;  @ISA = qw(Wx::HelpControllerBase);
package Wx::BesthelpController; @ISA = qw(Wx::HelpController);

package Wx::ContextHelpButton;  @ISA = qw(Wx::BitmapButton);
package Wx::SimpleHelpProvider; @ISA = qw(Wx::HelpProvider);
package Wx::HelpControllerHelpProvider; @ISA = qw(Wx::HelpProvider);

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #
