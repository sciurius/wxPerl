package Wx::build::Utils;

use strict;
use Config;
use base 'Exporter';
use File::Spec::Functions qw(curdir catdir catfile updir);
use File::Find qw(find);

use vars qw(@EXPORT @EXPORT_OK);
@EXPORT_OK = qw(obj_from_src xs_dependencies write_string
                lib_file arch_file arch_auto_file
                path_search files_with_overload files_with_constants);

=head1 NAME

Wx::build::Utils - utility routines

=head1 SUBROUTINES

=head2 xs_dependencies

  my %dependencies = xs_dependencies( $mm_object, [ 'dir1', 'dir2' ] );

=cut

sub xs_dependencies {
  my( $this, $dirs ) = @_;

  my( %depend );
  my( $c, $o, $cinclude, $xsinclude );

  foreach ( keys %{ $this->{XS} } ) {
    ( $cinclude, $xsinclude ) = scan_xs( $_, $dirs );

    $c = $this->{XS}{$_};
    $o = obj_from_src( $c );

    $depend{ $c } = $_ . ' ' . join( ' ', @$xsinclude );
    $depend{ $o } = $c . ' ' . join( ' ', @$cinclude );
  }

  return %depend;
}

=head2 obj_from_src

  my @obj_files = obj_from_src( 'Foo.xs', 'bar.c', 'cpp/bar.cpp' );

Calculates the object file name from the source file name.
In scalar context returns the first file.

=cut

sub obj_from_src {
  my @xs = @_;
  my $obj_ext = $Config{obj_ext} || $Config{_o};

  foreach ( @xs ) { s[\.(?:xs|c|cc|cpp)$][$obj_ext] }

  return wantarray ? @xs : $xs[0];
}

sub _top_dir {
  my $d = curdir;

  for ( 1 .. 5 ) {
    return $d if -f catfile( $d, 'Wx.pm' );
    $d = catdir( updir, $d );
  }

  die "Unable to find top level directory";
}

#
# quick and dirty method for creating dependencies:
# considers files included via #include "..." or INCLUDE: ...
# (not #include <...>) and does not take into account preprocessor directives
#
sub scan_xs($$);

sub scan_xs($$) {
  my( $xs, $incpath ) = @_;

  local( *IN, $_ );
  my( @cinclude, @xsinclude );

  open IN, $xs;

  my $file;
  my $arr;

  while( defined( $_ = <IN> ) ) {
    undef $file;

    m/^\#\s*include\s+"([^"]*)"\s*$/ and $file = $1 and $arr = \@cinclude;
    m/^\s*INCLUDE:\s+(.*)$/ and $file = $1 and $arr = \@xsinclude;
    m/^\s*INCLUDE:\s+.*\s(\S+\.xsp?)\s*\|/ and $file = $1 and
      $arr = \@xsinclude;

    if( defined $file ) {
      $file = catfile( split '/', $file );

      foreach my $dir ( @$incpath ) {
        my $f = $dir eq curdir() ? $file : catfile( $dir, $file );
        if( -f $f ) {
          push @$arr, $f;
          my( $cinclude, $xsinclude ) = scan_xs( $f, $incpath );
          push @cinclude, @$cinclude;
          push @xsinclude, @$xsinclude;
          last;
        } elsif( $file =~ m/ovl_const\.(?:cpp|h)/i ) {
          my $top = _top_dir();
          push @$arr, ( ( $top eq curdir() ) ?
                        $file :
                        catfile( $top, $file ) );
        }
      }
    }
  }

  close IN;

  ( \@cinclude, \@xsinclude );
}

=head2 write_string

  write_string( 'file', $scalar );

Convenience function, simply creates a file containing the string.

=cut

sub write_string {
  my( $file, $string ) = @_;
  local *OUT;
  open OUT, "> $file" or die "open '$file': $!";
  binmode *OUT;
  print OUT $string;
  close OUT or die "close: $!";
}

=head2 lib_file, arch_file, arch_auto_file

  my $file = lib_file( 'Foo.pm' );          # blib/lib/Foo.pm     on *nix
  my $file = lib_file( 'Foo/Bar.pm' );      # blib\lib\Foo\Bar.pm on Win32
  my $file = arch_auto_file( 'My\My.dll' ); # blib\arch\auto\My\My.dll

All input paths must be relative, output paths may be absolute.

=cut

sub _split {
  require File::Spec::Unix;

  my $path = shift;
  my( $volume, $dir, $file ) = File::Spec::Unix->splitpath( $path );
  my @dirs = File::Spec::Unix->splitdir( $dir );

  return ( @dirs, $file );
}

sub lib_file {
  my @split = _split( shift );

  return File::Spec->catfile( 'blib', 'lib', @split );
}

sub arch_file {
  my @split = _split( shift );

  return File::Spec->catfile( 'blib', 'arch', @split );
}

sub arch_auto_file {
  my @split = _split( shift );

  return File::Spec->catfile( 'blib', 'arch', 'auto', @split );
}

=head2 path_search

  my $file = path_search( 'foo.exe' );

Searches PATH for the given executable.

=cut

sub path_search {
  my $file = shift;

  foreach my $d ( File::Spec->path ) {
    my $full = File::Spec->catfile( $d, $file );
    return $full if -f $full;
  }

  return;
}

=head2 files_with_constants

  my @files = files_with_constants;

Finds files containing constants

=cut

sub files_with_constants {
  my @files;

  my $wanted = sub {
    my $name = $File::Find::name;

    m/\.(?:pm|xsp?|cpp|h)$/i && do {
      local *IN;
      my $line;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/^\W+\!\w+:/ && do {
          push @files, $name;
          return;
        };
      };
    };
  };

  find( $wanted, curdir );

  return @files;
}

=head2 files_with_overload

  my @files = files_with_overload;

Finds files containing overloaded XS/Perl subroutines

=cut

sub files_with_overload {
  my @files;

  my $wanted = sub {
    my $name = $File::Find::name;

    m/\.pm$/i && do {
      my $line;
      local *IN;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/Wx::_match/ && do {
          push @files, $name;
          return;
        };
      }
    };

    m/\.xsp?$/i && do {
      my $line;
      local *IN;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/wxPli_match_arguments|BEGIN_OVERLOAD\(\)/ && do {
          push @files, $name;
          return;
        };
      }
    };
  };

  find( $wanted, curdir );

  return @files;
}

1;

# local variables:
# mode: cperl
# end:
