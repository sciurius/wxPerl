#############################################################################
## Name:        ext/pperl/Makefile.PL
## Purpose:     Makefile.PL to enable recursion inside subdirs
## Author:      Mattia Barbon
## Modified by:
## Created:     04/07/2002
## RCS-ID:      $Id: Makefile.PL,v 1.4 2004/10/19 20:28:10 mbarbon Exp $
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use ExtUtils::MakeMaker;

WriteMakefile( NAME => 'Wx::Perl',
               DIR  => [ 'splashfast', 'carp' ] );

# local variables:
# mode: cperl
# end:
