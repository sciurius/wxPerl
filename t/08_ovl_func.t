#!/usr/bin/perl -w

# test that overload dispatch works for
# specific functions

use strict;
use Wx;
use lib 'build';
use Test::More 'tests' => 36;
use Tests_Helper qw(test_app);

my $nolog = Wx::LogNull->new;
Wx::InitAllImageHandlers;

sub hijack {
  while( @_ ) {
    my( $name, $code ) = ( shift, shift );
    no strict 'refs';
    die $name unless defined &{$name};
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
ok( $newbmp, 'Wx::Brush::newBitmap' );

Wx::Brush->new( Wx::wxRED(), 1 );
ok( $newcol, 'Wx::Brush::newColour' );

my $b = Wx::Brush->new( 'red', 2 );
ok( $newname, 'Wx::Brush::newName' );

$b->SetColour( 1, 2, 3 );
ok( $scrgb, 'Wx::Brush::SetColourRGB' );

$b->SetColour( Wx::wxRED() );
ok( $sccol, 'Wx::Brush::SetColourColour' );

$b->SetColour( 'red' );
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
ok( $newempty, "Wx::Bitmap::newEmpty" );

Wx::Bitmap->new( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG() );
ok( $newfile,  "Wx::Bitmap::newFile" );

Wx::Bitmap->new( Wx::Icon->new() );
ok( $newicon,  "Wx::Bitmap::newIcon" );

Wx::Bitmap->new( Wx::Image->new( 1, 1 ) );
ok( $newimage, "Wx::Bitmap::newImage" );

Wx::Mask->new( Wx::Bitmap->new( 1, 1, 1 ), Wx::Colour->new( 'red' ) );
ok( $newbmpcol,"Wx::Mask::newBitmapColour" );

Wx::Mask->new( $bitmap, 0 );
ok( $newbmpn,  "Wx::Mask::newBitmapIndex" );

Wx::Mask->new( $bitmap );
ok( $newbmp,   "Wx::Mask::newBitmap" );
}

##############################################################################
# Wx::Colour
##############################################################################
{
my( $newrgb, $newname ) = ( 0, 0 );
hijack( Wx::Colour::newRGB => sub { $newrgb = 1 },
        Wx::Colour::newName => sub { $newname = 1 } );

Wx::Colour->new( 1, 2, 3 );
ok( $newrgb, "Wx::Colour::newRGB" );

Wx::Colour->new( 'red' );
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
ok( $newwh,       "Wx::Caret::newWH" );

Wx::Caret->new( Wx::Window->new( $frame, -1 ), [ 1, 1 ] );
ok( $newsize,     "Wx::Caret::newSize" );

$caret->Move( [ 1, 1 ] );
ok( $movepoint,   "Wx::Caret::MovePoint" );

Wx::Caret->new( Wx::Window->new( $frame, -1 ), 1, 1 )->Move( 1, 1 );
ok( $movexy,      "Wx::Caret::MoveXY" );

$caret->SetSize( [ 1, 1 ] );
ok( $setsizesize, "Wx::Caret::SetSizeSize" );

$caret->SetSize( 1, 1 );
ok( $setsizewh,   "Wx::Caret::SetSizeWH" );
}

##############################################################################
# Wx::ControlWithItems/Wx::ComboBox
##############################################################################
{
my( $cwiappendstr, $cwiappenddata,
    $cbappendstr, $cbappenddata,
    $cbsetselectionN, $cbsetselectionNN ) = ( 0, 0, 0, 0, 0, 0 );
my $good_combo = 'Wx::ComboBox'->isa( 'Wx::Choice' );
hijack( Wx::ControlWithItems::AppendString => sub { $cwiappendstr = 1 },
        Wx::ControlWithItems::AppendData   => sub { $cwiappenddata = 1 },
        ( $good_combo ? () :
          ( Wx::ComboBox::AppendString         => sub { $cbappendstr = 1 },
            Wx::ComboBox::AppendData           => sub { $cbappenddata = 1 } )
        ),
        Wx::ComboBox::SetMark              => sub { $cbsetselectionNN = 1 },
        Wx::ComboBox::SetSelectionN        => sub { $cbsetselectionN = 1 } );

my $cwi = Wx::ListBox->new( $frame, -1 );
my $cb = Wx::ComboBox->new( $frame, -1, 'bar' );

$cwi->Append( 'a' );
ok( $cwiappendstr,    "Wx::ControlWithItems::AppendString" );

$cwi->Append( 'a', {} );
ok( $cwiappenddata,   "Wx::ControlWithItems::AppendData" );

if( !$good_combo  ) {
  $cb->Append( 'a' );
  $cb->Append( 'b', sub {} );
} else {
  ( $cbappendstr, $cbappenddata ) = ( 1, 1 );
}
ok( $cbappendstr,     "Wx::ComboBox::AppendString" );
ok( $cbappenddata,    "Wx::ComboBox::AppendData" );

$cb->SetSelection( 0 );
ok( $cbsetselectionN, "Wx::ComboBox::SetSelectionN" );
$cb->SetSelection( 0, 1 );
ok( $cbsetselectionNN,"Wx::ComboBox::SetMark" );
}

##############################################################################
# Wx::Cursor
##############################################################################
{
my( $newid, $newimage, $newfile ) = ( 0, 0, 0 );
hijack( Wx::Cursor::newId    => sub { $newid = 1 },
        Wx::Cursor::newImage => sub { $newimage = 1 },
        Wx::Cursor::newFile  => sub { $newfile = 1 } );

Wx::Cursor->new( 1 );
ok( $newid,    "Wx::Cursor::newId" );

Wx::Cursor->new( Wx::Image->new( 1, 1 ) );
ok( $newimage, "Wx::Cursor::newImage" );

Wx::Cursor->new( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG(), 2, 2 );
ok( $newfile, "Wx::Cursor::newFile" );
}

##############################################################################
# Wx::Icon
##############################################################################
{
my( $newnull, $newfile ) = ( 0, 0 );
hijack( Wx::Icon::newNull => sub { $newnull = 1 },
        Wx::Icon::newFile => sub { $newfile = 1 } );

Wx::Icon->new();
ok( $newnull, "Wx::Icon::newNull" );

Wx::Icon->new( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG() );
ok( $newfile, "Wx::Icon::newFile" );
}

##############################################################################
# Wx::Icon
##############################################################################
{
my( $addtoollong, $addtoolshort, $setmarginsxy, $setmarginssize ) =
  ( 0, 0, 0, 0 );
hijack( Wx::ToolBarBase::AddToolLong    => sub { $addtoollong = 1 },
        Wx::ToolBarBase::AddToolShort   => sub { $addtoolshort = 1 },
        Wx::ToolBarBase::SetMarginsXY   => sub { $setmarginsxy = 1 },
        Wx::ToolBarBase::SetMarginsSize => sub { $setmarginssize = 1 } );

my $tbar = Wx::ToolBar->new( $frame, -1 );
$tbar->AddTool( Wx::wxID_NEW(), Wx::wxNullBitmap(), Wx::wxNullBitmap(), 0, undef, 'foo' );
ok( $addtoollong, "Wx::ToolBar::AddToolLong" );

$tbar->AddTool( -1, Wx::wxNullBitmap, 'a', 'b' );
ok( $addtoolshort, "Wx::ToolBar::AddToolShort" );

$tbar->SetMargins( 0, 1 );
ok( $setmarginsxy, "Wx::ToolBar::SetMarginsXY" );

$tbar->SetMargins( [1, 2] );
ok( $setmarginssize, "Wx::Toolbar::SetMarginsSize" );
}

$frame->Destroy;
} );

# local variables:
# mode: cperl
# end:
