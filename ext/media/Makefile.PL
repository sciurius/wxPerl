#############################################################################
## Name:        ext/media/Makefile.PL
## Purpose:     Makefile.PL for wxWidgets multimedia control
## Author:      Mattia Barbon
## Modified by:
## Created:     04/03/2006
## RCS-ID:      $Id: Makefile.PL,v 1.1 2006/03/10 19:25:33 mbarbon Exp $
## Copyright:   (c) 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME            => 'Wx::Media',
                 VERSION_FROM    => 'lib/Wx/Media.pm',
#                 clean           => { FILES => 'cpp/factory.h cpp/reshnd.h' },
                 WX_CORE_LIB     => 'media core base',
               );
