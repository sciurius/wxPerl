#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for Drag'n'Drop and Clipboard
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 8/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';

use wxConfig;

wxWriteMakefile( NAME => 'Wx::DND',
                 VERSION_FROM => 'lib/Wx/DND.pm',
               );

# Local variables: #
# mode: cperl #
# End: #

