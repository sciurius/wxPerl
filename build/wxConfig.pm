############################################################################
## Name:        wxConfig.pm
## Purpose:     Makefile.PL helper
## Author:      Mattia Barbon
## Modified by:
## Created:     11/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package wxConfig;

use strict;
use vars qw(@ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $Verbose);
use ExtUtils::MakeMaker;

# parse command line variables
use vars qw($debug_mode $unicode_mode $extra_libs $extra_cflags $use_shared $use_dllexport);
use vars qw($Arch);

LOOP: foreach ( @ARGV ) {
  m/^DEBUG=(\d+)$/ && do { $debug_mode = $1 ; undef $_; next LOOP; };
  m/^UNICODE=(\d+)$/ && do { $unicode_mode = $1; undef $_; next LOOP; };
  m/^EXTRA_LIBS=(.*)$/ && do { $extra_libs = $1; undef $_; next LOOP; };
  m/^EXTRA_CFLAGS=(.*)$/ && do { $extra_cflags = $1; undef $_; next LOOP; };
  m/^USE_SHARED=(.*)$/ && do { $use_shared = $1; undef $_; next LOOP; };
  m/^USE_DLLEXPORT=(.*)$/ && do { $use_dllexport = $1; undef $_; next LOOP; };
}
$use_dllexport = 0 unless $use_shared;
#FIXME// hack
$extra_cflags .= ' -DWXPL_USE_DLLEXPORT=1 ' if $use_dllexport;

use base 'Exporter';
use Config;

@EXPORT = qw(wxWriteMakefile);

use wxMMUtils;

# BLEAGH!!!!
sub import {
  *MY::post_initialize = \&post_initialize;

  wxConfig->export_to_level( 1, @_ );
}

# determines what package we must require
my $package_to_use;

sub post_initialize {
  my $class = ref $_[0];
  no strict;
  unshift @{"$class\:\:ISA"}, $package_to_use;
  use strict;
  '';
}

# configures subroutines depending
# from os/window system
BEGIN {
 SWITCH: {
    local( $_ ) = $Config{osname};

    m/MSWin32/ && do {
      local( $_ ) = $Config{cc};

      m/^cl/i  && do { $package_to_use = 'Win32_MSVC'; last SWITCH };
      m/^gcc/i && do { $package_to_use = 'Win32_MinGW'; last SWITCH };

      # default
      die "Your compiler is not currently supported on Win32 platform"
    };

    m/darwin/ && do {
      $package_to_use = 'MacOSX_GCC';
      last SWITCH;
    };

    # default
    $package_to_use = 'Any_wx_config';
    last SWITCH;
  }
}

sub wxWriteMakefile {
  my( %params ) = @_;

  my $do_not_use = 0;

  foreach my $i ( keys %params ) {
    if( $i eq 'WXLIB' ) {
      $params{LIBS} .= $Arch->wx_lib( $params{$i} );
      delete $params{WXLIB};
    }

    if( $i eq 'REQUIRE_WX' ) {
      $do_not_use ||= wx_version() < $params{REQUIRE_WX};
      delete $params{REQUIRE_WX};
    }

    delete $params{$i}
      if( ( $i eq 'ABSTRACT_FROM'|| $i eq 'AUTHOR' ) && $] < 5.005 );
  }

  require Any_OS; # perl 5.004_04 needs this...
  $params{XSOPT} = ' -C++ -noprototypes ' unless exists $params{XSOPT};
  $params{CONFIGURE} = \&Any_OS::get_config
    unless exists $params{CONFIGURE};
  $params{TYPEMAPS} = [ MM->catfile( top_dir(), 'typemap' ) ]
    unless exists $params{TYPEMAPS} || !building_extension();

  unless( $do_not_use ) {
    WriteMakefile( %params );
  } else {
    ExtUtils::MakeMaker::WriteEmptyMakefile( %params );
  }
}

require "$package_to_use.pm";
$Arch = $package_to_use;

1;

__DATA__

# Local variables: #
# mode: cperl #
# End: #
