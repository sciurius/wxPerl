#############################################################################
## Name:        ext/help/Makefile.PL
## Purpose:     Makefile.PL for wxHelpController*
## Author:      Mattia Barbon
## Modified by:
## Created:     18/03/2001
## RCS-ID:      $Id: Makefile.PL,v 1.10 2004/10/19 20:28:09 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::Help',
                 VERSION_FROM => 'lib/Wx/Help.pm',
                 WX_CORE_LIB  => 'core base',
               );

# local variables:
# mode: cperl
# end:
