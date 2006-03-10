#!/usr/bin/perl -w
############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:     01/10/2000
## RCS-ID:      $Id: Makefile.PL,v 1.43 2006/03/10 19:25:32 mbarbon Exp $
## Copyright:   (c) 2000-2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package core;

use 5.006001;
use strict;

use FindBin;
use lib "${FindBin::RealBin}/build";
use Wx::build::MakeMaker::Core;

( my $mmv = ExtUtils::MakeMaker->VERSION ) =~ s/_//g;

if( $mmv == 6.21 ) {
    die <<EOT
ExtUtils::MakeMaker 6.21 is known not to work with wxPerl;
please downgrade to 6.17 or install the latest version from CPAN.
EOT
}

# $ExtUtils::MakeMaker::Verbose = 2;
# $wxConfig::Verbose = 10;

wxWriteMakefile( NAME          => 'Wx',
                 ABSTRACT_FROM => 'Wx.pm',
                 AUTHOR        => 'Mattia Barbon <mbarbon@cpan.org>',
                 VERSION_FROM  => 'Wx.pm',
                 PREREQ_PM     => { 'File::Spec::Functions'  => 0.82,
                                    'Test::More'             => 0.45,
                                    'Test::Harness'          => 2.26,
                                    'Data::Dumper'           => 0,
                                    'ExtUtils::MakeMaker'    => 6.17,
                                   },
                 PMLIBDIRS     => [ 'lib', 'build' ],
                 WX_CORE_LIB   => ( $^O ne 'MSWin32' ? 'adv media html core base' :
                                                       'adv core base' ),
                 NO_META       => 1,
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
