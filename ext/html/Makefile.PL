#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxHTML
## Author:      Mattia Barbon
## Modified by:
## Created:     10/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use Config;
use lib '../../build';

use wxConfig;

wxWriteMakefile( NAME => 'Wx::Html',
                 VERSION_FROM => 'lib/Wx/Html.pm',
               );

#package MY;

#use wxConfig qw(:MY);

# Local variables: #
# mode: cperl #
# End: #
