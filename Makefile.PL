#!/usr/bin/perl -w
############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:      1/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use ExtUtils::MakeMaker;
use Config;

use lib 'build';
use wxConfig qw(configure obj_from_src);

# $ExtUtils::MakeMaker::Verbose = 100;
# $wxConfig::Verbose = 100;

use vars qw(@top_level_xs);

@top_level_xs = glob( "*.xs" );

WriteMakefile( NAME => 'Wx',
               # Perl < 5.005 does not support some attributes
               ( $] >= 5.005 ?
                 ( ABSTRACT_FROM => 'Wx.pm',
                   AUTHOR => 'Mattia Barbon <mbarbon@dsi.unive.it>',
                 ) : () ),
               VERSION_FROM => 'Wx.pm',
               CONFIGURE => \&configure,
               XSOPT => ' -C++ -noprototypes ',
               DIR => [ MM->catdir( qw(ext html) ),
                        MM->catdir( qw(ext help) ),
                      ],
               OBJECT => join( ' ', obj_from_src( @top_level_xs ) ) . ' ',
             );

package MY;

use wxConfig qw(:MY postamble);

# Local variables: #
# mode: cperl #
# End: #
