#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for MDI
## Author:      Mattia Barbon
## Modified by:
## Created:      6/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';

use wxConfig;

wxWriteMakefile( NAME => 'Wx::MDI',
                 VERSION_FROM => 'lib/Wx/MDI.pm',
               );

# Local variables: #
# mode: cperl #
# End: #

