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

use Config;
use FindBin;
use lib "${FindBin::RealBin}/build";
use wxConfig;
use wxMMUtils;

# sanitize File::Find on filesystem where mlink of directories can be <= 2
use File::Find;
$File::Find::dont_use_nlink = 1 if ( stat('.') )[3] <= 1;

# $ExtUtils::MakeMaker::Verbose = 100;
# $wxConfig::Verbose = 10;

use vars qw(@top_level_xs);

@top_level_xs = qw(Wx.xs Constant.xs Controls.xs Event.xs
                   Frames.xs GDI.xs Window.xs);

wxWriteMakefile( NAME => 'Wx',
                 ABSTRACT_FROM => 'Wx.pm',
                 AUTHOR => 'Mattia Barbon <mbarbon@dsi.unive.it>',
                 VERSION_FROM => 'Wx.pm',
                 DIR => [ MM->catdir( qw(ext grid) ),
                          MM->catdir( qw(ext mdi) ),
                          MM->catdir( qw(ext dnd) ),
                          MM->catdir( qw(ext html) ),
                          MM->catdir( qw(ext help) ),
                          MM->catdir( qw(ext filesys) ),
                          MM->catdir( qw(ext print) ),
                          MM->catdir( qw(ext xrc) ),
                        ],
                 OBJECT => join( ' ', obj_from_src( @top_level_xs ) ) . ' ',
               );

# Local variables: #
# mode: cperl #
# End: #
