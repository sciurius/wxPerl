package Wx::build::Utils;

use strict;
use Config;
use base 'Exporter';
use File::Spec::Functions qw(curdir catdir catfile updir);

use vars qw(@EXPORT @EXPORT_OK);
@EXPORT_OK = qw(obj_from_src xs_dependencies write_string
                lib_file arch_file arch_auto_file
                path_search);
#@EXPORT = qw(obj_from_src);
#@EXPORT_OK = qw(unix_top_dir top_dir building_extension
#                xs_depend merge_config wx_version wx_config is_platform
#                get_platform is_debug is_inside_wxperl_tree path_search);

=head1 NAME

Wx::build::Utils - utility routines

=head1 SUBROUTINES

=cut

=begin cut

#
# convenience function
#
sub wx_config {
  $wxConfig::Arch->my_wx_config( @_ );
}

#
# is that platform/toolkit (msw, motif, gtk, mac)
#
sub is_platform($) {
  my $uc = uc shift;
  return scalar( wx_config( 'cxxflags' ) =~ m/__WX${uc}__/ );
}

sub get_platform() {
  my $cf = wx_config( 'cxxflags' );
  $cf =~ m/__WX(x11|msw|motif|gtk|mac)__/i && return lc $1;

  die "Unable to determine toolkit!";
}

sub is_debug() {
  return scalar( wx_config( 'cxxflags' ) =~ m/__WXDEBUG__/ );
}

#
# wxWindows version as M.mmm_sss
#
sub wx_version() {
  no strict 'refs';

  my $ver = wx_config( 'version' );

  $ver =~ m/(\d+)\.(\d+)\.(\d+)/ &&
    return $1 + $2 / 1000 + $3 / 1000000;
  $ver =~ m/(\d)(\d+)_(\d+)/ &&
    return $1 + $2 / 1000 + $3 / 1000000;
  $ver =~ m/(\d)(\d)(\d+)/ &&
    return $1 + $2 / 1000 + $3 / 1000000;

  die "unable to get wxWindows'version";
}

#
# relative UNIX-ish path to the top dir
#
sub unix_top_dir() {
  my $utop = '.';
  my $top = MM->curdir;
  my $count = 0;

  until( $count == 10 || -f MM->catfile( $top, 'Wx.pm' ) ) {
    $top = MM->catdir( MM->updir, $top );
    $utop = "../$utop";
    ++$count;
  }

  # we are outsize wxPerl source tree
  if( $count == 10 ) {
    my $build = $INC{'wxConfig.pm'};
    $build =~ s{\Wbuild\WwxConfig\.pm$}{};
    die "unable to find unix_top_dir" unless -f "$build/Wx.pm";
    $utop = $build;
  }

  return $utop;
}

#
# relative path to the top dir ( the one containing Wx.pm )
#
sub top_dir() {
  my $top = MM->curdir;
  my $count = 0;

  until( $count == 10 || -f MM->catfile( $top, 'Wx.pm' ) ) {
    $top = MM->catdir( MM->updir, $top );
    ++$count;
  }

  if( $count == 10 ) {
    my $build = $INC{'wxConfig.pm'};
    $build =~ s{\Wbuild\WwxConfig\.pm$}{};
    die "unable to find top_dir" unless -f "$build/Wx.pm";
    $top = $build;
  }
  return MM->canonpath( $top );
}

sub building_extension() {
  return !-f 'Wx.pm';
}

sub is_inside_wxperl_tree() {
  my $top = MM->curdir;
  my $count = 0;

  until( $count == 10 ) {
    return 1 if -f MM->catfile( $top, 'Wx.pm' );
    $top = MM->catdir( MM->updir, $top );
    ++$count;
  }

  return 0;
}

sub path_search {
  my $file = shift;

  foreach my $d ( split $Config{path_sep}, $ENV{PATH} ) {
    my $full = MM->catfile( $d, $file );
    return $full if -f $full;
  }

  return;
}

=end

#
#
#

=begin cut

use vars qw(%cfg1 %cfg2);
sub merge_config {
  my( $cfg1, $cfg2 ) = @_;
  local *cfg1 = $cfg1;
  local *cfg2 = $cfg2;
  my %cfg = %cfg1;

  foreach my $i ( keys %cfg2 ) {
    if( exists $cfg{$i} ) {
      if( $i eq 'LIBS' ) {
        my @a = ref(  $cfg{LIBS} ) ? @{$cfg{LIBS}} : ( $cfg{LIBS} );
        my @b = ref( $cfg2{LIBS} ) ? @{$cfg2{LIBS}} : ( $cfg2{LIBS} );

        my @c;
        foreach my $i ( @b ) {
          foreach my $j ( @a ) {
            push @c, " $i $j $i ";
          }
        }

        $cfg{LIBS} = \@c;
        next;
      }

      if( ref($cfg{$i}) || ref($cfg2{$i}) ) {
        die "non scalar key '$i'";
        $cfg{$i} = $cfg2{$i};
      } else {
        $cfg{$i} .= ' ' . $cfg2{$i};
      }
    } else {
      $cfg{$i} = $cfg2{$i};
    }
  }

  return \%cfg;
}

=end

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
    m/^\s*INCLUDE:\s+.*\s(\S+\.xsp)\s*\|/ and $file = $1 and
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

=head path_search

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

1;

# local variables:
# mode: cperl
# end:
