package Wx::build::MakeMaker::Win32_MinGW;

use strict;
use base 'Wx::build::MakeMaker::Win32';

sub _res_file { 'Wx_res.o' }
sub _res_command { 'windres --include-dir %incdir %src %dest' }
sub _strip_command {
  return <<EOT;
	attrib -r blib\\arch\\auto\\Wx\\*.dll
	strip blib/arch/auto/Wx/*.dll
	attrib +r blib\\arch\\auto\\Wx\\*.dll
EOT
}

sub _dll_name {
  my $this = shift;
  my $implib = $this->wx_config->wx_config( 'implib' );
  $implib =~ s/lib(\w+)\.a$/$1.dll/;

  return $implib;
}

#
# current command line breaks in dmake ( used braces in qq{} )
#
sub ppd {
  my $this = shift;
  my $text = $this->SUPER::ppd( @_ );

  $text =~ tr/\{\}/##/;

  return $text;
}

#
# fixes link command line to use g++ instead of dlltool
#
sub dynamic_lib {
  my $this = shift;
  my $text = $this->SUPER::dynamic_lib( @_ );

  return $text unless $text =~ m/dlltool/i;

  my $strip = $this->wx_config->_debug ? '' : ' -s ';

  $text =~ s{(?:^\s+(?:dlltool|\$\(LD\)).*\n)+}
    {\tg++ -shared $strip -o \$@ \$(LDFROM) \$(MYEXTLIB) \$(PERL_ARCHIVE) \$(LDLOADLIBS)\n}m;
  # \$(LDDLFLAGS) : in MinGW passes -mdll, and we use -shared...

  return $text;
}

1;

# local variables:
# mode: cperl
# end:
