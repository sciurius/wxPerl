#############################################################################
## Name:        ext/dnd/Makefile.PL
## Purpose:     Makefile.PL for Drag'n'Drop and Clipboard
## Author:      Mattia Barbon
## Modified by:
## Created:     12/08/2001
## RCS-ID:      $Id: Makefile.PL,v 1.10 2004/12/21 21:12:48 mbarbon Exp $
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME            => 'Wx::DND',
                 VERSION_FROM    => 'lib/Wx/DND.pm',
                 WX_CORE_LIB     => 'core base',
               );

# local variables:
# mode: cperl
# end:

