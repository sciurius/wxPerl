package Wx::build::Config::Any_OS;

use strict;
use base 'Wx::build::Config';
use File::Spec::Functions qw(curdir);

sub get_flags {
  my $this = shift;
  my %config;

  $config{INC} .= '-I' . curdir . ' ';
  $config{INC} .= '-I' . $this->get_api_directory . ' ';

  unless( $this->_core ) {
    $config{DEFINE} .= " -DWXPL_EXT ";
  }

  if( $this->_static ) {
    $config{DEFINE} .= " -DWXPL_STATIC ";
  }

  return %config;
}

sub wx_config_25 {
  my $this = shift;
  my $data = $this->_data;

  foreach ( @_ ) { warn $_ unless defined $data->{$_} }

  return @{$data}{@_};
}

1;

# local variables:
# mode: cperl
# end:
