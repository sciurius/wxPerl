package Wx::build::MakeMaker::MacOSX_GCC;

use strict;
use base 'Wx::build::MakeMaker::Any_wx_config';

sub configure_core {
  my $this = shift;
  my %config = $this->SUPER::configure_core( @_ );

  $config{depend}{'$(INST_STATIC)'} .= ' $(INST_BIN)/wxPerl';
  $config{depend}{'$(INST_DYNAMIC)'} .= ' $(INST_BIN)/wxPerl';

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

  $text .= sprintf <<'EOT', ;

$(INST_BIN)/wxPerl :
	mkdir -p $(INST_BIN)
	cp $(PERL) $(INST_BIN)/wxPerl
	`wx-config --rezflags` $(INST_BIN)/wxPerl

install_wxperl :
	ditto -rsrcFork $(INST_BIN)/wxPerl $(INSTALLBIN)

EOT

  return $text;
}

1;

# local variables:
# mode: cperl
# end:
