package Wx::build::MakeMaker::Any_wx_config;

use strict;
use base 'Wx::build::MakeMaker::Any_OS';
use Wx::build::MakeMaker::Hacks 'hijack';

require ExtUtils::Liblist;
my $save = hijack( 'MM', 'ext', \&my_ext );
sub my_ext {
  my $this = shift;
  my $libs = shift;
  my $full; if( $libs =~ m{(?:\s+|^)(/\S+)} )
    { $full = $1; $libs =~ s{(?:\s+|^)/\S+}{}g }
  my @libs = &{$save}( $this, $libs, @_ );
  if( defined $full ) {
    $libs[0] = "$libs[0] $full $libs[0]" if $libs[0];
    $libs[2] = "$libs[2] $full $libs[2]" if $libs[2];
  }

  return @libs;
}

1;

# local variables:
# mode: cperl
# end:

