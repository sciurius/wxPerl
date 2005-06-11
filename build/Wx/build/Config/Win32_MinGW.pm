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
  $unicode .= ' MSLU=1' if $this->_mslu;

  my $dir = Cwd::cwd;
  chdir $min_dir or die "chdir '$min_dir'";
  my @t = qx(make -n -f makefile.gcc $final $unicode SHARED=1);

  my( $libdir, $digits );
  foreach ( @t ) {
    chomp;

    if( m/\s-l\w+/ ) {
      m/-lwxbase(\d+)/ and $digits = $1;
      s/^[cg]\+\+//;
      s/(?:\s|^)-[co]//g;
      s/\s+\S+\.(exe|o)/ /gi;
      s{-L(\S+)}
       {'-L' . ( $libdir = Wx::build::Config::is_wxPerl_tree() ?
                           canonpath( rel2abs( $1 ) )   :
                           catfile( $this->get_arch_directory, 'auto', 'Wx' ) )
        }eg;
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

  $data{dlls} = $this->_grep_dlls( $libdir, $digits );

#  {
#    my $tmp = $data{dlls}{core}{dll};
#    $tmp =~ m/^\D+(\d+)/;
    $data{version} = $digits;
#  }
  $this->{data} = \%data;
}

sub wx_config_24 {
  my $this = shift;

  if( $_[0] eq 'dlls' ) {
    my $implib = $this->wx_config( 'implib' );
    $implib = $this->_replace_implib_24( $implib )
      unless Wx::build::Config::is_wxPerl_tree();
    my $dll = $implib;
    $dll =~ s/\.a$/.dll/; $dll =~ s/lib(wx[\w\.]+)$/$1/;
    return { core => { dll => $dll, lib => $implib } };
  }

  my $final = $this->_debug ? 'FINAL=0' : 'FINAL=1';
  my $unicode = $this->_unicode ? 'UNICODE=1' : 'UNICODE=0';
  $unicode .= ' EXTRALIBS=-lunicows' if $this->_mslu;
  my $t = qx(make -s -f $makefile @_ $final $unicode CXXFLAGS=-Os);
  chomp $t;
  if( $_[0] eq 'libs' && !Wx::build::Config::is_wxPerl_tree() ) {
    return $this->_replace_implib_24( $t );
  }
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
        return () if m/^gl$/ && $^O eq 'MSWin32';

        m/^(?:xrc|stc)$/     ? $this->get_contrib_lib( $_ ) :
        exists($dlls->{$_} ) ? $dlls->{$_}{lib}           :
                               die "No such lib: '$_'";
    }
#   FXME: core
    grep { !m/^(?:adv|base|html|net|xml|core)$/ } @libs;
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
    m(wx|unicows)i || next;
    next if m{(?:wx(?:zlib|regexu?|expat|png|jpeg|tiff))$};
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
