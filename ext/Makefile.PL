#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL to anbale recursion inside subdirs
## Author:      Mattia Barbon
## Modified by:
## Created:      2/ 4/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use ExtUtils::MakeMaker;

WriteMakefile( NAME => 'Wx',
               DIR => $wxConfig::subdirs );

# Local variables: #
# mode: cperl #
# End: #
