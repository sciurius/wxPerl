package Wx::Mini; # for RPM

package Wx;

use strict;

our( $VERSION, $XS_VERSION );
our $alien_key = 'XXXALIENXXX';

{
    my $VAR1;
    $Wx::dlls = XXXDLLSXXX;
}

$VERSION = '0.96'; # bootstrap will catch wrong versions
$XS_VERSION = $VERSION;
$VERSION = eval $VERSION;

#
# XSLoader/DynaLoader wrapper
#
our( $wx_path );
our( $wx_binary_loader );

# see the comment in Wx.xs:_load_plugin for why this is necessary
sub wxPL_STATIC();
sub wx_boot($$) {
  local $ENV{PATH} = $wx_path . ';' . $ENV{PATH} if $wx_path;
  if( $_[0] eq 'Wx' || !wxPL_STATIC ) {
    no warnings 'redefine';
    if( $] < 5.006 ) {
      require DynaLoader;
      local *DynaLoader::dl_load_file = \&Wx::_load_plugin if $_[0] ne 'Wx';
      no strict 'refs';
      push @{"$_[0]::ISA"}, 'DynaLoader';
      $_[0]->bootstrap( $_[1] );
    } else {
      require XSLoader;
      local *DynaLoader::dl_load_file = \&Wx::_load_plugin if $_[0] ne 'Wx';
      XSLoader::load( $_[0], $_[1] );
    }
  } else {
    no strict 'refs';
    my $t = $_[0]; $t =~ tr/:/_/;
    &{"_boot_$t"}( $_[0], $_[1] );
  }
}

sub _alien_path {
  return if defined $wx_path;
  return unless length 'XXXALIENDXXX';
  foreach ( @INC ) {
    if( -d "$_/Alien/wxWidgets/XXXALIENDXXX" ) {
      $wx_path = "$_/Alien/wxWidgets/XXXALIENDXXX/lib";
      last;
    }
  }
}

_alien_path();

sub _init_binary_loader {
    return if $wx_binary_loader;
    # load the Loader
    # a custom loader may exist as Wx::Loader::Custom
    # or a packager may have installed a loader already
    eval{ require Wx::Loader::Custom };
    $wx_binary_loader = 'Wx::Loader::Standard' if !$wx_binary_loader;
}

sub _start {

    &_init_binary_loader;
    $wx_path = $wx_binary_loader->set_binary_path;
    wx_boot( 'Wx', $XS_VERSION ) if!$wx_binary_loader->boot_overload;
    _boot_Constant( 'Wx', $XS_VERSION );
    _boot_GDI( 'Wx', $XS_VERSION );

    Load();
}

# legacy load functions

sub set_load_function {
    &_init_binary_loader;
    $wx_binary_loader->external_set_load( $_[0] )
}

sub set_end_function  {
    &_init_binary_loader;
    $wx_binary_loader->external_set_unload( $_[0] )
}


# standard loader package - it gets
# used if nothing overrides it
# See Wx/Loader.pod

package Wx::Loader::Standard;
our @ISA = qw( Exporter );

sub loader_info { 'Standard Distribution'; }

sub set_binary_path { $Wx::wx_path }

sub boot_overload { }

# back compat overloading
# by default load_dll and unload_dll are no-ops (dependencies
# and the Wx lib are loaded via wx_boot above).
# But custom loaders may override this

# we need this to support deprecated
# set_load_function / set_end_function fo a while.
# As it is undocumented, should not need to maintain
# this for long.

# once support for set_load_function / set_end_function is
# removed, the rest of this package is
#
# sub load_dll {}
# sub unload_dll {}

my( $load_fun, $unload_fun ) = ( \&_load_dll, \&_unload_dll );

sub external_set_load { $load_fun = $_[1] }
sub external_set_unload { $unload_fun = $_[1] }

sub _load_dll {};
sub _unload_dll {};

sub load_dll {
  shift;
  goto &$load_fun;
}

sub unload_dll {
  shift;
  goto &$unload_fun;
}


1;
