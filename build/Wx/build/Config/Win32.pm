package Wx::build::Config::Win32;

use strict;
use base 'Wx::build::Config::Any_OS';
use Config;
use File::Basename qw(dirname);
use File::Spec::Functions qw(catfile catdir);

# check for WXDIR and WXWIN environment variables
unless( exists $ENV{WXDIR} and exists $ENV{WXWIN} ) {
  warn <<EOT;

**********************************************************************
WARNING!

You need to set the WXDIR and WXWIN variables; refer to
docs/install.txt for a detailed explanation
**********************************************************************

EOT
  exit 1;
}

sub get_wx_platform { 'msw' }

sub get_flags {
  my $this = shift;
  die "static build not supported under Win32"
    if $this->_static;

  return $this->SUPER::get_flags( @_ );
}

sub _init {
  my( $pack, $file ) = @_;
  my $makefile = catfile( dirname( $INC{'Wx/build/Config.pm'} ), 'Config',
                          $file );

  die "Can't find makefile '$makefile'" unless -f $makefile;

  my $mak_env_in = catfile( $ENV{WXDIR}, 'src', 'make.env.in' );
  my $min_dir = catdir( $ENV{WXDIR}, 'samples', 'minimal' );

  *wx_config = -f $mak_env_in    ? $pack->can( 'wx_config_24' ) :
                                   $pack->can( 'wx_config_25' );
  *get_core_lib = -f $mak_env_in ? $pack->can( 'get_core_lib_24' ) :
                                   $pack->can( 'get_core_lib_25' );

  return ( $makefile, $min_dir );
}

sub _grep_dlls {
  my( $this, $libdir ) = @_;
  my $ret = {};

  my @dlls = glob( catfile( $libdir, '*.dll' ) );
  my @libs = grep { m/libwx(?:msw|base)[\w\.]+$/ }
             glob( catfile( $libdir, "*$Config{lib_ext}" ) );

  foreach my $full ( @dlls, @libs ) {
    my( $name, $type );
    local $_ = File::Basename::basename( $full );
    m/^[^_]+_([^_\.]+)/ and $name = $1;
    $name = 'base' if !defined $name || $name =~ m/^(gcc|vc)$/;
    $type = m/\.$Config{lib_ext}$/i ? 'lib' : 'dll';
    $ret->{$name}{$type} = $full;
  }

  return $ret;
}

1;

# local variables:
# mode: cperl
# end:
