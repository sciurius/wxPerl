#############################################################################
## Name:        ext/mdi/Makefile.PL
## Purpose:     Makefile.PL for MDI
## Author:      Mattia Barbon
## Modified by:
## Created:     06/09/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::MDI',
                 VERSION_FROM => 'lib/Wx/MDI.pm',
                 WX_CORE_LIB  => 'core base',
               );

# local variables:
# mode: cperl
# end:

