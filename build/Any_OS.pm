package Any_OS;

use strict;
use Config;
use File::Find;
use wxMMUtils;

#FIXME// this is an horrendous hack...
# since MakeMaker does only understand Makefile.PL une level below
# the top directory, and we need towo level below, we add one additional
# level to INST_* constants beginning with 'updir' ( usually '..' )
sub constants {
  my $this = shift;

  if( $this->{PARENT} ) {
    foreach my $k ( sort keys %$this ) {
      $k !~ m/^INST_/ && next;
      my $dir = $this->{$k};
      if( index( $dir, $this->updir ) == 0 ) {
        $this->{$k} = $this->canonpath( $this->catdir
          ( top_dir(), substr $this->{$k}, length( $this->updir ) ) );
#        substr( $this->{$k}, 0, length( $this->updir ) ) = top_dir();
      }
    }
  }

  package MY;
  $this->SUPER::constants( @_ );
}

sub depend {
  my $this = shift;
  my $exp = MM->catfile( qw(blib lib Wx _Exp.pm) );
  my $ovl = MM->catfile( qw(blib lib Wx _Ovl.pm) );

  my %depend = ( xs_depend( $this, [ MM->curdir(), top_dir() ] ),
                 ( $this->{PARENT} ?
                   () :
                   ( $exp => join( ' ', files_with_constants() ),
                     $ovl => join( ' ', files_with_overload() ),
                     '$(INST_STATIC)' => " $exp $ovl ",
                     '$(INST_DYNAMIC)' => " $exp $ovl ",
                   )
                 )
               );
  my %this_depend = @_;

  foreach ( keys %depend ) {
    $this_depend{$_} .= ' ' . $depend{$_};
  }

  package MY;
  $this->SUPER::depend( %this_depend );
}

#
# files that require special processing
#
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
      }
    };
  };

  find( $wanted, MM->curdir );

  return @files;
}

sub files_with_overload {
  my @files;

  my $wanted = sub {
    my $name = $File::Find::name;

    m/\.(?:pm)$/i && do {
      local *IN;
      my $line;

      open IN, "< $_" || warn "unable to open '$_'";
      while( defined( $line = <IN> ) ) {
        $line =~ m/Wx::_match/ && do {
          push @files, $name;
          return;
        };
      }
    };
  };

  find( $wanted, MM->curdir );

  return @files;
}

sub postamble {
  my $this = shift;
  my $text;

  unless( $this->{PARENT} ) {
    my @c_files = files_with_constants();
    my @o_files = files_with_overload();

    my $exp = MM->catfile( qw(blib lib Wx _Exp.pm) );
    my $ovl = MM->catfile( qw(blib lib Wx _Ovl.pm) );

    $text = <<EOT;

$exp :
\t\$(PERL) script/make_exp_list.pl $exp @c_files

$ovl :
\t\$(PERL) script/make_ovl_list.pl $ovl @o_files

EOT
  }

  $text;
}

sub configure {
  return @_;
}

sub get_config {
  my $this = $_[0];
  my %cfg1 = %{$_[1]};
  my %cfg2 = %{$wxConfig::Arch->configure( @_ )};
  my $cfg = merge_config( \%cfg1, \%cfg2 );

  if( $wxConfig::Verbose >= 1 ) {
    foreach (keys %$cfg) {
      m/^[A-Z]+$/ || next;
      print( $_ ," => ", $cfg->{$_}, "\n" );
    }
  }

  return $cfg;
}

# bleadperl does nasty things here
sub pasthru {
  package MY;
  my $text = shift->SUPER::pasthru( @_ );
  $text =~ s/INC="[^"]+"//;
  $text =~ s/DEFINE="[^"]+"//;

  return $text;
}

1;

# Local variables: #
# mode: cperl #
# End: #
