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
use vars qw($debug_mode $unicode_mode $extra_libs $extra_cflags
            $use_shared $use_dllexport $o_help $o_mksymlinks
            $subdirs);
use vars qw($Arch);
use Getopt::Long;

my $result =
GetOptions( 'debug' => \$debug_mode,
            'unicode' => \$unicode_mode,
            'extra-libs=s' => \$extra_libs,
            'extra-cflags=s' => \$extra_cflags,
            'mingw-shared!' => \$use_shared,
            'use-dllexport!' => \$use_dllexport,
            'help' => \$o_help,
            'mksymlinks' => \$o_mksymlinks,
          );

if( $o_help || !$result ) {
  print <<EOT;
Usage: perl Makefile.PL [options]
  --debug              enable debug symbols
  --unicode            enable Unicode support ( MSW only )
  --extra-libs=s       specify extra linking flags
  --extra-cflags=s     specify extra compilation flags
  --[no]mingw-shared   use 'g++ --shared' with MinGW ( MSW only )
  --[no]use-dllexport  use 'dllexport' ( MSW only )
  --mksymlinks         create a symlink tree ( only if filesystem
                       supports that, of course )
  --help               you are reading it
EOT
  exit 0;
}

# small helper, 5.005 does not have F::S::Functions
sub splitpath {
  return File::Spec->splitpath( @_ );
}

#
# this can only work on Unix, patches welcome...
#
if( $o_mksymlinks ) {
  require FindBin;
  require ExtUtils::Manifest;
  # 5.005 does not have splitpath...
  if( $] >= 5.006 ) {
    require File::Spec;
  } else {
    eval <<'EOT'
package File::Spec;

# this will work on *nix, and only on files not in root,
# but almost no-one will use 5.004 on non-unix by now...
sub splitpath {
  shift;
  my $file = shift;
  return ( undef, $file, undef ) if $file =~ m{/\.{1,2}$};
  return ( undef, $file, $1 ) if $file =~ s{([^/]+)$}{};
}
EOT
  }
  require File::Path;

  *mkpath = \&File::Path::mkpath;

  my $manifest = MM->catfile( $FindBin::RealBin, 'MANIFEST' );
  die "Can't find MANIFEST" unless -e $manifest;
  my $files = ExtUtils::Manifest::maniread( $manifest );

  foreach my $f ( keys %$files ) {
    my( $fr, $to ) = ( "${FindBin::RealBin}/$f", $f );
    my $dir;
    ( undef, $dir, undef ) = splitpath( $to );
    mkpath( $dir ) if length $dir && !-d $dir;
    next if -l $to;
    unlink $to or die "unlink '$to' failed: $!" if -e $to;
    symlink( $fr, $to ) or die "symlink '$fr' => '$to' failed: $!";
  }
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

    if( $i eq 'WXSUBDIRS' ) {
      $subdirs = $params{WXSUBDIRS};
      delete $params{WXSUBDIRS};
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
