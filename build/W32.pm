package W32;

use strict;
use Config;
use base 'Any_OS';

sub top_targets {
  my $this = shift;

  package MY;
  my $text = $this->SUPER::top_targets( @_ );

  $text =~ s{^(\w+\s*:+.*?)subdirs(.*?)linkext(.*?)$}
            {$1linkext$2subdirs$3}m;

  $text;
}

1;

# Local variables: #
# mode: cperl #
# End: #

