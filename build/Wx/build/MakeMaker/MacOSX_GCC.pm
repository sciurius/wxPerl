package Wx::build::MakeMaker::MacOSX_GCC;

use strict;
use base 'Wx::build::MakeMaker::Any_wx_config';

sub configure_core {
  my $this = shift;
  my %config = $this->SUPER::configure_core( @_ );

  $config{depend}{'$(INST_STATIC)'} .= ' wxPerl';
  $config{depend}{'$(INST_DYNAMIC)'} .= ' wxPerl';
  $config{clean}{FILES} .= " wxPerl";

  return %config;
}

sub install_core {
  my $this = shift;
  my $text = $this->SUPER::install_core( @_ );

  $text =~ m/^(install\s*:+)/m and
    $text .= "\n\n$1 install_wxperl\n\n";

  return $text;
}

sub postamble_core {
  my $this = shift;
  my $text = $this->SUPER::postamble_core( @_ );

  $text .= sprintf <<'EOT', $ENV{WX_CONFIG} || 'wx-config';

wxPerl :
#	mkdir -p $(INST_BIN)
	cp $(PERL) wxPerl
	`%s --rezflags` wxPerl

install_wxperl :
	mkdir -p $(DESTINSTALLBIN)
	ditto -rsrcFork wxPerl $(DESTINSTALLBIN)

EOT

  return $text;
}

1;

# local variables:
# mode: cperl
# end:
