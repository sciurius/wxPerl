package Wx::build::MakeMaker::Any_OS;

use strict;
use base 'Wx::build::MakeMaker';
use File::Spec::Functions qw(curdir);
use Wx::build::Options;
use Wx::build::Utils qw(xs_dependencies lib_file);
use File::Find qw(find);

my $exp = lib_file( 'Wx/_Exp.pm' );
my $ovl = lib_file( 'Wx/_Ovl.pm' );
my $ovlc = File::Spec->catfile( qw(cpp ovl_const.cpp) );
my $ovlh = File::Spec->catfile( qw(cpp ovl_const.h) );

sub configure_core {
  my $this = shift;
  my $cfg =
    Wx::build::Config->new( Wx::build::Options->get_options( 'command_line' ),
                            core => 1,
                            get_saved_options => 0 );
  my %config = $cfg->get_flags;

  $config{clean} =
    { FILES => "$ovlc $ovlh .exists overload Opt copy_files files.lst" };

  return %config;
}

sub configure_ext {
  my $this = shift;
  my $is_tree = Wx::build::MakeMaker::is_wxPerl_tree();
  my $cfg =
    Wx::build::Config->new( Wx::build::Options->get_options( $is_tree ?
                                                             'command_line' :
                                                             'saved' ),
                            core => 0,
                            get_saved_options => !$is_tree );
  my %config = $cfg->get_flags;

  $config{INC} .= '-I' . $this->_api_directory;

  return %config;
}

sub _api_directory {
  if( Wx::build::MakeMaker::is_wxPerl_tree() ) {
    return Wx::build::Utils::_top_dir();
  } else {
    my $path = $INC{'Wx/build/MakeMaker.pm'};
    my( $vol, $dir, $file ) = File::Spec->splitpath( $path );
    my @dirs = File::Spec->splitdir( $dir ); pop @dirs; pop @dirs;
    return File::Spec->catpath( $vol, File::Spec->catdir( @dirs ) );
  }
}

sub _arch_directory {
  if( Wx::build::MakeMaker::is_wxPerl_tree() ) {
    die "Should not be called!";
  } else {
    my $path = $INC{'Wx/build/Opt.pm'};
    my( $vol, $dir, $file ) = File::Spec->splitpath( $path );
    my @dirs = File::Spec->splitdir( $dir ); pop @dirs; pop @dirs; pop @dirs;
    return File::Spec->catpath( $vol, File::Spec->catdir( @dirs ) );
  }
}

sub _depend_common {
  my $this = shift;

  return xs_dependencies( $this, [ curdir, $this->_api_directory ] );
}

my( @files_with_constants, @files_with_overload );

if( Wx::build::MakeMaker::is_core ) {
  @files_with_constants = files_with_constants();
  @files_with_overload  = files_with_overload();
}

sub depend_core {
  my $this = shift;

  my %files = $this->files_to_install();
  my %depend = ( _depend_common( $this ),
                 $exp              => join( ' ', @files_with_constants ),
                 $ovlc             => 'overload',
                 $ovlh             => $ovlc,
                 '$(INST_STATIC)'  => $exp,
                 '$(INST_DYNAMIC)' => $exp,
                 'pm_to_blib'      => 'copy_files',
                 'copy_files'      => join( ' ', keys %files ),
               );
  my %this_depend = @_;

  foreach ( keys %depend ) {
    $this_depend{$_} .= ' ' . $depend{$_};
  }

  $this->SUPER::depend_core( %this_depend );
}

sub depend_ext {
  my $this = shift;

  my %depend = _depend_common( $this );
  my %this_depend = @_;

  foreach ( keys %depend ) {
    $this_depend{$_} .= ' ' . $depend{$_};
  }

  $this->SUPER::depend_ext( %this_depend );
}

sub postamble_core {
  my $this = shift;
  my %files = $this->files_to_install();

  Wx::build::Utils::write_string( 'files.lst',
                                  Data::Dumper->Dump( [ \%files ] ) );
  my $text = <<EOT;

$exp :
\t\$(PERL) script/make_exp_list.pl $exp @files_with_constants

overload :
\t\$(PERL) script/make_ovl_list.pl foo_unused $ovlc $ovlh @files_with_overload
\t\$(TOUCH) overload

copy_files :
\t\$(PERL) script/copy_files.pl files.lst
\t\$(TOUCH) copy_files

EOT

  $text;
}

# here because File::Find::find chdirs, and our is_core is,
# er, quite limited
sub libscan_ext {
  my( $this, $inst ) = @_;

  $inst =~ s/(\W+)build\W+Wx/$1Wx/i && return $inst;

  return $this->SUPER::libscan_core( $inst );
}

sub constants_core {
  my $this = shift;

  foreach my $k ( grep { m/~$/ } keys %{$this->{PM}} ) {
    delete $this->{PM}{$k};
  }

  return $this->SUPER::constants_core( @_ );
}

# returns an hash of files to be copied
sub files_to_install {
  my @api = qw(cpp/chkconfig.h
               cpp/compat.h
               cpp/constants.h
               cpp/event.h
               cpp/e_cback.h
               cpp/helpers.h
               cpp/overload.h
               cpp/setup.h
               cpp/streams.h
               cpp/v_cback.h
               cpp/wxapi.h
               typemap
              );
  # in arch, so $INC{'Opt.pm'} will tell where arch is
  return ( 'Opt', Wx::build::Utils::arch_file( 'Wx/build/Opt.pm' ),
           ( map { ( $_ => Wx::build::Utils::lib_file( "Wx/$_" ) ) } @api ),
         );
}

##############################################################################
# Utility routines
##############################################################################

sub files_with_constants {
  my @files;

  my $wanted = sub {
    my $name = $File::Find::name;

    m/\.(?:pm|xs|cpp|h)$/i && do {
      local *IN;
      my $line;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/^\W+\!\w+:/ && do {
          push @files, $name;
          return;
        };
      };
    };
  };

  find( $wanted, curdir );

  return @files;
}

sub files_with_overload {
  my @files;

  my $wanted = sub {
    my $name = $File::Find::name;

    m/\.pm$/i && do {
      my $line;
      local *IN;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/Wx::_match/ && do {
          push @files, $name;
          return;
        };
      }
    };

    m/\.xs$/i && do {
      my $line;
      local *IN;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/wxPli_match_arguments|BEGIN_OVERLOAD\(\)/ && do {
          push @files, $name;
          return;
        };
      }
    };
  };

  find( $wanted, curdir );

  return @files;
}

1;

# local variables:
# mode: cperl
# end:
