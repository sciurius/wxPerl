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
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::STC',
                 VERSION_FROM => 'lib/Wx/STC.pm',
                 WX_LIB       => 'stc',
               );

# local variables:
# mode: cperl
# end:
