package Wx::build::MakeMaker::Any_wx_config;

use strict;
use base 'Wx::build::MakeMaker::Any_OS';
use Wx::build::MakeMaker::Hacks 'hijack';

require ExtUtils::Liblist;
my $save = hijack( 'MM', 'ext', \&my_ext );
sub my_ext {
  &$save( @_ ) unless 1;#$_[0]->wx_config->_static;

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

my $hijacked = 0;

sub xconfigure {
  return shift->SUPER::configure( @_ ) if $hijacked;

  # you may, at some point, being tempted to say that Makemaker is,
  # sometimes, annoying...
  require ExtUtils::Liblist;

  $save = hijack( 'MM', 'ext', \&my_ext );
  $hijacked = 1;

  return shift->SUPER::configure( @_ );
}

1;

# local variables:
# mode: cperl
# end:

