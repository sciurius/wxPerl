#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxWindows XML resources ( xrc )
## Author:      Mattia Barbon
## Modified by:
## Created:     27/ 7/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
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

wxWriteMakefile( NAME => 'Wx::XRC',
                 VERSION_FROM => 'lib/Wx/XRC.pm',
                 WXLIB => 'wxxrc',
                 REQUIRE_WX => 2.003_000,
               );

}

# Local variables: #
# mode: cperl #
# End: #

