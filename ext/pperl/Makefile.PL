#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL to enable recursion inside subdirs
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 7/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use ExtUtils::MakeMaker;

WriteMakefile( NAME => 'Wx::Perl',
               DIR => [ 'splashfast' ] );

# Local variables: #
# mode: cperl #
# End: #
