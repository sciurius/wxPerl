#############################################################################
## Name:        ext/stc/Makefile.PL
## Purpose:     Makefile.PL for wxSTC
## Author:      Mattia Barbon
## Modified by:
## Created:     23/05/2002
## RCS-ID:      $Id: Makefile.PL,v 1.3 2003/08/23 13:00:38 mbarbon Exp $
## Copyright:   (c) 2002-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::STC',
                 VERSION_FROM => 'lib/Wx/STC.pm',
                 WX_CORE_LIB  => 'stc core base',
               );

# local variables:
# mode: cperl
# end:
