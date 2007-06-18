#!/usr/bin/perl -w
#############################################################################
## Name:        script/copy_files.pl
## Purpose:     Simple wrapper around ExtUtils::Install
## Author:      Mattia Barbon
## Modified by:
## Created:     16/12/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use ExtUtils::Install 'pm_to_blib';

my $file = shift;

die "File '$file' does not exist" unless -f $file;
my $files = do $file;

die "Error loading options: $@" unless $files;
#die %$files;
pm_to_blib( $files,
            'blib', # dummy argument, but required
            '' );   # idem

exit 0;

# local variables:
# mode: cperl
# end:
