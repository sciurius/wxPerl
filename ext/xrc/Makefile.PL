#############################################################################
## Name:        ext/xrc/Makefile.PL
## Purpose:     Makefile.PL for wxWidgets XML resources (xrc)
## Author:      Mattia Barbon
## Modified by:
## Created:     27/07/2001
## RCS-ID:      $Id: Makefile.PL,v 1.12 2004/02/29 14:30:40 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
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
                 NO_WX_PLATFORMS => [ 'mac' ],
               );

# local variables:
# mode: cperl
# end:

