package Wx::build::Config::Win32_MinGW;

use strict;
use base 'Wx::build::Config::Win32';
use File::Spec::Functions qw'catfile';
use File::Basename 'dirname';
use Config;

my $makefile = catfile( dirname( $INC{'Wx/build/Config.pm'} ), 'Config',
                        'gmake.mak' );

die "Can't find makefile '$makefile'" unless -f $makefile;

sub wx_config {
  my $this = shift;

  my $final = $this->_debug ? 'FINAL=0' : 'FINAL=1';
  my $unicode = $this->_unicode ? 'UNICODE=1' : 'UNICODE=0';
  my $t = qx(make -s -f $makefile @_ $final $unicode);
  chomp $t;
  return $t;
}

sub get_contrib_lib {
  my( $this, $lib ) = @_;

  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . catfile( $this->wx_config( 'wxdir' ),
                        ( $this->get_wx_version() < 2.003 ? 'contrib' : () ),
                        'lib',
                        "lib${lib}$Config{lib_ext}" ) . ' ';
}

sub get_flags {
  my $this = shift;
  my %config = $this->SUPER::get_flags;

  $config{CC} = 'g++';
  $config{LD} = 'g++';
  $config{CCFLAGS} .= " -fvtable-thunks ";
  $config{clean}{FILES} .= 'dll.base dll.exp ';

  if( $this->_debug ) {
    $config{CCFLAGS} .= ' -g ';
    $config{OPTIMIZE} = '';
  } else {
    $config{dynamic_lib}{OTHERLDFLAGS} .= ' -s ';
  }

  my $cccflags = $this->wx_config( 'cxxflags' );
  my $libs = $this->wx_config( 'libs' );

  foreach ( split /\s+/, $cccflags ) {
    m(^-DSTRICT) && next;
    m(^-W.*) && next; # under Win32 -Wall gives you TONS of warnings
    m(^-I) && do {
      next if m{(?:regex|zlib|jpeg|png|tiff)$};
      $config{INC} .= "$_ ";
      next;
    };
    m(^-D) && do { $config{DEFINE} .= "$_ "; next; };
    $config{CCFLAGS} .= "$_ ";;
  }

  foreach ( split /\s+/, $libs ) {
    m(wx)i || next;
    $config{LIBS} .= "$_ ";
  }

  # add $MINGWDIR/lib to lib search path, to stop perl from complaining...
  my $path = Wx::build::Utils::path_search( 'gcc.exe' )
    or warn "Unable to find gcc";
  $path =~ s{bin[\\/]gcc\.exe$}{}i;
  $config{LIBS} = "-L${path}lib $config{LIBS}";

  return %config;
}

1;

# local variables:
# mode: cperl
# end:
