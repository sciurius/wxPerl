#############################################################################
## Name:        ext/xrc/Makefile.PL
## Purpose:     Makefile.PL for wxWidgets XML resources (xrc)
## Author:      Mattia Barbon
## Modified by:
## Created:     27/07/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2005, 2010 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME            => 'Wx::XRC',
                 VERSION_FROM    => 'lib/Wx/XRC.pm',
                 WX_CORE_LIB     => 'xrc xml html core base',
                 );

# local variables:
# mode: cperl
# end:

