#############################################################################
## Name:        ext/dataview/Makefile.PL
## Purpose:     Makefile.PL for wxDataViewCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     05/11/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::DataView',
                 VERSION_FROM => 'DataView.pm',
                 clean        => { FILES => 'cpp' },
                 REQUIRE_WX   => 2.009000,
                 WX_CORE_LIB  => 'adv core base',
               );
