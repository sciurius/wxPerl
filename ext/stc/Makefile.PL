#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxSTC
## Author:      Mattia Barbon
## Modified by:
## Created:     23/ 5/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';

use wxConfig;

wxWriteMakefile( NAME => 'Wx::STC',
                 VERSION_FROM => 'lib/Wx/STC.pm',
                 WXLIB => 'stc',
               );

# Local variables: #
# mode: cperl #
# End: #
