#############################################################################
## Name:        ext/Makefile.PL
## Purpose:     Makefile.PL to enable recursion inside subdirs
## Author:      Mattia Barbon
## Modified by:
## Created:     02/04/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::build::MakeMaker;

wxWriteMakefile( NAME => 'Wx',
                 DIR => [ @Wx::build::MakeMaker::Core::subdirs,
                          # for pure perl
                          'pperl' ],
                 );

# local variables:
# mode: cperl
# end:
