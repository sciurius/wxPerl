package Wx::build::Config::Win32_MinGW;

use strict;
use base 'Wx::build::Config::Win32';
use File::Spec::Functions qw(catfile catdir rel2abs canonpath);
use File::Basename 'dirname';
use Cwd ();
use Config;

my( $makefile, $min_dir ) = __PACKAGE__->_init( 'gmake.mak' );

sub _data {
  my $this = shift;
  return $this->{data} if $this->{data};

  my %data = ( 'cxx'     => 'g++',
               'ld'      => 'g++',
               'wxdir'   => $ENV{WXDIR},
             );

  my $final = $this->_debug ? 'BUILD=debug'
                            : 'BUILD=release';
  my $unicode = $this->_unicode ? 'UNICODE=1' : 'UNICODE=0';

  my $dir = Cwd::cwd;
  chdir $min_dir or die "chdir '$min_dir'";
  my @t = qx(make -n -f makefile.gcc $final $unicode);

  my( $libdir );
  foreach ( @t ) {
    chomp;

    if( m/\s-l\w+/ ) {
      s/^[cg]\+\+//;
      s/(?:\s|^)-[co]//g;
      s/\s+\S+\.(exe|o)/ /gi;
      s{[-/]L(\S+)}{'-L' . ( $libdir = canonpath( rel2abs( $1 ) ) )}eg;
      $data{libs} = $_;
    } elsif( s/^\s*g\+\+\s+// ) {
      s/\s+\S+\.(cpp|o)/ /g;
      s/(?:\s|^)-[co]//g;
      s{[-/]I(\S+)}{'-I' . canonpath( rel2abs( $1 ) )}egi;
      s{[-/]I(\S+)[\\/]samples[\\/]minimal(\s|$)}{-I$1\\contrib\\include }i;
      s{[-/]I(\S+)[\\/]samples(\s|$)}{ }i;
      $data{cxxflags} = $_;
    }
  }

  chdir $dir or die "chdir '$dir'";

  $data{dlls} = $this->_grep_dlls( $libdir );

  {
    my $tmp = $data{dlls}{core}{dll};
    $tmp =~ m/^\D+(\d+)/;
    $data{version} = $1;
  }
  $this->{data} = \%data;
}

sub wx_config_24 {
  my $this = shift;

  if( $_[0] eq 'dlls' ) {
    my $implib = $this->wx_config( 'implib' );
    my $dll = $implib;
    $dll =~ s/\.a$/.dll/; $dll =~ s/lib(wx[\w\.]+)$/$1/;
    return { core => { dll => $dll, lib => $implib } };
  }

  my $final = $this->_debug ? 'FINAL=0' : 'FINAL=1';
  my $unicode = $this->_unicode ? 'UNICODE=1' : 'UNICODE=0';
  my $t = qx(make -s -f $makefile @_ $final $unicode);
  chomp $t;
  return $t;
}

sub get_core_lib_25 {
  my( $this, @libs ) = @_;
  my $dlls = $this->wx_config( 'dlls' );

  return join ' ',
    map { exists( $dlls->{$_} ) ? $dlls->{$_}{lib} :
                                  die "No such lib '$_'" }
    @libs;
}

sub get_core_lib_24 {
  my( $this, @libs ) = @_;
  my $dlls = $this->wx_config( 'dlls' );

  return ' ' . join ' ',
    map {
        m/^(?:xrc|stc)$/     ? $this->get_contrib_lib( $_ ) :
        exists($dlls->{$_} ) ? $dlls->{$_}{lib}           :
                               die "No such lib: '$_'";
    }
    grep { !m/^(?:adv|base|html|net|xml)$/ } @libs;
}

sub get_contrib_lib {
  my( $this, $lib ) = @_;

  $lib = 'wxxrc' if $lib eq 'xrc';
  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . catfile( $this->wx_config( 'wxdir' ),
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
