#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxCalendarCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:      5/10/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::Calendar',
                 VERSION_FROM => 'Calendar.pm',
               );

# local variables:
# mode: cperl
# end:
