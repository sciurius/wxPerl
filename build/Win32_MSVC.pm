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
use base 'Win32';
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

sub wx_lib {
  my( $this, $lib ) = @_;
  my $suff = $wxConfig::debug_mode ? 'h' : '';

  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . MM->catfile( wx_config( 'wxdir' ), 'lib',
                            $lib . $suff . $Config{lib_ext} ) . ' ';
}

#
# takes parametes from make*.env
#
sub configure {
  my( $cccflags, $ldflags, $libs );

  my $wximppath = MM->catdir( top_dir(), qw(blib arch auto Wx) );
  my $wximplib = MM->catfile( $wximppath, 'Wx.lib' );
  my( %config ) =
    ( CCFLAGS => " $wxConfig::extra_cflags -TP ",
      LIBS => " $wxConfig::extra_libs ",
      clean => { FILES => '*.pdb *.res *_def.old ' },
      ( building_extension() ?
        ( INC => ' -I'. top_dir() . ' ',
          DEFINE => '-DWXPL_EXT ',
  # this is *WEIRD*: for MakeMaker to include Wx.lib in link libraries
  # it must be present...
          LDFROM => "\$(OBJECT) $wximplib ",
        ) :
        ( depend => { 'Wx.res' => 'Wx.rc ' },
          LDFROM => "\$(OBJECT) Wx.res ",
          dynamic_lib => { INST_DYNAMIC_DEP => 'Wx.res', },
        )
      ),
    );

  if( $wxConfig::debug_mode ) {
#    $config{CCFLAGS} .= ' -Zi ';
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
  package MY;
  my $text = $this->SUPER::dynamic_lib( @_ );

  $text =~ s{[/-]def:[^\s]+}{}i;

  $text;
}

#
# for .rc file compilation and automatic export list generation
#
sub postamble {
  my( $this ) = shift;
  my( $wxdir ) = wx_config( 'wxdir' );
  my( $implib ) = wx_config( 'implib' );
  $implib =~ s/\.\w+$/\.dll/;

  my $text = $this->SUPER::postamble( @_ );
  $text .= <<EOT;

Wx.res: Wx.rc
\trc -I${wxdir}\\include Wx.rc

ppmdist: pure_all ppd
\t\$(MV) Wx.ppd ..
\t\$(CP) ${implib} blib\\arch\\auto\\Wx
\t\$(TAR) \$(TARFLAGS) ..\\\$(DISTVNAME).tar blib
\tgzip --force --best ..\\\$(DISTVNAME).tar

EOT

  $text;
}

1;

# Local variables: #
# mode: cperl #
# End: #
