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
use base 'Win32';
use wxMMUtils;

#
# wx-config-like
#
sub wx_config {
  my $makefile = MM->catfile( top_dir(), 'build', 'gmake.mak' );

  my $final = $wxConfig::debug_mode ? 'FINAL=hybrid' : 'FINAL=1';
  my $t = qx(make -s -f $makefile @_ $final);
  chomp $t;
  return $t;
}

sub wx_lib {
  my( $this, $lib ) = @_;
  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . MM->catfile( wx_config( 'wxdir' ), 'lib',
                            $lib . $Config{lib_ext} ) . ' ';
}

#
# takes parametes form make*.env
#
sub configure {
  my( $cccflags, $ldflags, $libs );

  my $wximplib = MM->catfile( top_dir(), qw(blib arch auto Wx Wx.a) );
  my( %config ) =
    ( CC => 'g++ ',
      LD => 'g++ ',
      CCFLAGS => " $wxConfig::extra_cflags -fvtable-thunks ",
      LIBS => " $wxConfig::extra_libs ",
      clean => { FILES => 'dll.base dll.exp ' },
      INC => ' -I' . top_dir() . ' ',
      ( building_extension() ?
        ( DEFINE => ' -DWXPL_EXT ',
          LDFROM => ' $(OBJECT) ' . ( $wxConfig::use_shared ? $wximplib : '' ) . ' ',
        ) :
        ( depend => { 'Wx_res.o' => 'Wx.rc ', },
          LDFROM => '$(OBJECT) Wx_res.o',
          dynamic_lib => { INST_DYNAMIC_DEP => 'Wx_res.o',
                           OTHERLDFLAGS => " "},
        )
      ),
    );

  if( $wxConfig::debug_mode ) {
    $config{CCFLAGS} .= ' -g ';
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
  my( $this ) = shift;
  my( $wxdir ) = wx_config( 'wxdir' );
  my( $implib ) = wx_config( 'implib' );
  $implib =~ s/lib(\w+)\.\w+$/$1\.dll/;

  my $text = $this->SUPER::postamble( @_ );
  $text .= <<EOT;
Wx_res.o: Wx.rc
\twindres --include-dir ${wxdir}\\include Wx.rc Wx_res.o

ppmdist: pure_all ppd
\t\$(CP) ${implib} blib\\arch\\auto\\Wx
\tstrip blib\\arch\\auto\\Wx\\*.dll
\t\$(TAR) \$(TARFLAGS) \$(DISTVNAME)-ppm.tar blib
\tgzip --force --best \$(DISTVNAME)-ppm.tar

EOT

  $text;
}

#
# current command line breaks in dmake ( used braces in qq{} )
#
sub ppd {
  my $this = shift;
  package MY;
  my $text = $this->SUPER::ppd( @_ );

  $text =~ tr/\{\}/##/;

  return $text;
}

#
# fixes link command line to use g++ instead of dlltool
#
sub dynamic_lib {
  my( $this ) = shift;
  package MY;
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
