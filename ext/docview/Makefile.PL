#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxWindows Document / View Framework
## Author:      Simon Flack
## Modified by:
## Created:     11/9/2002
## RCS-ID:
## Copyright:   (c) 2002 Simon Flack
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';

use wxConfig;
use wxMMUtils;

if( is_platform( 'mac' ) ) {
  ExtUtils::MakeMaker::WriteEmptyMakefile();
} else {

wxWriteMakefile( NAME => 'Wx::DocView',
                 VERSION_FROM => 'lib/Wx/DocView.pm',
                 REQUIRE_WX => 2.003_000,
               );

}

# Local variables: #
# mode: cperl #
# End: #

