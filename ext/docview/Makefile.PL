#############################################################################
## Name:        ext/docview/Makefile.PL
## Purpose:     Makefile.PL for wxWidgets Document / View Framework
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: Makefile.PL,v 1.6 2004/12/21 21:12:49 mbarbon Exp $
## Copyright:   (c) 2002-2004 Simon Flack
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME            => 'Wx::DocView',
                 VERSION_FROM    => 'lib/Wx/DocView.pm',
                 NO_WX_PLATFORMS => [ 'mac' ],
                 WX_CORE_LIB     => 'core base',
               );

# local variables:
# mode: cperl
# end:

