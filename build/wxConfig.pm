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
use vars qw(@ISA @EXPORT_OK %EXPORT_TAGS);

# parse command line variables
use vars qw($debug_mode $extra_libs $extra_cflags);

LOOP: foreach ( @ARGV ) {
  m/^DEBUG=(\d+)$/ && do { $debug_mode = $1 ; undef $_; next LOOP; };
  m/^EXTRA_LIBS=(.*)$/ && do { $extra_libs = $1; undef $_; next LOOP; };
  m/^EXTRA_CFLAGS=(.*)$/ && do { $extra_cflags = $1; undef $_; next LOOP; };
}

require Exporter;
use Config;

@EXPORT_OK = qw(wx_config configure constants depend postamble
                xs_depend obj_from_src);
%EXPORT_TAGS = ( MY => [ qw(constants depend) ] );
@ISA = qw(Exporter);

# determines what package we must require
my $package_to_use;

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

    # default
    $package_to_use = 'Any_wx_config';
    last SWITCH;
  }
}

#
# TRUE if we are configuring an 'extension' ( ext/* )
#
sub building_extension {
  return !-f 'Wx.pm';
}

#
# relative path to the top dir ( the one containing Wx.pm )
#
sub top_dir {
  my $top = MM->curdir;

  until( -f MM->catfile( $top, 'Wx.pm' ) ) {
    $top = MM->catdir( MM->updir, $top );
  }

  return MM->canonpath( $top );
}

###########################
# subroutines to go in MY

#FIXME// this is an horrendous hack...
# since MakeMaker does only understand Makefile.PL une level below
# the top directory, and we need towo level below, we add one additional
# level to INST_* constants beginning with 'updir' ( usually '..' )
sub constants {
  package MY;

  my $this = shift;

  if( $this->{PARENT} ) {
    foreach my $k ( sort keys %$this ) {
      $k !~ m/^INST_/ && next;
      my $dir = $this->{$k};
      if( index( $dir, $this->updir ) == 0 ) {
        $this->{$k} = $this->catdir
          ( wxConfig::top_dir(), substr $this->{$k}, length( $this->updir ) );
#        substr( $this->{$k}, 0, length( $this->updir ) ) = top_dir();
      }
    }
  }

  $this->SUPER::constants( @_ );
}

#
# portable paths for blib/lib/Wx/_Exp.pm and lib/Wx/Event.pm
#
#FIXME// remove this and use File::Find and regexes...
my( $exp, $evt, $cst, $cst2 );
sub BEGIN {
  $exp = MM->catfile( 'blib', 'lib', 'Wx', '_Exp.pm' );
  $evt = MM->catfile( 'lib', 'Wx', 'Event.pm' );
  $cst = MM->catfile( 'lib', 'Wx', '_Constants.pm' );
  $cst2 = 'Constant.xs';
}

sub postamble {
  package MY;

  my $this = shift;
  my $text = wxConfig::sysdep_postamble( @_ );

  unless( $this->{PARENT} ) {
    $text .= <<EOT;

$exp :
\t\$(PERL) script/make_exp_list.pl $exp $cst2 $evt $cst

EOT
  }

  $text;
}

sub depend {
  my $this = shift;

  my %depend = ( xs_depend( $this, [ MM->curdir(), top_dir() ] ),
                 ( $this->{PARENT} ?
                   () :
                   ( $exp => join( ' ', $cst2 , $evt, $cst ),
                     '$(INST_STATIC)' => $exp,
                     '$(INST_DYNAMIC)' => $exp,
                   )
                 )
               );
  my %this_depend = @_;

  foreach ( keys %depend ) {
    $this_depend{$_} .= ' ' . $depend{$_};
  }

  package MY;

  $this->SUPER::depend( %this_depend );
}

#
# Some utility functions, mainly for dependency generation
#

#
# quick and dirty method for creating dependencies:
# considers files included via #include "..." or INCLUDE: ...
# (not #include <...>) and does not take into account preprocessor directives
#
sub scan_xs($$) {
  my( $xs, $incpath ) = @_;

  local( *IN, $_ );
  my( @cinclude, @xsinclude );

  open IN, $xs;

  my $file;
  my $arr;

  while( $_ = <IN> ) {
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
  my( $obj_ext ) = $Config{_o} || $Config{obj_ext};

  foreach( @xs ) {
    $_ =~ s[\.(?:xs|c|cc|cpp)$][$obj_ext]e;
  }

  if( wantarray ) { return @xs }
  else { return $xs[0] };
}

do "$package_to_use.pm" || die "$package_to_use: $!/$@";

package MY;

1;

__DATA__

# Local variables: #
# mode: cperl #
# End: #
