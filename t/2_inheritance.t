#!/usr/bin/perl

use strict;
use Wx;

my( @kv );
my( $ci, $cn );
my( %perl_inheritance, %cpp_inheritance );

while ( @kv = each %Wx:: ) {
  next unless $kv[0] =~ m/^([^_].*)::$/;

  my( $key ) = $1;

  $cn = 'wx' . $key ;

  next unless Wx::ClassInfo::FindClass( $cn );

  while ( 1 ) {
    $ci = Wx::ClassInfo::FindClass( $cn );

    push @{$cpp_inheritance{$key}}, cpp_2_perl( $cn );

    last unless $ci;
    $cn = $ci->GetBaseClassName1();
    last unless $cn;
  }

  my( $class ) = ( $key );
  my( @isa );

  $perl_inheritance{$key} = [] unless defined $perl_inheritance{$key};

  while ( 1 ) {
    push @{$perl_inheritance{$key}}, 'Wx::' . $class;

    last unless exists $Wx::{$class . '::'}{ISA};
    @isa = @{ $Wx::{$class . '::'}{ISA} };
    last unless $isa[0];
    $class = $isa[0];
    $class =~ s/^Wx:://;
  }
}

print '1..' . ( ( keys %perl_inheritance ) + 0 ) . "\n";

my( @ci, @pi );

CLASSES: while( @kv = each %perl_inheritance ) {
  print( "ok\n" ),next CLASSES
    if $kv[0] =~ m/Cursor|MenuItem|Icon/i; #FIXME// bug in wxWindows?

  @pi = @{$kv[1]};
  @ci = @{$cpp_inheritance{$kv[0]}};

  if( $ci[ $#ci ] ne 'Wx::Object' ) {
    print "not ok\n";
    print STDERR "\nclass $kv[0] ( " . join( ' ', @{$cpp_inheritance{$kv[0]}} )
      . " ) does not have Wx::Object as base";
    next CLASSES;
  }

  while ( @ci ) {
    my( $c_class ) = shift @ci;
    next if $c_class =~ m/Base$/;
    next if $c_class eq 'Wx::StatusBar95'; #FIXME// ad hoc
    next if $c_class eq 'Wx::StatusBarGeneric'; #FIXME// ad hoc
    next if $c_class eq 'Wx::Object';
    my( $p_class );

    while ( @pi ) {
      $p_class = shift @pi;
      last if $c_class eq $p_class;
    }

    if( !defined $p_class || $p_class ne $c_class ) {
      print( "not ok\n" );
      print STDERR "\nC++: " . join( ' ', @{$cpp_inheritance{$kv[0]}} ) .
        ' Perl: ' . join( ' ', @{$kv[1]} );

      next CLASSES;
    }
  }

  print "ok\n";
}

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

exit 0;
# Local variables: #
# mode: cperl #
# End: #
