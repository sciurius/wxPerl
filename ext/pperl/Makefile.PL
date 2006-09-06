#############################################################################
## Name:        ext/pperl/Makefile.PL
## Purpose:     Makefile.PL to enable recursion inside subdirs
## Author:      Mattia Barbon
## Modified by:
## Created:     04/07/2002
## RCS-ID:      $Id: Makefile.PL,v 1.6 2006/09/06 11:41:37 mbarbon Exp $
## Copyright:   (c) 2002, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::build::MakeMaker;

wxWriteMakefile( NAME => 'Wx::Perl',
                 DIR  => [ qw(splashfast carp textval) ] );

# local variables:
# mode: cperl
# end:
