package Wx::build::MakeMaker::Win32_MSVC;

use strict;
use base 'Wx::build::MakeMaker::Win32';

use Wx::build::Utils qw(pipe_stderr);

sub _res_file { 'Wx.res' }
sub _res_command { 'rc -I%incdir %src' }
sub _strip_command {
return <<'EOT';
	$(NOOP)
EOT
}

my $cl_version;

{
    my @head = pipe_stderr( "cl /help" );
    $head[0] =~ /Version (\d+\.+).\d+/ and $cl_version = $1;
}

sub dynamic_lib {
  my $this = shift;
  my $text = $this->SUPER::dynamic_lib( @_ );

  return $text unless $cl_version >= 14;

  $text .= <<'EOT' if $text && $text =~ /\$\@/;
	mt -manifest $@.manifest -outputresource:$@;2
EOT

  return $text;
}

1;

# local variables:
# mode: cperl
# end:
