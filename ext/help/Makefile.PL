#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxHelpController*
## Author:      Mattia Barbon
## Modified by:
## Created:     18/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use ExtUtils::MakeMaker;
use Config;
use lib '../../build';

use wxConfig qw(configure);

WriteMakefile( NAME => 'Wx::Help',
               VERSION_FROM => 'lib/Wx/Help.pm',
               XSOPT => ' -C++ -noprototypes ',
               TYPEMAPS => [ '../../typemap' ],
               CONFIGURE => \&configure,
             );

package MY;

use wxConfig qw(:MY);

# Local variables: #
# mode: cperl #
# End: #
