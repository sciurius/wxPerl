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
  $result =~ s/-framework\s+\w+//g
    if grep { $_ eq 'libs' } @_;

  $result = 'c++' if $_[0] eq 'ld';

  return $result;
}

1;

# local variables:
# mode: cperl
# end:
