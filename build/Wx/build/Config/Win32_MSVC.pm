package Wx::build::Config::Win32_MSVC;

use strict;
use base 'Wx::build::Config::Win32';
use File::Spec::Functions qw(catfile);
use File::Basename 'dirname';
use Config;

my $makefile = catfile( dirname( $INC{'Wx/build/Config.pm'} ), 'Config',
                        'nmake.mak' );

die "Can't find makefile '$makefile'" unless -f $makefile;

sub wx_config {
  my $this = shift;

  if( $Config{make} eq 'nmake' ) {
    my $final = $this->_debug ? 'FINAL=hybrid DEBUGINFO=1' : 'FINAL=1';
    my $unicode = $this->_unicode ? 'UNICODE=1' : 'UNICODE=0';
    my $t = qx(nmake /nologo /s /f $makefile @_ $final $unicode);
    chomp $t;
    return $t;
  } else {
    die "PANIC: you are not using nmake!";
  }
}

sub get_contrib_lib {
  my( $this, $lib ) = @_;
  my $suff = $this->_debug ? 'h' : '';

  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . catfile( $this->wx_config( 'wxdir' ),
                        ( $this->get_wx_version() < 2.003 ? 'contrib' : () ),
                        'lib',
                        "${lib}${suff}$Config{lib_ext}" ) . ' ';
}

sub get_flags {
  my $this = shift;
  my %config = $this->SUPER::get_flags;

  $config{CCFLAGS} .= ' -GF -TP ';
  $config{clean}{FILES} .= ' *.pdb *.pdb *_def.old ';

  if( $this->_debug ) {
    $config{dynamic_lib}{OTHERLDFLAGS} .= ' -debug ';
    $config{OPTIMIZE} = ' ';
  }

  my $cccflags = $this->wx_config( 'cxxflags' );
  my $libs = $this->wx_config( 'libs' );

  foreach ( split /\s+/, $cccflags ) {
    m(^[-/]DSTRICT) && next;
    m(^[-/]I) && do {
      next if m{(?:regex|zlib|jpeg|png|tiff)$};
      $config{INC} .= "$_ ";
      next;
    };
    m(^[-/]D) && do { $config{DEFINE} .= "$_ "; next; };
    $config{CCFLAGS} .= "$_ ";
  }

  foreach ( split /\s+/, $libs ) {
    m(wx)i || next;
    next if m{(?:(?:zlib|regex)\w+\.lib)$};
    $config{LIBS} .= "$_ ";
  }

  return %config;
}

1;

# local variables:
# mode: cperl
# end:
