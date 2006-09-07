#############################################################################
## Name:        ext/Makefile.PL
## Purpose:     Makefile.PL to enable recursion inside subdirs
## Author:      Mattia Barbon
## Modified by:
## Created:     02/04/2002
## RCS-ID:      $Id: Makefile.PL,v 1.7 2006/09/07 20:45:27 mbarbon Exp $
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
