package Wx::build::Config::Any_wx_config;

use strict;
use base 'Wx::build::Config::Any_OS';

sub wx_config {
  my $this = shift;
  my $options = join ' ', map { "--$_" } @_;

  # not completely correct, but close
  $options = "--static $options" if $this->_static;

  my $t = qx(wx-config $options);
  chomp $t;

  return $t;
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

  if( $this->get_wx_version >= 2.003003 ) {
    my $plat = $this->get_wx_platform;
    ( my $ver = $this->wx_config( 'version' ) ) =~ s/\.\d+$//;
    my $debug = $this->_is_wx_debug ? 'd' : '';
    $lib =~ s/^\s*wx(.*?)\s*/$1/;

    return " -lwx_${plat}${debug}_${lib}-${ver} ";
  } else {
    return " -l$lib ";
  }
}

sub get_flags {
  my $this = shift;
  my %config = $this->SUPER::get_flags;

  $config{CC} = $this->wx_config( 'cxx' );
  if( $this->_debug ) {
    $config{CCFLAGS} .= ' -g ';
    $config{OPTIMIZE} = ' ';
  }

  $config{LD} = $this->wx_config( 'ld' );
  $config{LD} =~ s/\-o\s*$/ /; # wxWindows puts 'ld -o' into LD

  my $cccflags = $this->wx_config( 'cxxflags' );
  my $libs = $this->wx_config( 'libs' );

  foreach ( split /\s+/, $cccflags ) {
    m(^[-/]I) && do { $config{INC} .= "$_ "; next; };
    m(^[-/]D) && do { $config{DEFINE} .= "$_ "; next; };
    $config{CCFLAGS} .= $_ . ' ';
  }

  $config{LIBS} .= " $libs ";

  return %config;
}

1;

# local variables:
# mode: cperl
# end:
