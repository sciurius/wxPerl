#!/usr/bin/perl -w
############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:     01/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2007 Mattia Barbon
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

my $build_requires =
  { 'File::Spec::Functions'  => 0.82,
    'Test::More'             => 0.45,
    'Test::Harness'          => 2.26,
    'Data::Dumper'           => 0,
    'ExtUtils::MakeMaker'    => 6.17,
    'Alien::wxWidgets'       => 0.25,
    };

eval {
    require ExtUtils::MY_Metafile;
    ExtUtils::MY_Metafile->import;

    my_metafile
      ( { license        => 'perl',
          dynamic_config => 1,
          requires       => {},
          build_requires => $build_requires,
          no_index       => { directory => [ qw(samples script) ],
                              package   => [ qw(MY Parse::Yapp::Driver) ],
                              },
          } );
};

wxWriteMakefile( NAME          => 'Wx',
                 ABSTRACT_FROM => 'Wx.pm',
                 AUTHOR        => 'Mattia Barbon <mbarbon@cpan.org>',
                 VERSION_FROM  => 'Wx.pm',
                 PREREQ_PM     => { %$build_requires },
                 PMLIBDIRS     => [ 'lib', 'build' ],
                 EXE_FILES     => [ qw(script/wx_xspp.pl
                                       script/wx_overload.pl) ],
                 WX_CORE_LIB_MAYBE => $^O eq 'darwin' ? 'media html' : '',
                 WX_CORE_LIB   => 'adv core base',
                 WX_OVERLOAD   => { header  => 'cpp/ovl_const.h',
                                    source  => 'cpp/ovl_const.cpp',
                                    },
                 WX_TOP        => 'Wx.pm',
                 LICENSE       => 'perl',
                 );

END {
    print <<EOT;

======================================================================
For installation instructions and further help please see
docs/INSTALL.pod

For command line switches help use:
perl Makefile.PL --help
======================================================================

EOT
}

# local variables:
# mode: cperl
# end:
