#!/usr/bin/perl -w

# test that overload dispatch works for
# specific functions

use strict;
use Wx;
use lib 'build';
use Test::More 'tests' => 6;
use Tests_Helper qw(test_app);

sub hijack {
  while( @_ ) {
    my( $name, $code ) = ( shift, shift );
    no strict 'refs';
    my $old = \&{$name};
    undef *{$name};
    *{$name} = sub { &$code; goto &$old };
  }
}

test_app( sub {
# Wx::Brush
my( $newbmp, $newcol, $newname ) = ( 0, 0, 0 );
my( $scrgb, $sccol, $scname ) = ( 0, 0, 0 );

hijack( Wx::Brush::newBitmap => sub { $newbmp = 1 },
        Wx::Brush::newColour => sub { $newcol = 1 },
        Wx::Brush::newName   => sub { $newname = 1 },
        Wx::Brush::SetColourRGB => sub { $scrgb = 1 },
        Wx::Brush::SetColourColour => sub { $sccol = 1 },
        Wx::Brush::SetColourName => sub { $scname = 1 } );

Wx::Brush->new( Wx::Bitmap->new( 1, 1 ) );
Wx::Brush->new( Wx::wxRED(), 1 );
my $b = Wx::Brush->new( 'red', 2 );

$b->SetColour( 1, 2, 3 );
$b->SetColour( Wx::wxRED() );
$b->SetColour( 'red' );

ok( $newbmp, 'Wx::Brush::newBitmap' );
ok( $newcol, 'Wx::Brush::newColour' );
ok( $newname, 'Wx::Brush::newName' );
ok( $scrgb, 'Wx::Brush::SetColourRGB' );
ok( $sccol, 'Wx::Brush::SetColourColour' );
ok( $scname, 'Wx::Brush::SetColourName' );
} );

# local variables:
# mode: cperl
# end:
