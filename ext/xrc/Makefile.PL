#############################################################################
## Name:        ext/xrc/Makefile.PL
## Purpose:     Makefile.PL for wxWidgets XML resources (xrc)
## Author:      Mattia Barbon
## Modified by:
## Created:     27/07/2001
## RCS-ID:      $Id: Makefile.PL,v 1.15 2005/01/03 21:07:25 mbarbon Exp $
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
                 WX_CORE_LIB     => 'xrc xml html adv core base',
               );

# local variables:
# mode: cperl
# end:

