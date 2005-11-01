package Wx::build::Config::MacOSX_GCC;

use strict;
use base 'Wx::build::Config::Any_wx_config';

#
# wx-config- like
#
sub wx_config {
  my $this = shift;
  my $result = $this->SUPER::wx_config( @_ );

  # MakeMaker does not like the "-framework foo" options
  $result =~ s{-framework\s+\w+|-L/usr/local/lib}{}g
    if grep { $_ eq 'libs' } @_;

  $result = 'c++' if $_[0] eq 'ld';

  return $result;
}

sub get_flags {
  my $this = shift;
  my %config = $this->SUPER::get_flags;

  $config{DEFINE} .= "-UWX_PRECOMP ";

  return %config;
}

1;

# local variables:
# mode: cperl
# end:
