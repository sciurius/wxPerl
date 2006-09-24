#############################################################################
## Name:        ext/html/Makefile.PL
## Purpose:     Makefile.PL for wxHTML
## Author:      Mattia Barbon
## Modified by:
## Created:     10/03/2001
## RCS-ID:      $Id: Makefile.PL,v 1.14 2006/09/24 17:15:59 mbarbon Exp $
## Copyright:   (c) 2001-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::Html',
                 VERSION_FROM => 'lib/Wx/Html.pm',
                 clean        => { FILES => 'cpp/htmltag.h cpp/htmllbox.h' },
                 WX_CORE_LIB  => 'html core base',
               );

# local variables:
# mode: cperl
# end:
