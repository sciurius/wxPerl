package Wx::build::Config::Any_wx_config;

use strict;
use base 'Wx::build::Config::Any_OS';

{
  my $ver = `wx-config --version`;
  $ver =~ m/^(\d)\.(\d)/;
  $ver = $1 + $2 / 1000;

  if( $ver >= 2.005 ) {
    *wx_config = __PACKAGE__->can( 'wx_config_25' );
    *get_core_lib = __PACKAGE__->can( 'get_core_lib_25' );
  } else {
    *wx_config = __PACKAGE__->can( 'wx_config_24' );
    *get_core_lib = __PACKAGE__->can( 'get_core_lib_24' );
  }
}

# used by Any_OS::wx_config_25
sub _data {
  my $this = shift;
  return $this->{data} if $this->{data};

  my %data;

  foreach my $item ( qw(cxx ld cxxflags ldflags version libs) ) {
    $data{$item} = $this->_call_wx_config( $item );
  }

  $data{libs} =~ s/\-lwx\S+//g;

  $this->{data} = \%data;
}

sub _call_wx_config {
  my $this = shift;
  my $options = join ' ', map { "--$_" } @_;
  my $wx_config = $ENV{WX_CONFIG} || 'wx-config';

  # not completely correct, but close
  $options = "--static $options" if $this->_static;

  my $t = qx($wx_config $options);
  chomp $t;

  return $t;
}

sub wx_config_24 {
  my $this = shift;
  return $this->_call_wx_config( @_ );
}

sub get_core_lib_25 {
  my( $this, @libs ) = @_;
  my $arg = 'libs=' . join ',', grep { !m/base/ } @libs;
  my $ret = $this->_call_wx_config( $arg );
  return ' ' . join ' ',
               grep { m/\-lwx/ }
               split ' ', $ret;
}

sub get_core_lib_24 {
  my( $this, @libs ) = @_;

  return ' ' . join ' ',
    map {
        m/^(?:xrc|stc)$/     ? $this->get_contrib_lib( $_ ) :
        m/^gl$/              ? $this->_call_wx_config( 'gl-libs' ) :
                               die "No such lib: '$_'";
    }
    grep { !m/^(?:adv|base|html|net|xml|core)$/ } @libs;
}

sub get_wx_platform {
  my $this = shift;
  my $cf = $this->wx_config( 'cxxflags' );
  $cf =~ m/__WX(x11|msw|motif|gtk|mac)__/i && return lc $1;

  die "Unable to determine toolkit!";
}

sub _is_wx_debug {
  my $this = shift;
  my $cf = $this->wx_config( 'cxxflags' );
  return scalar( $cf =~ m/__WXDEBUG__/i );
}

sub get_contrib_lib {
  my( $this, $lib ) = @_;

  ( my $ver = $this->wx_config( 'version' ) ) =~ s/\.\d+$//;
  my $base = $this->wx_config( 'basename' );
  $lib =~ s/^\s*wx(.*?)\s*/$1/;

  return " -l${base}_${lib}-${ver} ";
}

sub get_flags {
  my $this = shift;
  my %config = $this->SUPER::get_flags;

  $config{CC} = $ENV{CXX} || $this->wx_config( 'cxx' );
  if( $this->_debug ) {
    $config{CCFLAGS} .= ' -g ';
    $config{OPTIMIZE} = ' ';
  }

  $config{LD} = $this->wx_config( 'ld' );
  $config{LD} =~ s/\-o\s*$/ /; # wxWidgets puts 'ld -o' into LD

  my $cccflags = $this->wx_config( 'cxxflags' );
  my $libs = $this->wx_config( 'libs' );

  foreach ( split /\s+/, $cccflags ) {
    m(^[-/]I) && do { $config{INC} .= "$_ "; next; };
    m(^[-/]D) && do { $config{DEFINE} .= "$_ "; next; };
    $config{CCFLAGS} .= $_ . ' ';
  }

  foreach ( split /\s+/, $libs ) {
    m{^-[lL]|/} && do { $config{LIBS} .= " $_"; next; };
    if( $_ eq '-pthread' && $^O =~ m/linux/i ) {
      $config{LIBS} .= " -lpthread"
    }
    $config{dynamic_lib}{OTHERLDFLAGS} .= " $_";
  }

  return %config;
}

1;

# local variables:
# mode: cperl
# end:
