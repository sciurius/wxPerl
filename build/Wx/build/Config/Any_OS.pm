package Wx::build::Config::Any_OS;

use strict;
use base 'Wx::build::Config';
use File::Spec::Functions qw(curdir);

sub get_flags {
  my $this = shift;
  my %config;

  $config{INC} .= '-I' . curdir . ' ';

  unless( $this->_core ) {
    $config{DEFINE} .= " -DWXPL_EXT ";
  }

  if( $this->_static ) {
    $config{DEFINE} .= " -DWXPL_STATIC ";
  }

  return %config;
}

1;

# local variables:
# mode: cperl
# end:
