#!/usr/bin/perl

use strict;
use Wx;

print "1..1\n";

my( @kv );
my( $ci, $cn );
my( @ph, @ch );

while ( @kv = each %Wx:: ) {
  if ( $kv[0] =~ m/^([^_].*)::$/ ) {
    undef @ph; undef @ch;
    $cn = 'wx' . $1 ;

    while ( 1 ) {
      $ci = Wx::ClassInfo::FindClass( $cn );

      push @ch, cpp_2_perl( $cn ) unless $cn eq 'wxObject';

      last unless $ci;
      $cn = $ci->GetBaseClassName1();
      last unless $cn;
    }

    my( $class ) = $1;
    my( @isa );

    while ( 1 ) {
      push @ph, 'Wx::' . $class;

      last unless exists $Wx::{$class . '::'}{ISA};
      @isa = @{ $Wx::{$class . '::'}{ISA} };
      last unless $isa[0];
      $class = $isa[0];
      $class =~ s/^Wx:://;
    }

    my( @o_ch ) = @ch;
    my( @o_ph ) = @ph;

    while( @ch ) {
      my( $c_class ) = shift @ch;
      next if $c_class =~ m/Base$/;
      next if $c_class =~ m/95$/;
      my( $p_class );

      while( @ph ) {
        $p_class = shift @ph;
        last if $c_class eq $p_class;
      }

      die "Unable to match C++ @o_ch with Perl @o_ph"
        unless $p_class eq $c_class;
    }
  }
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

print "ok\n";

exit 0;
# Local variables: #
# mode: cperl #
# End: #
