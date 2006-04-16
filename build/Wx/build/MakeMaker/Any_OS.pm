package Wx::build::MakeMaker::Any_OS;

use strict;
use base 'Wx::build::MakeMaker';
use File::Spec::Functions qw(curdir);
use Wx::build::Options;
use Wx::build::Utils qw(xs_dependencies lib_file
                        files_with_overload files_with_constants);

my $exp = lib_file( 'Wx/Wx_Exp.pm' );
my $ovl = lib_file( 'Wx/_Ovl.pm' );
my $ovlc = File::Spec->catfile( qw(cpp ovl_const.cpp) );
my $ovlh = File::Spec->catfile( qw(cpp ovl_const.h) );

sub get_flags {
  my $this = shift;
  my %config;

  $config{INC} .= '-I' . curdir . ' ';
  $config{INC} .= '-I' . $this->get_api_directory . ' ';

  unless( $this->_core ) {
    $config{DEFINE} .= " -DWXPL_EXT ";
  }

  if( $this->_static ) {
    $config{DEFINE} .= " -DWXPL_STATIC ";
  }

  return %config;
}

sub configure_core {
  my $this = shift;
  my %config = $this->get_flags;

  $config{clean} =
    { FILES => "$ovlc $ovlh .exists overload Opt copy_files files.lst" .
               " cpp/setup.h cpp/plwindow.h cpp/artprov.h cpp/popupwin.h" .
               " fix_alien" };

  return %config;
}

sub configure_ext { return $_[0]->get_flags }

sub _depend_common {
  my $this = shift;

  return xs_dependencies( $this, [ curdir, $this->get_api_directory
                                 ] );
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
                 '$(INST_STATIC)'  => "fix_alien $exp",
                 '$(INST_DYNAMIC)' => "fix_alien $exp",
                 'fix_alien'       => 'pm_to_blib',
                 'pm_to_blib'      => 'copy_files',
                 'blibdirs'        => 'copy_files',
                 'blibdirs.ts'     => 'copy_files',
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

sub subdirs_core {
  my $this = shift;
  my $text = $this->SUPER::subdirs_core( @_ );

  return <<EOT . $text;
subdirs :: overload

EOT
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

fix_alien : lib/Wx/Mini.pm
\t\$(PERL) script/fix_alien_path.pl lib/Wx/Mini.pm blib/lib/Wx/Mini.pm
\t\$(TOUCH) fix_alien

parser :
	yapp -v -s -o script/XSP.pm script/XSP.yp

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

1;

# local variables:
# mode: cperl
# end:
