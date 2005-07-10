############################################################################
## Name:        ext/pperl/splashfast/Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:     04/07/2002
## RCS-ID:      $Id: Makefile.PL,v 1.7 2005/07/10 19:01:31 mbarbon Exp $
## Copyright:   (c) 2002 Mattia Barbon
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
