############################################################################
## Name:        Win32_MSVC.PL
## Purpose:     build helper for MS VC++
## Author:      Mattia Barbon
## Modified by:
## Created:     11/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Win32_MSVC;

use strict;
use Config;
use base 'W32';
use wxMMUtils;

#
# wx-config-like
#
sub my_wx_config {
  my $class = shift;
  my $makefile = MM->catfile( top_dir(), 'build', 'nmake.mak' );

  if( $Config{make} eq 'nmake' ) {
    my $final = $wxConfig::debug_mode ? 'FINAL=hybrid' : 'FINAL=1';
    my $unicode = $wxConfig::unicode_mode ? 'UNICODE=1' : 'UNICODE=0';
    my $t = qx(nmake /nologo /s /f $makefile @_ $final $unicode);
    chomp $t;
    return $t;
  }
}

sub wx_contrib_lib {
  my( $this, $lib ) = @_;
  my $suff = $wxConfig::debug_mode ? 'h' : '';

  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . MM->catfile( wx_config( 'wxdir' ),
                            ( wx_version() < 2.003 ? 'contrib' : () ), 'lib',
                            $lib . $suff . $Config{lib_ext} ) . ' ';
}

sub res_file { "Wx.res" }

#
# takes parametes from make*.env
#
use vars qw(%config);
sub configure {
  my( $cccflags, $ldflags, $libs );
  my $this = shift;
  local *config; *config = $this->SUPER::configure();

  my $wximppath = MM->catdir( top_dir(), qw(blib arch auto Wx) );
  my $wximplib = MM->catfile( $wximppath, 'Wx.lib' );
  $config{CCFLAGS} .= " -TP ";
  $config{clean} = { FILES => '*.pdb *.res *_def.old ' };

  if( building_extension() && $wxConfig::use_dllexport ) {
    $config{LDFROM} .= "\$(OBJECT) $wximplib ";
  }
  if( $wxConfig::debug_mode ) {
    $config{dynamic_lib}{OTHERLDFLAGS} .= ' -debug ';
    $config{OPTIMIZE} = ' ';
  }

  $cccflags = wx_config( 'cccflags' );
  $libs = wx_config( 'libs' );

  foreach ( split ' ', $cccflags ) {
    m(^[-/]DSTRICT) && next;
    m(^[-/]I) && do { $config{INC} .= $_ . ' '; next; };
    m(^[-/]D) && do { $config{DEFINE} .= $_ . ' '; next; };
    $config{CCFLAGS} .= $_ . ' ';
  }

  foreach ( split ' ', $libs ) {
    m(wx)i || next;
    $config{LIBS} .= $_ . ' ';
  }

  \%config;
}

sub dynamic_lib {
  my $this = shift;
  my $text = $this->SUPER::dynamic_lib( @_ );

  $text =~ s{[/-]def:[^\s]+}{}i;

  $text;
}

#
# for .rc file compilation and automatic export list generation
#
sub postamble {
  my $this = shift;
  my $wxdir = wx_config( 'wxdir' );
  my $text = $this->SUPER::postamble( @_ ) || '';

  $text .= <<EOT;

Wx.res: Wx.rc
\trc -I${wxdir}\\include Wx.rc

EOT

  $text;
}

sub const_config {
  my $this = shift;
  package MY;
  my $text = $this->SUPER::const_config( @_ );

  $text =~ s{[/-]nodefaultlib}{}gi;

  $text;
}

1;

# Local variables: #
# mode: cperl #
# End: #
