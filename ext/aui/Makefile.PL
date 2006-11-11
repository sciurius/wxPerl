#############################################################################
## Name:        ext/aui/Makefile.PL
## Purpose:     Makefile.PL for wxAUI
## Author:      Mattia Barbon
## Modified by:
## Created:     11/11/2006
## RCS-ID:      $Id: Makefile.PL,v 1.1 2006/11/11 21:34:07 mbarbon Exp $
## Copyright:   (c) 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::AUI',
                 VERSION_FROM => 'lib/Wx/AUI.pm',
                 clean        => { FILES => 'cpp' },
                 REQUIRE_WX   => 2.007002,
                 WX_CORE_LIB  => 'aui adv core base',
               );
