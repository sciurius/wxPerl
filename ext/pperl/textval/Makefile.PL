############################################################################
## Name:        ext/pperl/textval/Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:     15/08/2005
## RCS-ID:      $Id$
## Copyright:   (c) 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME         => 'Wx::Perl::TextValidator',
                 AUTHOR       => 'Johan Vromans, Mattia Barbon',
                 VERSION_FROM => 'TextValidator.pm',
                 WX_CORE_LIB  => ' ',
               );
