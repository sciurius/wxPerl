#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxWindows XML resources (xrc)
## Author:      Mattia Barbon
## Modified by:
## Created:     27/ 7/2001
## RCS-ID:      $Id: Makefile.PL,v 1.9 2003/07/25 20:36:15 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME            => 'Wx::XRC',
                 VERSION_FROM    => 'lib/Wx/XRC.pm',
                 clean        => { FILES => 'cpp/factory.h cpp/reshnd.h' },
                 WX_LIB          => 'wxxrc',
#                REQUIRE_WX      => 2.003_000,
                 NO_WX_PLATFORMS => [ 'mac' ],
               );

# local variables:
# mode: cperl
# end:

