#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxDateTime
## Author:      Mattia Barbon
## Modified by:
## Created:     22/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::DateTime',
                 VERSION_FROM => 'DateTime.pm',
               );

# local variables:
# mode: cperl
# end:
