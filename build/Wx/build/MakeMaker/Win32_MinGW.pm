package Wx::build::MakeMaker::Win32_MinGW;

use strict;
use Wx::build::Utils qw(path_search);
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

#
# MinGW might require mingwm10.dll; since it's just 14k,
# don't bother and just copy it
#
sub files_to_install {
  my $this = shift;
  my $dll = 'mingwm10.dll';
  my $dll_from = path_search( $dll );

  return ( $this->SUPER::files_to_install(),
           ( defined $dll_from ?
             ( $dll_from => Wx::build::Utils::arch_auto_file( "Wx/$dll" ) ) :
             () ) );
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
    {\tg++ -shared $strip -o \$@ \$(LDFROM) \$(MYEXTLIB) \$(PERL_ARCHIVE) \$(LDLOADLIBS) \$(BASEEXT).def\n}m;
  # \$(LDDLFLAGS) : in MinGW passes -mdll, and we use -shared...

  return $text;
}

1;

# local variables:
# mode: cperl
# end:
