package wxMMUtils;

use strict;
use Config;
use base 'Exporter';

use vars qw(@EXPORT @EXPORT_OK);
@EXPORT = qw(obj_from_src top_dir building_extension
             xs_depend merge_config wx_version wx_config is_platform
             get_platform is_debug is_inside_wxperl_tree);
@EXPORT_OK = qw(unix_top_dir);

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

#
#
#
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

#
# Makes dependencies for
# *.xs, *.c (from *.xs), *.obj (from *.xs) and
#
sub xs_depend {
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

  %depend;
}

#
# computes the name for an object file, given
# the source file name
#
sub obj_from_src {
  my( @xs ) = @_;
  my( $obj_ext ) = $Config{obj_ext} || $Config{_o};

  foreach( @xs ) {
    $_ =~ s[\.(?:xs|c|cc|cpp)$][$obj_ext]e;
  }

  if( wantarray ) { return @xs }
  else { return $xs[0] };
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
      $file = MM->catfile( split '/', $file );
      foreach my $dir ( @$incpath ) {
        my $f = $dir eq MM->curdir ? $file : MM->catfile( $dir, $file );
        if( -f $f ) {
          push @$arr, $f;
          my( $cinclude, $xsinclude ) = scan_xs( $f, $incpath );
          push @cinclude, @$cinclude;
          push @xsinclude, @$xsinclude;
          last;
        } elsif( $file =~ m/ovl_const\.(?:cpp|h)/i ) {
          my $dir = top_dir();
          push @$arr, ( ( $dir eq MM->curdir ) ?
                                         $file :
                                         MM->catfile( top_dir(), $file ) );
        }
      }
    }
  }

  close IN;

  ( \@cinclude, \@xsinclude );
}

1;

# Local variables: #
# mode: cperl #
# End: #
