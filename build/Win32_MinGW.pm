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

package wxConfig;

use strict;

push @EXPORT_OK, qw(postamble dynamic_lib  top_targets ppd);
push @{ $EXPORT_TAGS{MY} }, qw(dynamic_lib  top_targets ppd);

#
# wx-config-like
#
sub wx_config {
  my $makefile = MM->catfile( top_dir(), 'build', 'gmake.mak' );

  my $final = $debug_mode ? 'FINAL=hybrid' : 'FINAL=1';
  my $t = qx(make -s -f $makefile @_ $final);
  chomp $t;
  return $t;
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
      CCFLAGS => $extra_cflags . ' -fvtable-thunks ',
      LIBS => $extra_libs . ' ',
      clean => { FILES => 'dll.base dll.exp ' },
      INC => ' -I' . top_dir() . ' ',
      ( building_extension() ?
        ( DEFINE => ' -DWXPL_EXT ',
          LDFROM => ' $(OBJECT) ' . ( $use_shared ? $wximplib : '' ) . ' ',
        ) :
        ( depend => { 'Wx_res.o' => 'Wx.rc ', },
          LDFROM => '$(OBJECT) Wx_res.o',
          dynamic_lib => { INST_DYNAMIC_DEP => 'Wx_res.o',
                           OTHERLDFLAGS => " "},
        )
      ),
    );

  if( $debug_mode ) {
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

  if( $Verbose >= 1 ) {
    foreach (keys %config) {
      m/^[A-Z]+$/ || next;
      print( $_ ," => ", $config{$_}, "\n" );
    }
  }

  \%config;
}

#
# for .rc file compilation and automatic export list generation
#
sub sysdep_postamble {
  my( $this ) = shift;
  my( $wxdir ) = wx_config( 'wxdir' );
  my( $implib ) = wx_config( 'implib' );
  $implib =~ s/lib(\w+)\.\w+$/$1\.dll/;

  my $text = <<EOT;
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

sub top_targets {
  package MY;

  my $this = shift;
  my $text = $this->SUPER::top_targets( @_ );

  $text =~ s{^(\w+\s*:+.*?)subdirs(.*?)linkext(.*?)$}
            {$1linkext$2subdirs$3}m;

  $text;
}

#
# current command line breaks in dmake ( used braces in qq{} )
#
sub ppd {
  package MY;

  my $this = shift;
  my $text = $this->SUPER::ppd( @_ );

  #$text =~ s/\\\"/\\x22/g;
  $text =~ tr/\{\}/##/;

  return $text;
}

#
# fixes link command line to use g++ instead of dlltool
#
sub dynamic_lib {
  package MY;

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

