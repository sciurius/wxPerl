package Wx::build::MakeMaker::Any_OS;

use strict;
use base 'Wx::build::MakeMaker';
use File::Spec::Functions qw(curdir);
use Wx::build::Options;
use Wx::build::Utils qw(xs_dependencies lib_file);

my $exp = lib_file( 'Wx/Wx_Exp.pm' );

sub get_flags {
  my $this = shift;
  my %config;

  if( %Wx::build::MakeMaker::additional_arguments ) {
    $config{WX}{lc $_} = $Wx::build::MakeMaker::additional_arguments{$_}
      foreach keys %Wx::build::MakeMaker::additional_arguments;
    $ExtUtils::MakeMaker::Recognized_Att_Keys{WX} = 1;
    %Wx::build::MakeMaker::additional_arguments = ();
  }

  if( $config{WX}{wx_overload} ) {
      $_ = File::Spec->catfile( split /\//, $_ )
        foreach values %{$config{WX}{wx_overload}};
  }

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

sub metafile_target_ext {
    return '' if Wx::build::MakeMaker::is_wxPerl_tree;
    return shift->SUPER::metafile_target_ext( @_ );
}

sub metafile_target_core {
    return shift->MM::metafile_target( @_ );
}

sub configure_core {
  my $this = shift;
  my %config = $this->get_flags;

  $config{clean} =
    { FILES => "$config{WX}{wx_overload}{source}" .
               " $config{WX}{wx_overload}{header} exists overload Opt" .
               " copy_files files.lst" .
               " cpp/setup.h cpp/plwindow.h cpp/artprov.h cpp/popupwin.h" .
               " fix_alien cpp/vlbox.h cpp/vscroll.h" };

  return %config;
}

sub configure_ext {
  my $this = shift;
  my %config = $this->get_flags;

  my( $ovlc, $ovlh ) = $config{WX}{wx_overload} ?
    @{$config{WX}{wx_overload}}{qw(source header)} : ();
  if( $ovlc && $ovlh ) {
    $config{clean} =
      { FILES => "$config{WX}{wx_overload}{source}" .
                 " $config{WX}{wx_overload}{header} overload" };
  }

  return %config;
}

sub files_with_constants {
  my( $this ) = @_;
  return @{$this->{wx_files_with_constants}}
    if $this->{wx_files_with_constants};
  return @{$this->{wx_files_with_constants} =
             [ Wx::build::Utils::files_with_constants ]};
}

sub files_with_overload {
  my( $this ) = @_;
  return @{$this->{wx_files_with_overload}}
    if $this->{wx_files_with_overload};
  return @{$this->{wx_files_with_overload} =
             [ Wx::build::Utils::files_with_overload ]};

}

sub _depend_common {
  my $this = shift;

  my $top_file =    $this->{WX}{wx_top}
                 || $this->{ARGS}{VERSION_FROM}
                 || $this->{ARGS}{ABSTRACT_FROM}
                 || 'Wx.pm';
  my( $ovlc, $ovlh ) = $this->{WX}{wx_overload} ?
    @{$this->{WX}{wx_overload}}{qw(source header)} : ();
  return ( xs_dependencies( $this, [ curdir, $this->get_api_directory
                                     ],
                            Wx::build::Utils::src_dir( $top_file ) ),
           # overload
           ( $ovlc && $ovlh ?
             ( $ovlc             => 'overload',
               $ovlh             => $ovlc,
               ) :
             ( ) ),
           );
}

sub depend_core {
  my $this = shift;


  my %files = $this->files_to_install();
  my %depend = ( _depend_common( $this ),
                 $exp              => join( ' ', $this->files_with_constants ),
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

sub subdirs_ext {
  my $this = shift;
  my $text = $this->SUPER::subdirs_core( @_ );

  return ( $this->{WX}{wx_overload} ? <<EOT : '' ) . $text;
subdirs :: overload

EOT
}

sub postamble_overload {
  my( $this ) = @_;

  my $ovl_script = Wx::build::MakeMaker::is_wxPerl_tree() ?
      'script/wx_overload.pl' : "-S wx_overload.pl";
  my( $ovlc, $ovlh ) = $this->{WX}{wx_overload} ?
    @{$this->{WX}{wx_overload}}{qw(source header)} : ();
  return ( $this->{WX}{wx_overload} ? <<EOT : '' );
overload :
\t\$(PERL) $ovl_script $ovlc $ovlh @{[$this->files_with_overload]}
\t\$(TOUCH) overload

EOT
}

sub postamble_core {
  my $this = shift;
  my %files = $this->files_to_install();

  Wx::build::Utils::write_string( 'files.lst',
                                  Data::Dumper->Dump( [ \%files ] ) );
  my $text = <<EOT . $this->postamble_overload;

$exp :
\t\$(PERL) script/make_exp_list.pl $exp @{[$this->files_with_constants]}

copy_files :
\t\$(PERL) script/copy_files.pl files.lst
\t\$(TOUCH) copy_files

fix_alien : lib/Wx/Mini.pm
\t\$(PERL) script/fix_alien_path.pl lib/Wx/Mini.pm blib/lib/Wx/Mini.pm
\t\$(TOUCH) fix_alien

parser :
	yapp -v -s -m Wx::XSP::Grammar -o build/Wx/XSP/Grammar.pm build/Wx/XSP/XSP.yp

typemap : typemap.tmpl script/make_typemap.pl
	perl script/make_typemap.pl typemap.tmpl typemap

EOT

  $text;
}

sub postamble_ext {
    my( $this ) = @_;

    return $this->postamble_overload;
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
