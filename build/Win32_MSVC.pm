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

package wxConfig;

use strict;

push @EXPORT_OK, qw(dynamic_lib top_targets);
push @{ $EXPORT_TAGS{MY} }, qw(dynamic_lib top_targets);

#
# wx-config-like
#
sub wx_config {
  my $makefile = MM->catfile( top_dir(), 'build', 'nmake.mak' );

  if( $Config{make} eq 'nmake' ) {
    my( $final ) = $debug_mode ? 'FINAL=hybrid' : 'FINAL=1';
    return qx(nmake /nologo /s /f $makefile @_ $final);
  }
}

#
# takes parametes form make*.env
#
sub configure {
  my( $cccflags, $ldflags, $libs );

  my $wximppath = MM->catdir( top_dir(), qw(blib arch auto Wx) );
  my $wximplib = MM->catfile( $wximppath, 'Wx.lib' );
  my( %config ) =
    ( CCFLAGS => $extra_cflags . ' -TP ',
      LIBS => " $extra_libs " ,
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

  if( $debug_mode ) {
#    $config{CCFLAGS} .= ' -Zi ';
    $config{dynamic_lib}{OTHERLDFLAGS} .= ' -debug ';
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

  if( $Verbose >= 1 ) {
    foreach (keys %config) {
      m/^[A-Z]+$/ || next;
      print( $_ ," => ", $config{$_}, "\n" );
    }
  }

  \%config;
}

sub dynamic_lib {
  package MY;

  my $this = shift;
  my $text = $this->SUPER::dynamic_lib( @_ );

  $text =~ s{[/-]def:[^\s]+}{}i;

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
# for .rc file compilation and automatic export list generation
#
sub sysdep_postamble {
  my( $this ) = shift;
  my( $wxdir ) = wx_config( 'wxdir' );

  chomp $wxdir;

  my $text = <<EOT;

Wx.res: Wx.rc
\trc -I${wxdir}\\include Wx.rc

EOT

  $text;
}

1;

# Local variables: #
# mode: cperl #
# End: #
