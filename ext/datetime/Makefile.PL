#############################################################################
## Name:        ext/datetime/Makefile.PL
## Purpose:     Makefile.PL for wxDateTime
## Author:      Mattia Barbon
## Modified by:
## Created:     22/ 9/2002
## RCS-ID:      $Id: Makefile.PL,v 1.2 2003/08/23 13:00:37 mbarbon Exp $
## Copyright:   (c) 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::DateTime',
                 VERSION_FROM => 'DateTime.pm',
                 WX_CORE_LIB  => 'base',
               );

# local variables:
# mode: cperl
# end:
