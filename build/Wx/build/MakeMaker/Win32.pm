package Wx::build::MakeMaker::Win32;

use strict;
use base 'Wx::build::MakeMaker::Any_OS';
use Wx::build::Utils;
use File::Basename ();

# only used for core (to copy the file)
my $wx_setup_dir = undef;

sub configure_core {
  my $this = shift;
  my %config = $this->SUPER::configure_core( @_ );

  my $res = $this->_res_file;
  $config{depend}      = { $res => 'Wx.rc ' };
  $config{LDFROM}     .= "\$(OBJECT) $res ";
  $config{dynamic_lib}{INST_DYNAMIC_DEP} .= " $res";

  die "Unable to find setup.h directory"
    unless $config{INC} =~ m{[/-]I(\S+lib[\\/][\w\\/]+)(?:\s|$)};
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

  # installed setup.h
  $config{INC} = '-I' . File::Spec->catdir( $cfg->get_arch_directory,
                                            'Wx', 'build' )
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
  my $strip = $this->_strip_command;

  $text .= sprintf <<'EOT', $res_file, $command, $strip;

%s : Wx.rc
	%s

# for compatibility
ppmdist : ppm

ppm : pure_all
%s
	perl script/make_ppm.pl

EOT
}

sub files_to_install {
  my $this = shift;
  my %files = $this->SUPER::files_to_install();
  my $dlls = $this->wx_config->wx_config( 'dlls' );
  my $setup_h = File::Spec->catfile( $wx_setup_dir, 'wx', 'setup.h' );

  $files{$setup_h} = Wx::build::Utils::arch_file( "Wx/build/wx/setup.h" );
  foreach my $dll ( map { $_->{dll} } values %$dlls ) {
    my $base = File::Basename::basename( $dll );
    $files{$dll} = Wx::build::Utils::arch_auto_file( "Wx/$base" );
  }
  foreach my $lib ( map { $_->{lib} } values %$dlls ) {
    next unless defined $lib;
    my $base = File::Basename::basename( $lib );
    $files{$lib} = Wx::build::Utils::arch_auto_file( "Wx/$base" );
  }

  return %files;
}

1;

# local variables:
# mode: cperl
# end:
