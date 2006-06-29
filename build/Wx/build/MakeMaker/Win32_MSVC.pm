package Wx::build::MakeMaker::Win32_MSVC;

use strict;
use base 'Wx::build::MakeMaker::Win32';

sub _res_file { 'Wx.res' }
sub _res_command { 'rc -I%incdir %src' }
sub _strip_command {
return <<'EOT';
	$(NOOP)
EOT
}

my $cl_version;

{
    my @head = qx{$^X script\\pipe.pl cl /help};
    $head[0] =~ /Version (\d+\.\d+).0000/ and $cl_version = $1;
}

sub dynamic_lib {
  my $this = shift;
  my $text = $this->SUPER::dynamic_lib( @_ );

  return $text unless $cl_version >= 14;

  $text .= <<'EOT';
	mt -manifest $@.manifest -outputresource:$@;2
EOT

  return $text;
}

1;

# local variables:
# mode: cperl
# end:
