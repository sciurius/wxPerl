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

push @EXPORT_OK, qw(postamble dynamic_lib);
push @{ $EXPORT_TAGS{MY} }, qw(dynamic_lib);

#
# wx-config-like
#
sub wx_config {
  my $makefile = MM->catfile( top_dir(), 'build', 'gmake.mak' );

  my $final = $debug_mode ? 'FINAL=hybrid' : 'FINAL=1';
  return qx(make -s -f $makefile @_ $final);
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
      ( building_extension() ?
        ( INC => ' -I' . top_dir() . ' ',
          DEFINE => ' -DWXPL_EXT ',
          LDFROM => ' $(OBJECT) ' . $wximplib . ' ',
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

  foreach (keys %config) {
    m/^[A-Z]+$/ || next;
    print( $_ ," => ", $config{$_}, "\n" );
  }

  \%config;
}

my( $exp, $evt, $cst );
sub BEGIN {
  $exp = MM->catfile( 'blib', 'lib', 'Wx', '_Exp.pm' );
  $evt = MM->catfile( 'lib', 'Wx', 'Event.pm' );
  $cst = MM->catfile( 'lib', 'Wx', '_Constants.pm' );
}

#
# for .rc file compilation and automatic export list generation
#
sub sysdep_postamble {
  my( $this ) = shift;
  my( $wxdir ) = wx_config( 'wxdir' );

  chomp $wxdir;

  my $text = <<EOT;
Wx_res.o: Wx.rc
\twindres --include-dir ${wxdir}\\include Wx.rc Wx_res.o

EOT

  $text;
}

#
# fixes link command line to use g++ instead of dlltool
#
sub dynamic_lib {
  package MY;

  my( $this ) = shift;
  my( $text ) = $this->SUPER::dynamic_lib( @_ );

  return $text unless $text =~ m/dlltool/i;

  my $wximplib = MM->catfile( wxConfig::top_dir(),
                              qw(blib arch auto Wx Wx.a) );
  my $create_implib = $this->{PARENT} ?
    '' : " -Wl,--out-implib,$wximplib ";

  $text =~ s{(?:^\s+(?:dlltool|\$\(LD\)).*\n)+}
    {\tg++ -shared -o \$@ \$(LDFROM) $create_implib \$(MYEXTLIB) \$(PERL_ARCHIVE) \$(LDLOADLIBS)\n}m;
  # \$(LDDLFLAGS) : in MinGW passes -mdll, and we use -shared...

  $text;
}

1;

# Local variables: #
# mode: cperl #
# End: #

