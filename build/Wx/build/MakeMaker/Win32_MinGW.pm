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

#
# MinGW might require mingwm10.dll; since it's just 14k,
# don't bother and just copy it
#
sub files_to_install {
  my $this = shift;
  my %files = $this->SUPER::files_to_install();

  my $dll_from;

  foreach my $dir ( File::Spec->path ) {
    my( @files ) = glob( File::Spec->catfile( $dir, 'mingwm*.dll' ) );
    if( @files ) {
      $dll_from = $files[0];
      last;
    }
  }

  return %files unless defined $dll_from;

  my $base = File::Basename::basename( $dll_from );
  my $dll_to = Wx::build::Utils::arch_auto_file( "Wx/$base" );

  return ( %files,
           $dll_from => $dll_to );
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
