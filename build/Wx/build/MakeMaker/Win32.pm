package Wx::build::MakeMaker::Win32;

use strict;
use base 'Wx::build::MakeMaker::Any_OS';
use Wx::build::Utils;
use File::Basename ();

my $wx_setup_dir = undef;

sub configure_core {
  my $this = shift;
  my %config = $this->SUPER::configure_core( @_ );

  my $res = $this->_res_file;
  $config{depend}      = { $res => 'Wx.rc ' };
  $config{LDFROM}     .= "\$(OBJECT) $res ";
  $config{dynamic_lib} = { INST_DYNAMIC_DEP => $res,
                           OTHERLDFLAGS     => ' ' };

  die "Unable to find setup.h directory"
    unless $config{INC} =~ m{[/-]I(\S+lib[\\/]\w+)\b};
  $wx_setup_dir = $1;

  return %config;
}

sub configure_ext {
  my $this = shift;
  my $is_tree = Wx::build::MakeMaker::is_wxPerl_tree();
  my %config = $this->SUPER::configure_ext( @_ );
  return %config if $is_tree;
  my $cfg =
    Wx::build::Config->new( Wx::build::Options->get_options( $is_tree ?
                                                             'command_line' :
                                                             'saved' ),
                            core => 0,
                            get_saved_options => !$is_tree );

  # installed import library
  my $impbase =
    File::Basename::basename( $cfg->wx_config( 'implib' ) );
  my $rimp = File::Spec->catfile( $this->_arch_directory,
                                  'Wx', 'build', $impbase );
  my $libs = '';
  foreach ( split /\s+/, $config{LIBS} ) {
    m{\Q$impbase\E$} and $_ = $rimp;
    $libs .= "$_ ";
  }
  $config{LIBS} = $libs;

  # installed setup.h
  $config{INC} = '-I' . File::Spec->catdir( $this->_arch_directory, 'build' )
    . ' ' . $config{INC};

  return %config;
}

sub postamble_core {
  my $this = shift;
  my $wxdir = $this->wx_config->wx_config( 'wxdir' );
  my $text = $this->SUPER::postamble_core( @_ );
  my $command = $this->_res_command;
  my $res_file = $this->_res_file;

  $command =~ s/%incdir/$wxdir\\include/;
  $command =~ s/%src/Wx.rc/;
  $command =~ s/%dest/$res_file/;

  $text .= <<EOT;

$res_file : Wx.rc
\t$command

# for compatibility
ppmdist : ppm

EOT

# ppm : pure_all ppd
# \t\$(CP) ${implib} blib\\arch\\auto\\Wx
# \tstrip blib\\arch\\auto\\Wx\\*.dll
# \t\$(TAR) \$(TARFLAGS) \$(DISTVNAME)-ppm.tar blib
# \tgzip --force --best \$(DISTVNAME)-ppm.tar

}

sub files_to_install {
  my $this = shift;
  my %files = $this->SUPER::files_to_install();
  my $dll_full = $this->_dll_name;
  my $implib = $this->wx_config->wx_config( 'implib' );
  my $impbase = File::Basename::basename( $implib );
  my $base = File::Basename::basename( $dll_full );
  my $setup_h = File::Spec->catfile( $wx_setup_dir, 'wx', 'setup.h' );

  return ( %files,
           $dll_full => Wx::build::Utils::arch_auto_file( "Wx/$base" ),
           $implib   => Wx::build::Utils::arch_file( "Wx/build/$impbase" ),
           $setup_h  => Wx::build::Utils::arch_file( "Wx/build/wx/setup.h" ),
         );
}

1;

# local variables:
# mode: cperl
# end:
