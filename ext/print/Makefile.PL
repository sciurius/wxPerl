#############################################################################
## Name:        ext/print/Makefile.PL
## Purpose:     Makefile.PL for Print Framework
## Author:      Mattia Barbon
## Modified by:
## Created:     04/05/2001
## RCS-ID:      $Id: Makefile.PL,v 1.11 2005/03/15 21:35:34 mbarbon Exp $
## Copyright:   (c) 2001-2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME             => 'Wx::Print',
                 VERSION_FROM     => 'lib/Wx/Print.pm',
                 clean            => { FILES => 'cpp/previewcontrolbar.h cpp/previewframe.h' },
                 WX_CORE_LIB      => 'core base',
               );

# local variables:
# mode: cperl
# end:
