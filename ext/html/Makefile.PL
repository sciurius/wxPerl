#############################################################################
## Name:        ext/html/Makefile.PL
## Purpose:     Makefile.PL for wxHTML
## Author:      Mattia Barbon
## Modified by:
## Created:     10/03/2001
## RCS-ID:      $Id: Makefile.PL,v 1.10 2004/02/28 23:04:07 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::Html',
                 VERSION_FROM => 'lib/Wx/Html.pm',
                 clean        => { FILES => 'ext/html/cpp/htmltag.h' },
                 WX_CORE_LIB  => 'html core base',
               );

# local variables:
# mode: cperl
# end:
