#!/usr/bin/perl -w
############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:     01/10/2000
## RCS-ID:      $Id: Makefile.PL,v 1.35 2003/12/13 17:18:34 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package core;

use 5.005_03;
use strict;

use FindBin;
use lib "${FindBin::RealBin}/build";
use Wx::build::MakeMaker::Core;

# $ExtUtils::MakeMaker::Verbose = 2;
# $wxConfig::Verbose = 10;

wxWriteMakefile( NAME          => 'Wx',
                 ABSTRACT_FROM => 'Wx.pm',
                 AUTHOR        => 'Mattia Barbon <mbarbon@dsi.unive.it>',
                 VERSION_FROM  => 'Wx.pm',
                 PREREQ_PM     => { 'File::Spec::Functions'  => 0.82,
                                    'Test::More'             => 0.45,
                                    'Test::Harness'          => 2.26,
                                    'Data::Dumper'           => 0,
                                   },
                 PMLIBDIRS     => [ 'lib', 'build' ],
                 WX_CORE_LIB   => 'adv core base',
#                 ( $wxConfig::o_static ?
#                   ( WXLIB => [ 'wxxrc', 'stc' ] ) :
#                   () ),
               );

END {
    print <<EOT;
======================================================================
For installation instructions and further help please see
docs/install.txt

For command line switches help use:
perl Makefile.PL --help
======================================================================
EOT
}

# local variables:
# mode: cperl
# end:
