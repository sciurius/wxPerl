#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxFileSystem and related classes
## Author:      Mattia Barbon
## Modified by:
## Created:     28/ 4/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::FS',
                 VERSION_FROM => 'lib/Wx/FS.pm',
               );

# local variables:
# mode: cperl
# end:
