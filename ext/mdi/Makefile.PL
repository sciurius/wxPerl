#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for MDI
## Author:      Mattia Barbon
## Modified by:
## Created:      6/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::MDI',
                 VERSION_FROM => 'lib/Wx/MDI.pm',
               );

# local variables:
# mode: cperl
# end:

