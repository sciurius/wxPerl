package Wx::build::Config;

use strict;
use Config;
use Wx::build::Utils;

my $is_wxPerl_tree = 0;
sub _set_is_wxPerl_tree { $is_wxPerl_tree = shift; }
sub is_wxPerl_tree { $is_wxPerl_tree }

=head1 NAME

Wx::build::Config - configuration information about wxWindows/wxPerl

=head1 METHODS

=head2 new

  my $cfg = Wx::build::Config->new( unicode           => 0,
                                    debug             => 0,
                                    get_saved_options => 1,
                                    core              => 0,
                                    static            => 0,
                                   );

=cut

sub get_package;

sub new {
  my $ref = shift;

  if( $ref eq 'Wx::build::Config' ) {
    my $pack = get_package;
    my $full = "Wx::build::Config::$pack";
    ( my $file = $full ) =~ s{::}{/}g;
    require "$file.pm";
    return $full->new( @_ );
  } else {
    my $this = bless {}, $ref;
    my %args = @_;

    $args{get_saved_options} = 1 unless exists $args{get_saved_options};

    if( $args{get_saved_options} ) {
      my %options = Wx::build::Options->get_options( 'saved' );
      $this->{CORE} = 0;
      @{$this}{qw(DEBUG STATIC UNICODE)} = @options{qw(debug static unicode)};
    } else {
      $this->{UNICODE} = $args{unicode} || 0;
      $this->{DEBUG}   = $args{debug} || 0;
      $this->{CORE}    = $args{core} || 0;
      $this->{STATIC}  = $args{static} || 0;
    }

    return $this;
  }
}

sub _unicode { $_[0]->{UNICODE} }
sub _debug   { $_[0]->{DEBUG} }
sub _core    { $_[0]->{CORE} }
sub _static  { $_[0]->{STATIC} }

=head2 wx_config

  my $string = $cfg->wx_config( 'cxx' );

=head2 get_api_directory

  my $dir = $cfg->get_api_directory;

=head2 get_arch_directory

  my $dir = $cfg->get_arch_directory;

=cut

sub get_api_directory {
  if( Wx::build::Config::is_wxPerl_tree() ) {
    return Wx::build::Utils::_top_dir();
  } else {
    my $path = $INC{'Wx/build/Config.pm'};
    my( $vol, $dir, $file ) = File::Spec->splitpath( $path );
    my @dirs = File::Spec->splitdir( $dir ); pop @dirs; pop @dirs;
    return File::Spec->catpath( $vol, File::Spec->catdir( @dirs ) );
  }
}

sub get_arch_directory {
  if( Wx::build::Config::is_wxPerl_tree() ) {
    require Carp;
    Carp::confess( "Should not be called!" );
  } else {
    my $path = $INC{'Wx/build/Opt.pm'};
    my( $vol, $dir, $file ) = File::Spec->splitpath( $path );
    my @dirs = File::Spec->splitdir( $dir ); pop @dirs; pop @dirs; pop @dirs;
    return File::Spec->catpath( $vol, File::Spec->catdir( @dirs ) );
  }
}

=head2 get_flags

  my %flags = $cfg->get_flags;

=head2 get_contrib_lib

  my $lib_string = $cfg->get_contrib_lib( 'stc' );

B<DEPRECATED as of wxPerl 0.16>.

=head2 get_core_lib

  my $lib_string = $cfg->get_core_lib( 'stc', 'core', 'base' );

=head2 get_wx_version

  my $version = $cfg->get_wx_version();

=cut

sub get_wx_version {
  my $this = shift;
  my $ver = $this->wx_config( 'version' );

  $ver =~ m/(\d+)\.(\d+)\.(\d+)/ &&
    return $1 + $2 / 1000 + $3 / 1000000;
  $ver =~ m/(\d)(\d+)_(\d+)/ &&
    return $1 + $2 / 1000 + $3 / 1000000;
  $ver =~ m/(\d)(\d)(\d+)/ &&
    return $1 + $2 / 1000 + $3 / 1000000;
  $ver =~ m/(\d)(\d)/ &&
    return $1 + $2 / 1000;

  die "unable to get wxWindows' version ($ver)";
}

=head2 get_wx_platform

  my $platform = $cfg->get_wx_platform();

=head2 package_name

  my $package = Wx::build::Config->get_package;

=cut

# configures subroutines depending
# from os/window system
my $package_to_use;

BEGIN {
 SWITCH: {
    local $_ = $Config{osname};

    # Win32
    m/MSWin32/ and do {
      local $_ = $Config{cc};

      m/^cl/i  and $package_to_use = 'Win32_MSVC'  and last SWITCH;
      m/^gcc/i and $package_to_use = 'Win32_MinGW' and last SWITCH;

      # default
      die "Your compiler is not currently supported on Win32"
    };

    # MacOS X is slightly different...
    m/darwin/ and do {
      $package_to_use = 'MacOSX_GCC';
      last SWITCH;
    };

    # default
    $package_to_use = 'Any_wx_config';
    last SWITCH;
  }
}

sub get_package {
  my $pack = shift;

  return $package_to_use;
}

=head2 merge_config

  my %config = Wx::build::Config->merge_config( \%makemaker_cfg, \%wx_cfg );

Merges the configuration options given as arguments, trying to
DTRT.

=cut

use vars qw(%cfg1 %cfg2);

sub _libs($) { ref( $_[0] ) ? @{$_[0]} : ( $_[0] ) }

# removes the -L/path from the imput and returns them and
# the cleaned input
sub _split_lib($) {
  my $str = shift || '';
  my @paths = $str =~ m/(-L[^ ]+)/g;
  $str =~ s/-L[^ ]+ +//g;

  return ( $str, @paths );
}

sub merge_config {
  my $class = shift;
  my( $cfg1, $cfg2 ) = @_;
  local *cfg1 = $cfg1;
  local *cfg2 = $cfg2;
  my %cfg = %cfg1;

  foreach my $i ( keys %cfg2 ) {
    if( exists $cfg{$i} ) {
      # merging libraries is always a mess; the hope is that
      # this will work in all cases, but there are no guarantees...
      if( $i eq 'LIBS' ) {
        my @a = _libs(  $cfg{LIBS} );
        my @b = _libs( $cfg2{LIBS} );

        my @c;
        foreach my $i ( @b ) {
          my( $mi, @ipaths ) = _split_lib( $i );
          foreach my $j ( @a ) {
            my( $mj, @jpaths ) = _split_lib( $j );
            push @c, " @ipaths @jpaths $mj $mi ";
          }
        }

        $cfg{LIBS} = \@c;
        next;
      }

      if( $i eq 'clean' || $i eq 'realclean' ) {
        $cfg{$i}{FILES} .= ' ' . $cfg{$i}{FILES};
        next;
      }

      if( ref($cfg{$i}) || ref($cfg2{$i}) ) {
        die "non scalar key '$i' while merging configuration information";
        $cfg{$i} = $cfg2{$i};
      } else {
        $cfg{$i} .= " $cfg2{$i}";
      }
    } else {
      $cfg{$i} = $cfg2{$i};
    }
  }

  return %cfg;
}

1;

# local variables:
# mode: cperl
# end:
