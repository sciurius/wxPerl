package Wx::build::Config::Win32_MSVC;

use strict;
use base 'Wx::build::Config::Win32';
use File::Spec::Functions qw(catfile catdir rel2abs canonpath);
use File::Basename 'dirname';
use Cwd ();
use Config;

my( $makefile, $min_dir ) = __PACKAGE__->_init( 'nmake.mak' );

sub _data {
  my $this = shift;
  return $this->{data} if $this->{data};

  my %data = ( 'cxx'     => 'cl',
               'ld'      => 'link',
               'wxdir'   => $ENV{WXDIR},
             );

  die "PANIC: you are not using nmake!" unless $Config{make} eq 'nmake';

  my $final = $this->_debug ? 'BUILD=debug   DEBUG_RUNTIME_LIBS=0'
                            : 'BUILD=release DEBUG_RUNTIME_LIBS=0';
  my $unicode = $this->_unicode ? 'UNICODE=1' : 'UNICODE=0';

  my $dir = Cwd::cwd;
  chdir $min_dir or die "chdir '$min_dir'";
  my @t = qx(nmake /nologo /n /u /f makefile.vc $final $unicode);

  my( $accu, $libdir );
  foreach ( @t ) {
    chomp;
    m/^\s*echo\s+(.*)>\s*\S+\s*$/ and $accu .= ' ' . $1 and next;
    s/\@\S+\s*$/$accu/ and undef $accu;

    if( s/^\s*link\s+// ) {
      s/\s+\S+\.(exe|res|obj)/ /g;
      s{[-/]LIBPATH:(\S+)}{'-L' . ( $libdir = canonpath( rel2abs( $1 ) ) )}egi;
      $data{libs} = $_;
    } elsif( s/^\s*cl\s+// ) {
      s/\s+\S+\.(cpp|pdb|obj)/ /g;
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
    $dll =~ s/\.lib$/.dll/;
    return { core => { dll => $dll, lib => $implib } };
  }

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
  my $suff = $this->_debug ? 'h' : '';

  $lib = 'wxxrc' if $lib eq 'xrc';
  $lib =~ s/^\s*(.*?)\s*/$1/;

  return ' ' . catfile( $this->wx_config( 'wxdir' ),
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
