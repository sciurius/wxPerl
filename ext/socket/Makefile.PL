#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL for wxSocket
## Author:      Graciliano M. P.
## Modified by:
## Created:     27/02/2003
## RCS-ID:      
## Copyright:   (c) 2003 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::Socket',
                 VERSION_FROM => 'lib/Wx/Socket.pm',
               );

# local variables:
# mode: cperl
# end:
