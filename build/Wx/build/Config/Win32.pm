package Wx::build::Config::Win32;

use strict;
use base 'Wx::build::Config::Any_OS';

# check for WXDIR and WXWIN environment variables
unless( exists $ENV{WXDIR} and exists $ENV{WXWIN} ) {
  warn <<EOT;

**********************************************************************
WARNING!

You need to set the WXDIR and WXWIN variables; refer to
docs/install.txt for a detailed explanation
**********************************************************************

EOT
  exit 1;
}

sub get_wx_platform { 'msw' }

sub get_flags {
  my $this = shift;
  die "static build not supported under Win32"
    if $this->_static;

  return $this->SUPER::get_flags( @_ );
}

1;

# local variables:
# mode: cperl
# end:
