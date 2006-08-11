#!/usr/bin/perl -w
#############################################################################
## Name:        script/fix_alien_path.pl
## Purpose:     Substitute Alien::wxWidgets path in modules
## Author:      Mattia Barbon
## Modified by:
## Created:     15/08/2005
## RCS-ID:      $Id: fix_alien_path.pl,v 1.4 2006/08/11 19:30:54 mbarbon Exp $
## Copyright:   (c) 2005-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use blib; # to pick the correct 'Wx::build::Options'
use Alien::wxWidgets 0.04 ();
use Wx::build::Options;
use Fatal qw(open close unlink);
use Config;
use Data::Dumper;
use File::Spec::Functions qw(splitpath splitdir);

# we do not care about the options, just that Alien::wxWidgets
# is initialized with the correct key
Wx::build::Options->get_makemaker_options( 'saved' );
$Alien::wxWidgets::dont_remap = 1;

my( $from, $to ) = @ARGV;
my $key = Alien::wxWidgets->key;
my $version = Alien::wxWidgets->version;
my @libs = Alien::wxWidgets->library_keys;
my %libs; @libs{@libs} = Alien::wxWidgets->shared_libraries( @libs );
my $libs = Data::Dumper::Dumper( \%libs );

my $keyd;
if( $^O =~ /mswin/i ) {
    $keyd = $key;
} else {
    my( $vol, $dir, $file ) = splitpath( Alien::wxWidgets->prefix );
    $keyd = $file ? $file : ( splitdir( $dir ) )[-1];
}

unlink $to if -f $to;
open my $in, "< $from"; binmode $in;
open my $out, "> $to"; binmode $out;

while( <$in> ) {
    s/XXXALIENDXXX/$keyd/g;
    s/XXXALIENXXX/$key/g;
    s/Wx::wxVERSION\(\)/$version/g;
    s/XXXDLLSXXX/$libs/g;
    print $out $_;
}

close $in;
close $out;

exit 0;
