package wxMMUtils;

use strict;
use Config;
use base 'Exporter';

use vars qw(@EXPORT);
@EXPORT = qw(obj_from_src top_dir building_extension
             xs_depend merge_config wx_version wx_config is_platform);

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
  return scalar( wx_config('cxxflags' ) =~ m/__WX${uc}__/ );
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
# relative path to the top dir ( the one containing Wx.pm )
#
sub top_dir() {
  my $top = MM->curdir;

  until( -f MM->catfile( $top, 'Wx.pm' ) ) {
    $top = MM->catdir( MM->updir, $top );
  }

  return MM->canonpath( $top );
}

sub building_extension() {
  return !-f 'Wx.pm';
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
        warn "non scalar key '$i'";
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

    if( defined $file ) {
      foreach my $dir ( @$incpath ) {
        my $f = MM->catfile( $dir, $file );
        if( -f $f ) {
          push @$arr, $f;
          my( $cinclude, $xsinclude ) = scan_xs( $f, $incpath );
          push @cinclude, @$cinclude;
          push @xsinclude, @$xsinclude;
          last;
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
