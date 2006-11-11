#############################################################################
## Name:        ext/media/Makefile.PL
## Purpose:     Makefile.PL for wxWidgets multimedia control
## Author:      Mattia Barbon
## Modified by:
## Created:     04/03/2006
## RCS-ID:      $Id: Makefile.PL,v 1.4 2006/11/11 09:36:38 mbarbon Exp $
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
                 REQUIRE_WX_LIB  => 'media',
                 REQUIRE_WX      => 2.006000,
                 NO_WX_PLATFORMS => [ 'motif' ],
               );
