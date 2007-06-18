############################################################################
## Name:        ext/pperl/splashfast/Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:     04/07/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../../build';
use Wx::build::MakeMaker;

# strange failure with 5.004
if( $] < 5.005 ) {
  ExtUtils::MakeMaker::WriteEmptyMakefile();
} else {

wxWriteMakefile( NAME            => 'Wx::Perl::SplashFast',
                 ABSTRACT_FROM   => 'SplashFast.pm',
                 AUTHOR          => 'Graciliano M. P. <gm@virtuasites.com.br>',
                 VERSION_FROM    => 'SplashFast.pm',
                 WX_CORE_LIB     => ' ',
                );

}

# local variables:
# mode: cperl
# end:
