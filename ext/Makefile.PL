#############################################################################
## Name:        ext/Makefile.PL
## Purpose:     Makefile.PL to enable recursion inside subdirs
## Author:      Mattia Barbon
## Modified by:
## Created:     02/04/2002
## RCS-ID:      $Id: Makefile.PL,v 1.5 2004/10/19 20:28:07 mbarbon Exp $
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use ExtUtils::MakeMaker;

WriteMakefile( NAME => 'Wx',
               DIR => [ @Wx::build::MakeMaker::Core::subdirs,
                        # for pure perl
                        'pperl' ],
             );

# local variables:
# mode: cperl
# end:
