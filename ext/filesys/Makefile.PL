#############################################################################
## Name:        ext/filesys/Makefile.PL
## Purpose:     Makefile.PL for wxFileSystem and related classes
## Author:      Mattia Barbon
## Modified by:
## Created:     28/04/2001
## RCS-ID:      $Id: Makefile.PL,v 1.7 2004/03/01 21:24:10 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::FS',
                 VERSION_FROM => 'lib/Wx/FS.pm',
                 WX_CORE_LIB  => 'net core base',
               );

# local variables:
# mode: cperl
# end:
