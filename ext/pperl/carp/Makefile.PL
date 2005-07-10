############################################################################
## Name:        ext/pperl/carp/Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:     29/12/2002
## RCS-ID:      $Id: Makefile.PL,v 1.3 2005/07/10 19:01:31 mbarbon Exp $
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::Perl::Carp',
                 AUTHOR       => 'D.H. aka PodMaster',
                 VERSION_FROM => 'Carp.pm',
                 WX_CORE_LIB  => ' ',
               );
