#############################################################################
## Name:        make_implib.pl
## Purpose:     Create an import library from an existing DLL
## Author:      Mattia Barbon
## Modified by:
## Created:     30/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Getopt::Long;
use File::Spec;
use Cwd;

my( $help, $target, $libname, $verbose, $outdir );

GetOptions( help => \$help, 'target=s' => \$target,
            'output-lib=s' => \$libname, verbose => \$verbose,
            'output-dir=s' => \$outdir,
          );

$outdir = $outdir || cwd();
-d $outdir || die "output directory '$outdir' is not a directory";

sub make_def_mingw {
  my( $libname, $defname ) = @_;
  local( *IN, *OUT );
  local( $_ );

  # opens input and output files
  open OUT, "> $defname" || die "error opening output file '$defname'";
  open IN, "objdump -x $libname |" || die "error executing objdump";

  # skips all unneeded data (we want just export names)
  while( ( $_ = <IN> ) && !m{\[Ordinal/Name Pointer\] Table}i ) {
    print if $verbose;
  }

  # the "NAME" is just the filename (no path)
  my( $n ) = ( File::Spec->splitpath( $libname ) )[2];

  print OUT "NAME $n\n";
  print OUT "EXPORTS\n";

  while( ( $_ = <IN> ) && !m/^\s*$/ ) {
    print if $verbose;
    m/^\s*\[\s*\d+\s*\]\s+([^\s]+)\s*$/ || 
      die "can't understand objdump output";
    print OUT "$1\n";
  }
}

sub make_def_msvc {
  my( $libname, $defname ) = @_;
  local( *IN, *OUT );
  local( $_ );

  # opens input and output files
  open OUT, "> $defname" || die "error opening output file '$defname'";
  open IN, "dumpbin /exports $libname |" || die "error executing dumpbin";

  # skips all unneeded data (we want just export names)
  while( ( $_ = <IN> ) && !m{\s*ordinal\s+hint\s+name\s*$}i ) {
    print if $verbose;
  }

  <IN>; # skip the blank line

  # the "NAME" is just the filename (no path)
  my( $n ) = ( File::Spec->splitpath( $libname ) )[2];

  print OUT "NAME $n\n";
  print OUT "EXPORTS\n";

  while( ( $_ = <IN> ) && !m/^\s*$/ ) {
    print if $verbose;
    m/^\s*\d+\s+[a-fA-F\d]+\s+([^\s]+)\s+\([a-fA-F\d]+\)\s*$/ ||
      die "can't understand dumpbin output";
    print OUT "$1\n";
  }
}

sub make_lib_mingw {
  my( $defname, $libname ) = @_;

  system "dlltool --input-def $defname --output-lib $libname";
}

sub make_lib_msvc {
  my( $defname, $libname ) = @_;

  $defname =~ s/^\s+//; $libname =~ s/^\s+//;
  system "lib /def:$defname /out:$libname";
}

sub make_libname_mingw {
  my( $dllname ) = @_;
  my( $libname );

  if( $dllname =~ m/\.dll$/i ) {
    $libname = 'lib' . substr( $dllname, 0, -4 ) . '.a';
  } else {
    $libname = $dllname . '.a';
  }

  return $libname;
}

sub make_libname_msvc {
  my( $dllname ) = @_;
  my( $libname );

  if( $dllname =~ m/\.dll$/i ) {
    $libname = substr( $dllname, 0, -4 ) . '.lib';
  } else {
    $libname = $dllname . '.lib';
  }

  return $libname;
}

sub make_defname {
  my( $dllname ) = @_;
  my( $defname ) = $dllname;

  if( $defname =~ m/\.dll/i ) { substr( $defname, -4 ) = '.def' }
  else { $defname .= '.def' }

  return $defname;
}

my( $needs_help ) = $help;

$needs_help |= ( @ARGV == 0 );
$needs_help = ( $target !~ m/^vc$/i && $target !~ m/mingw/i );
$needs_help = length( $libname ) && @ARGV > 1;

if( lc( $target ) eq 'vc' ) {
  *main::make_libname = \&make_libname_msvc;
  *main::make_def = \&make_def_msvc;
  *main::make_lib = \&make_lib_msvc;
} else {
  *main::make_libname = \&make_libname_mingw;
  *main::make_def = \&make_def_mingw;
  *main::make_lib = \&make_lib_mingw;
}

my( @dlls );

{
  my( $file );

  foreach ( @ARGV ) {
    unless( -f $_ ) { warn "not a file: '$_', skipping"; next; }

    $file = ( File::Spec->splitpath( $_ ) )[2];

    push @dlls, { dll => $_,
                  def => File::Spec->catfile( $outdir, make_defname( $file ) ),
                  lib => File::Spec->catfile( $outdir, length( $libname ) ?
                                              $libname : make_libname( $file )
                                            ),
                } ;
  }
}

if( $needs_help ) {
  help();
  exit 1;
}

die "no input files" unless @dlls;

foreach ( @dlls ) {
  make_def( $_->{dll}, $_->{def} );
  make_lib( $_->{def}, $_->{lib} );
}

#
# minor functions
#

sub help {
  print <<EOT;
Usage: perl make_implib.pl [--help] 
          [--output-dir=directory] [--output-lib=name]
          [--target=vc|mingw]
          [--verbose] dlls....

Creates an import library from the given dlls.
The library is named dllbase.lib (MSVC) or libdllbase.a (MinGW)

  --help            show this message
  --output-lib=name when creating a single import library overrides
                    the output library name
  --output-dir=dir  output directory for import libraries and DEF files,
                    defaults to the current directory
  --target=vc|mingw if target is vc, produces a Visual C++ import library
                    if target isa mingw, produces a MinGW32 import library
                    ( requires either of MinGW32 or VC++ )
  --verbose         shows the output of subcommands ( useful only for
                    debugging )
EOT
}

# Local variables: #
# mode: cperl #
# End: #
