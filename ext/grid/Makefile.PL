#############################################################################
## Name:        ext/grid/Makefile.PL
## Purpose:     Makefile.PL for wxGrid
## Author:      Mattia Barbon
## Modified by:
## Created:     04/12/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::Grid',
                 VERSION_FROM => 'lib/Wx/Grid.pm',
                 clean        => { FILES => 'cpp/gridtable.h' },
                 WX_CORE_LIB  => 'adv core base',
               );

# local variables:
# mode: cperl
# end:
