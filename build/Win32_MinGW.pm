############################################################################
## Name:        Win32_MinGW.PL
## Purpose:     build helper for MinGW
## Author:      Mattia Barbon
## Modified by:
## Created:     11/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Win32_MinGW;

use strict;
use Config;
use base 'W32';
use wxMMUtils;

#
# wx-config-like
#
sub my_wx_config {
  my $class = shift;
  my $makefile = MM->catfile( top_dir(), 'build', 'gmake.mak' );

  my $final = $wxConfig::debug_mode ? 'FINAL=0' : 'FINAL=1';
  my $unicode = $wxConfig::unicode_mode ? 'UNICODE=1' : 'UNICODE=0';
  my $t = qx(make -s -f $makefile @_ $final $unicode);
  chomp $t;
  return $t;
}

sub wx_contrib_lib {
  my( $this, $lib ) = @_;
  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . MM->catfile( wx_config( 'wxdir' ),
                            ( wx_version() < 2.003 ? 'contrib' : () ),
                            'lib',
                            'lib' . $lib . $Config{lib_ext} ) . ' ';
}

sub res_file { "Wx_res.o" }

#
# takes parametes form make*.env
#
use vars qw(%config);
sub configure {
  my( $cccflags, $ldflags, $libs );
  my $this = shift;
  local *config; *config = $this->SUPER::configure();

  my $wximplib = MM->catfile( top_dir(), qw(blib arch auto Wx Wx.a) );
  $config{CC} = 'g++';
  $config{LD} = 'g++';
  $config{CCFLAGS} .= ' -fvtable-thunks ';
  $config{clean} = { FILES => 'dll.base dll.exp ' };
  if( building_extension() && $wxConfig::use_dllexport ) {
    $config{LDFROM} .= "\$(OBJECT) $wximplib ";
  }

  if( $wxConfig::debug_mode ) {
    $config{CCFLAGS} .= ' -g ';
    $config{OPTIMIZE} = ' ';
  } else {
    $config{dynamic_lib}{OTHERLDFLAGS} .= ' -s ';
  }

  $cccflags = wx_config( 'cccflags' );
  $libs = wx_config( 'libs' );

  foreach ( split ' ', $cccflags ) {
    m(^[-/]DSTRICT) && next;
    m(^-W.*) && next; # under Win32 -Wall gives you TONS of warnings
    m(^-I) && do { $config{INC} .= $_ . ' '; next; };
    m(^-D) && do { $config{DEFINE} .= $_ . ' '; next; };
    $config{CCFLAGS} .= $_ . ' ';
  }

  foreach ( split ' ', $libs ) {
    m(wx)i || next;
    $config{LIBS} .= $_ . ' ';
  }

  \%config;
}

#
# for .rc file compilation and automatic export list generation
#
sub postamble {
  my $this = shift;
  my $wxdir = wx_config( 'wxdir' );
  my $text = $this->SUPER::postamble( @_ );

  $text .= <<EOT;

Wx_res.o: Wx.rc
\twindres --include-dir ${wxdir}\\include Wx.rc Wx_res.o

EOT

  return $text;
}

#
# current command line breaks in dmake ( used braces in qq{} )
#
sub ppd {
  my $this = shift;
  my $text = $this->SUPER::ppd( @_ );

  $text =~ tr/\{\}/##/;

  $text;
}

#
# fixes link command line to use g++ instead of dlltool
#
sub dynamic_lib {
  my( $this ) = shift;
  my( $text ) = $this->SUPER::dynamic_lib( @_ );

  return $text unless $wxConfig::use_shared && $text =~ m/dlltool/i;

  my $wximplib = MM->catfile( wxConfig::top_dir(),
                              qw(blib arch auto Wx Wx.a) );
  my $create_implib = $this->{PARENT} ?
    '' : " -Wl,--out-implib,$wximplib ";
  my $strip = $wxConfig::debug_mode ? '' : ' -s ';

  $text =~ s{(?:^\s+(?:dlltool|\$\(LD\)).*\n)+}
    {\tg++ -shared $strip -o \$@ \$(LDFROM) $create_implib \$(MYEXTLIB) \$(PERL_ARCHIVE) \$(LDLOADLIBS)\n}m;
  # \$(LDDLFLAGS) : in MinGW passes -mdll, and we use -shared...

  $text;
}

1;

# Local variables: #
# mode: cperl #
# End: #
