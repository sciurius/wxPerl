#!/usr/bin/perl -w
############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:     01/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2012 Mattia Barbon
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

my $moduleauthor = ( $mmv >= 6.5702 ) ? [ 'Mattia Barbon <mbarbon@cpan.org>' ] : 'Mattia Barbon <mbarbon@cpan.org>';

# $ExtUtils::MakeMaker::Verbose = 2;
# $wxConfig::Verbose = 10;

# Make setting optional MakeMaker parameters more readable
# lifted from DBD::SQLite distribution
sub OPTIONAL {
	return () unless $ExtUtils::MakeMaker::VERSION ge shift;
	return @_;
}

wxWriteMakefile(                 
    NAME             => 'Wx',
	ABSTRACT_FROM    => 'Wx.pm',
	VERSION_FROM     => 'Wx.pm',
	AUTHOR           => $moduleauthor,
	PREREQ_PM        => {
        'Alien::wxWidgets'       => 0.25,
        'ExtUtils::XSpp'         => 0.1602,
        'ExtUtils::MakeMaker'    => 6.46,
        'ExtUtils::ParseXS'      => 3.15,
        'File::Spec::Functions'  => 0.82,
        'Test::More'             => 0.45,
        'Test::Harness'          => 2.26,
        'if'                     => 0.03,
	},
    LICENSE => 'perl',	
	OPTIONAL( '6.48',
		MIN_PERL_VERSION => '5.006001',
	),
	META_ADD => {
        dynamic_config => 1,
        configure_requires => {
            'Alien::wxWidgets'    => 0.25,
        },
        build_requires => {
            'Alien::wxWidgets'    => 0.25,
            'ExtUtils::MakeMaker' => 6.48,
            'ExtUtils::XSpp'      => 0.1602,
            'Test::More'          => 0.42,
            'ExtUtils::ParseXS'   => 3.15,
            'File::Spec::Functions'  => 0.82,
            'Test::More'          => 0.45,
            'Test::Harness'       => 2.26,
            'if'                  => 0.03,
        },
        requires => {
            'Alien::wxWidgets'    => 0.25,
        },
        resources => {
            'license'       => 'http://dev.perl.org/licenses/',
            'homepage'      => 'http://wxperl.eu/',
            'bugtracker'    => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Wx',
            'repository'    => 'https://wxperl.svn.sourceforge.net/svnroot/wxperl/wxPerl',
            'MailingList'   => 'http://lists.perl.org/list/wxperl-users.html',
        },
        no_index => { directory => [ qw(samples script) ],
                      package   => [ qw(MY Parse::Yapp::Driver) ],
        },
    },
    PMLIBDIRS         => [ 'lib', 'build' ],
    EXE_FILES         => [ qw(script/wxperl_overload) ],
    WX_CORE_LIB_MAYBE => $^O eq 'darwin' ? 'media html' : '',
    WX_CORE_LIB       => 'adv core base',
    WX_OVERLOAD       => { header  => 'cpp/ovl_const.h',
                           source  => 'cpp/ovl_const.cpp',
                         },
    WX_TOP            => 'Wx.pm',
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

    if( grep /\b(?:INC|LIB)=/, @ARGV ) {
        print <<EOT;
======================================================================
It seems that LIB and/or INC was passed to Makefile.PL invocation;
this might cause the build to fail.  Please retry without passing
INC/LIB to Makefile.PL
======================================================================
EOT
    }
}

# local variables:
# mode: cperl
# end:
