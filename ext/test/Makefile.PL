#############################################################################
## Name:        ext/test/Makefile.PL
## Purpose:     Makefile.PL for wxPerlTest
## Author:      Mark Dootson
## Modified by:
## Created:     2012-09-28
## RCS-ID:      $Id$
## Copyright:   (c) 2012 Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME             => 'Wx::PerlTest',
                 VERSION_FROM     => 'lib/Wx/PerlTest.pm',
                 WX_CORE_LIB      => 'core base',
                 );

# local variables:
# mode: cperl
# end:
