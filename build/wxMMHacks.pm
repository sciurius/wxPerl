package wxMMHacks;

sub _find_name($$) {
  my( $package, $method ) = @_;

  no strict 'refs';
  return $package if defined &{"${package}::${method}"};
  my @isa = @{$package . '::ISA'};
  use strict 'refs';

  foreach my $i ( @isa ) {
    my $p = &_find_name( $i, $method );
    return $p if $p;
  }

  return;
}

sub hijack($$$) {
  my( $obj, $method, $replace ) = @_;
  my $spackage = ref $obj ? ref $obj : $obj;
  my $rpackage = _find_name( $spackage, $method );

  die "Can't hijack method '$method' from package '$package'",
    unless $rpackage;

  my $fqn = "${rpackage}::$method";
  no strict 'refs';
  my $save = \&{$fqn};
  undef *{$fqn};
  *{$fqn} = $replace;

  return $save;
}

#
# Cut'n'paste from 5.005_03 MakeMaker.pm
#
sub WriteEmptyMakefile {
  if (-f 'Makefile.old') {
    chmod 0666, 'Makefile.old';
    unlink 'Makefile.old' or warn "unlink Makefile.old: $!";
  }
  rename 'Makefile', 'Makefile.old' or warn "rename Makefile Makefile.old: $!"
    if -f 'Makefile';
  open MF, '> Makefile' or die "open Makefile for write: $!";
  print MF <<'EOP';
all:

clean:

install:

makemakerdflt:

test:

EOP
  close MF or die "close Makefile for write: $!";
}

if( $] < 5.005 )
{
  *ExtUtils::MakeMaker::WriteEmptyMakefile = \&WriteEmptyMakefile
}

1;

# local variables:
# mode: cperl
# end:
