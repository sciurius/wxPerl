#############################################################################
## Name:        Tests_Helper.PL
## Purpose:     some test helper functions
## Author:      Mattia Barbon
## Modified by:
## Created:      2/ 6/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Tests_Helper;

use strict;
require Exporter;

use vars qw(@ISA %EXPORT_TAGS @EXPORT_OK);

@ISA = qw(Exporter);

@EXPORT_OK = qw(print_result test_inheritance test_inheritance_all
                test_inheritance_start test_inheritance_end 
                test_app test_frame);

%EXPORT_TAGS =
  ( inheritance => [ qw(test_inheritance test_inheritance_all
                        test_inheritance_start test_inheritance_end) ],
  );

sub test_app {
  my $function = shift;

  my $app = Tests_Helper_App->new( $function );
}

sub test_frame {
  my $class = shift;
  my @params = @_;

  my $function = sub {
    my $frame = $class->new( @params );
  };

  my $app = Tests_Helper_App->new( $function );

  return $app;
}

sub test_inheritance {
  my( %perl_inheritance, %cpp_inheritance );

 LOOP: foreach my $i ( @_ ) {
    my $key = $i;
    my $cn = "wx${key}";
    my $ci = Wx::ClassInfo::FindClass( $cn ) or next LOOP;

    while ( 1 ) {
      push @{$cpp_inheritance{$key}}, cpp_2_perl( $cn );

      last unless $ci;
      $cn = $ci->GetBaseClassName1();
      last unless $cn;
      $ci = Wx::ClassInfo::FindClass( $cn );
    }

    my $class = $key;

    while ( $class ) {
      push @{$perl_inheritance{$key}}, "Wx::$class";

      last unless exists $Wx::{"${class}::"}{ISA} && 
        @{ $Wx::{"${class}::"}{ISA} };
      die $class unless defined @{ $Wx::{"${class}::"}{ISA} }[0];
      $class = substr @{ $Wx::{"${class}::"}{ISA} }[0], 4;
    }
  }

  my @results;

 CLASSES: foreach my $i ( keys %perl_inheritance ) {
    my $pi = $perl_inheritance{$i};
    my $ci = $cpp_inheritance{$i};
    my @pi = @$pi;
    my @ci =  @$ci;

  COMPARE: while ( @ci ) {
      my( $c_class ) = shift @ci;
      next if $c_class =~ m/(?:Base|GTK)$/;
      next if $c_class =~ m/StatusBar/; #FIXME// ad hoc
      next if $c_class eq 'Wx::Object';
      my( $p_class );

      while ( @pi ) {
        $p_class = shift @pi;
        next COMPARE if $c_class eq $p_class;
      }

      push @results, 0;
      print STDERR "\nC++: @{$ci} Perl: @{$pi}\n";

      next CLASSES;
    }

    push @results, 1;
  }

  return @results;
}

{
  my %classes_skip;

  sub test_inheritance_start {
    foreach my $i ( keys %Wx:: ) {
      next unless $i =~ m/^([^_].*)::$/;
      $classes_skip{$1} = 1;
    }
  }

  sub test_inheritance_end {
    my @classes;

    foreach my $i ( keys %Wx:: ) {
      next unless $i =~ m/^([^_].*)::$/;
      next if exists $classes_skip{$1};
      push @classes, $1;
    }

    my @results = test_inheritance( @classes );

    print_results( @results );
  }
}

sub test_inheritance_all {
  my @classes;

  foreach my $i ( keys %Wx:: ) {
    next unless $i =~ m/^([^_].*)::$/;
    push @classes, $1;
  }

  my @results = test_inheritance( @classes );

  print_results( @results );
}

sub print_results {
  print "1.." . ( @_ + 1 ) . "\n";
  print "ok\n"; # dummy, to avoid 'all tests skipped'
  foreach my $i ( @_ ) { print( $i ? "ok\n" : "not ok\n" ) }
}

# utility

sub perl_2_cpp {
  my( $v ) = $_[0];

  $v =~ s/^Wx::/wx/;

  $v;
}

sub cpp_2_perl {
  my( $v ) = $_[0];

  $v =~ s/^wx/Wx::/;

  $v;
}

package Tests_Helper_App;

use vars qw(@ISA); @ISA = qw(Wx::App);

my $on_init;

sub new {
  my $class = shift;
  my $function = shift;
  $on_init = $function;
  my $this = $class->SUPER::new( @_ );

  return $this;
}

sub OnInit {
  &$on_init;

  return 1;
}

1;

# Local variables: #
# mode: cperl #
# End: #
