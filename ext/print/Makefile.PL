#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for Print Framework
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 5/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';

use wxConfig;

wxWriteMakefile( NAME => 'Wx::Print',
                 VERSION_FROM => 'lib/Wx/Print.pm',
               );

# Local variables: #
# mode: cperl #
# End: #
