#!/usr/bin/perl -w

# test that overload dispatch works for
# specific functions

use strict;
use Wx;
use lib 'build';
use Test::More 'tests' => 21;
use Tests_Helper qw(test_app);

my $nolog = Wx::LogNull->new;
Wx::InitAllImageHandlers;

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
my $frame = Wx::Frame->new( undef, -1, 'a' );
##############################################################################
# Wx::Brush
##############################################################################
{
my( $newbmp, $newcol, $newname ) = ( 0, 0, 0 );
my( $scrgb, $sccol, $scname ) = ( 0, 0, 0 );

hijack( Wx::Brush::newBitmap       => sub { $newbmp = 1 },
        Wx::Brush::newColour       => sub { $newcol = 1 },
        Wx::Brush::newName         => sub { $newname = 1 },
        Wx::Brush::SetColourRGB    => sub { $scrgb = 1 },
        Wx::Brush::SetColourColour => sub { $sccol = 1 },
        Wx::Brush::SetColourName   => sub { $scname = 1 } );

Wx::Brush->new( Wx::Bitmap->new( 1, 1, 1 ) );
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
}

##############################################################################
# Wx::Bitmap & Wx::Mask
##############################################################################
{
my( $newbmp, $newbmpn, $newbmpcol ) = ( 0, 0, 0 );
my( $newempty, $newfile, $newicon, $newimage ) = ( 0, 0, 0, 0 );

hijack( Wx::Mask::newBitmapColour => sub { $newbmpcol = 1 },
        Wx::Mask::newBitmapIndex  => sub { $newbmpn = 1 },
        Wx::Mask::newBitmap       => sub { $newbmp = 1 },
        Wx::Bitmap::newEmpty      => sub { $newempty = 1 },
        Wx::Bitmap::newFile       => sub { $newfile = 1 },
        Wx::Bitmap::newIcon       => sub { $newicon = 1 },
        Wx::Bitmap::newImage      => sub { $newimage = 1 } );

my $bitmap = Wx::Bitmap->new( 1, 1, 1 );
Wx::Bitmap->new( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG() );
Wx::Bitmap->new( Wx::Icon->new() );
Wx::Bitmap->new( Wx::Image->new( 1, 1 ) );

Wx::Mask->new( Wx::Bitmap->new( 1, 1, 1 ), Wx::Colour->new( 'red' ) );
Wx::Mask->new( $bitmap, 0 );
Wx::Mask->new( $bitmap );

ok( $newempty, "Wx::Bitmap::newEmpty" );
ok( $newfile,  "Wx::Bitmap::newFile" );
ok( $newicon,  "Wx::Bitmap::newIcon" );
ok( $newimage, "Wx::Bitmap::newImage" );
ok( $newbmp,   "Wx::Mask::newBitmap" );
ok( $newbmpn,  "Wx::Mask::newBitmapIndex" );
ok( $newbmpcol,"Wx::Mask::newBitmapColour" );
}

##############################################################################
# Wx::Colour
##############################################################################
{
my( $newrgb, $newname ) = ( 0, 0 );
hijack( Wx::Colour::newRGB => sub { $newrgb = 1 },
        Wx::Colour::newName => sub { $newname = 1 } );

Wx::Colour->new( 1, 2, 3 );
Wx::Colour->new( 'red' );

ok( $newrgb, "Wx::Colour::newRGB" );
ok( $newname, "Wx::Colour::newName" );
}

##############################################################################
# Wx::Caret
##############################################################################
{
my( $newwh, $newsize, $movepoint, $movexy, $setsizesize, $setsizewh ) =
  ( 0, 0, 0, 0, 0, 0 );
hijack( Wx::Caret::newWH     => sub { $newwh = 1 },
        Wx::Caret::newSize   => sub { $newsize = 1 },
        Wx::Caret::MovePoint => sub { $movepoint = 1 },
        Wx::Caret::MoveXY    => sub { $movexy = 1 },
        Wx::Caret::SetSizeSize => sub { $setsizesize = 1 },
        Wx::Caret::SetSizeWH => sub { $setsizewh = 1 } );

my $caret = Wx::Caret->new( Wx::Window->new( $frame, -1 ), 1, 1 );
Wx::Caret->new( Wx::Window->new( $frame, -1 ), [ 1, 1 ] );
$caret->Move( [ 1, 1 ] );
Wx::Caret->new( Wx::Window->new( $frame, -1 ), 1, 1 )->Move( 1, 1 );
$caret->SetSize( [ 1, 1 ] );
$caret->SetSize( 1, 1 );

ok( $newwh,       "Wx::Caret::newWH" );
ok( $newsize,     "Wx::Caret::newSize" );
ok( $movepoint,   "Wx::Caret::MovePoint" );
ok( $movexy,      "Wx::Caret::MoveXY" );
ok( $setsizesize, "Wx::Caret::SetSizeSize" );
ok( $setsizewh,   "Wx::Caret::SetSizeWH" );
}

$frame->Destroy;
} );

# local variables:
# mode: cperl
# end:
