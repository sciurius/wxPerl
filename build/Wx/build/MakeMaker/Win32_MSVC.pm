package Wx::build::MakeMaker::Win32_MSVC;

use strict;
use base 'Wx::build::MakeMaker::Win32';

sub _res_file { 'Wx.res' }
sub _res_command { 'rc -I%incdir %src' }
sub _strip_command { '$(NOOP)' }

sub _dll_name {
  my $this = shift;
  my $implib = $this->wx_config->wx_config( 'implib' );
  $implib =~ s/\.lib$/.dll/;

  return $implib;
}

1;

# local variables:
# mode: cperl
# end:
