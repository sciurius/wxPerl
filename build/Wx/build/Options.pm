package Wx::build::Options;

use strict;

=head1 NAME

Wx::build::Options - retrieve wxWidgets/wxPerl build options

=head1 METHODS

=head2 get_options

  my %options = Wx::build::Options->get_options( $from );

Valid values for I<$from> are C<'command_line'> and C<'saved'>.

  %options = ( unicode => 0,
               static  => 0,
               debug   => 0,
              );

=cut

use Getopt::Long;
Getopt::Long::Configure( 'pass_through' );

my $debug        = 0;
my $unicode      = 0;
my $help         = 0;
my $static       = 0;
my $mksymlinks   = 0;
my $extra_libs   = '';
my $extra_cflags = '';
my %subdirs      = ();

my $options;

sub _load_options {
  return if $options;

  $options = do 'Wx/build/Opt.pm';
  die "Unable to load options: $@" unless $options;

  ( $debug, $unicode, $static, $extra_cflags, $extra_libs )
    = @{$options}{qw(debug unicode static extra_cflags extra_libs)};
}

sub get_options {
  my $ref = shift;
  my $from = shift;

  if( $from eq 'saved' ) {
    _load_options();
  } else {
    _parse_options();
  }

  return ( unicode => $unicode,
           static  => $static,
           debug   => $debug,
         );
}

my $parsed = 0;
my @argv;

sub _parse_options {
  return if $parsed;

  $parsed = 1;

  my $result = GetOptions( 'debug'          => \$debug,
                           'unicode'        => \$unicode,
                           'help'           => \$help,
                           'static'         => \$static,
                           'mksymlinks'     => \$mksymlinks,
                           'extra-libs=s'   => \$extra_libs,
                           'extra-cflags=s' => \$extra_cflags,
                           '<>'             => \&_process_options,
                         );

  @ARGV = @argv; @argv = ();

  if( !$result || $help ) {
    print <<HELP;
Usage: perl Makefile.PL [options]
  --enable/disable-foo where foo is one of: dnd filesys grid help
                       html mdi print xrc stc docview calendar datetime 
  --help               you are reading it
  --debug              enable debugging
  --unicode            enable Unicode support (MSW/GTK2 only)
  --static             link all extensions in a single big shared object
  --mksymlinks         create a symlink tree
  --extra-libs=libs    specify extra linking flags
  --extra-cflags=flags specify extra compilation flags
HELP

    exit !$result;
  }
}

sub _process_options {
  my $i = shift;

  unless( $i =~ m/^-/ ) {
    push @argv, $i;
    return;
  }

  if( $i =~ m/^--(enable|disable)-(\w+)$/ ) {
    $subdirs{$2} = ( $1 eq 'enable' ? 1 : 0 );
  } else {
    die "invalid option $i";
  }
}

=head2 get_makemaker_options

  my %mm_options = Wx::build::Options->get_makemaker_options;

Returns options meaningful at wxPerl building time.

  my %options = ( mksymlinks   => 0,
                  extra_libs   => '',
                  extra_cflags => '',
                  subdirs      => { stc => 1,
                                    xrc => 0 } )

=cut

sub get_makemaker_options {
  my $ref = shift;
  my $from = shift || '';

  if( $from eq 'saved' ) {
    _load_options();
  } else {
    _parse_options();
  }

  return ( mksymlinks   => $mksymlinks,
           extra_libs   => $extra_libs,
           extra_cflags => $extra_cflags,
           subdirs      => \%subdirs );
}

=head2 write_config_file

  my $ok = Wx::build::Options->write_config_file( '/path/to/file' );

Writes a machine-readable representation of command-line options given to
top-level Makefile.PL

=cut

sub write_config_file {
  my $class = shift;
  my $file = shift;

  require Data::Dumper;
  my $str = Data::Dumper->Dump( [ { debug        => $debug,
                                    unicode      => $unicode,
                                    static       => $static,
                                    extra_libs   => $extra_libs,
                                    extra_cflags => $extra_cflags
                                  } ] );

  Wx::build::Utils::write_string( $file, $str );
}

1;

# local variables:
# mode: cperl
# end:
