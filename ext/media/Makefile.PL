#############################################################################
## Name:        ext/media/Makefile.PL
## Purpose:     Makefile.PL for wxWidgets multimedia control
## Author:      Mattia Barbon
## Modified by:
## Created:     04/03/2006
## RCS-ID:      $Id: Makefile.PL,v 1.2 2006/04/05 17:49:11 mbarbon Exp $
## Copyright:   (c) 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME            => 'Wx::Media',
                 VERSION_FROM    => 'lib/Wx/Media.pm',
                 WX_CORE_LIB     => 'media core base',
                 REQUIRE_WX      => 2.006000,
               );
