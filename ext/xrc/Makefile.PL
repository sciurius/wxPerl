#############################################################################
## Name:        ext/xrc/Makefile.PL
## Purpose:     Makefile.PL for wxWidgets XML resources (xrc)
## Author:      Mattia Barbon
## Modified by:
## Created:     27/07/2001
## RCS-ID:      $Id: Makefile.PL,v 1.14 2004/12/21 21:12:57 mbarbon Exp $
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME            => 'Wx::XRC',
                 VERSION_FROM    => 'lib/Wx/XRC.pm',
                 clean           => { FILES => 'cpp/factory.h cpp/reshnd.h' },
                 WX_CORE_LIB     => 'xrc xml core base',
               );

# local variables:
# mode: cperl
# end:

