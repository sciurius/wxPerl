#!/usr/bin/perl -w

# test that overload dispatch works for
# specific functions

use strict;
use Wx;
use lib 'build';
use Test::More 'tests' => 91;
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
my $bmpok = Wx::Bitmap->new( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG() );
my $imgok = Wx::Image->new( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG() );
my $icook = Wx::Icon->new( 'wxpl.ico', Wx::wxBITMAP_TYPE_ICO() );

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

Wx::Mask->new( $bmpok, Wx::Colour->new( 'red' ) );
ok( $newbmpcol,"Wx::Mask::newBitmapColour" );

SKIP: {
  skip "Does not work on wxGTK", 1 if Wx::wxGTK();

  Wx::Mask->new( $bmpok, 0 );
  ok( $newbmpn,  "Wx::Mask::newBitmapIndex" );
}

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
        ( Wx::wxMSW()
          ? ( Wx::Cursor::newFile  => sub { $newfile = 1 } )
          : () ) );

Wx::Cursor->new( 1 );
ok( $newid,    "Wx::Cursor::newId" );

Wx::Cursor->new( Wx::Image->new( 1, 1 ) );
ok( $newimage, "Wx::Cursor::newImage" );

SKIP: {
  skip "Only for wxMSW", 1 unless Wx::wxMSW();

  Wx::Cursor->new( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG(), 2, 2 );
  ok( $newfile, "Wx::Cursor::newFile" );
}
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
# Wx::ToolBar
##############################################################################
{
my( $addtoollong, $addtoolshort, $setmarginsxy, $setmarginssize ) =
  ( 0, 0, 0, 0 );
hijack( Wx::ToolBarBase::AddToolLong    => sub { $addtoollong = 1 },
        Wx::ToolBarBase::AddToolShort   => sub { $addtoolshort = 1 },
        Wx::ToolBarBase::SetMarginsXY   => sub { $setmarginsxy = 1 },
        Wx::ToolBarBase::SetMarginsSize => sub { $setmarginssize = 1 } );

my $tbar = Wx::ToolBar->new( $frame, -1 );
$tbar->SetMargins( 0, 1 );
ok( $setmarginsxy, "Wx::ToolBar::SetMarginsXY" );

$tbar->SetMargins( [1, 2] );
ok( $setmarginssize, "Wx::Toolbar::SetMarginsSize" );

$tbar->AddTool( Wx::wxID_NEW(), $bmpok, Wx::wxNullBitmap(), 0, undef, 'foo' );
ok( $addtoollong, "Wx::ToolBar::AddToolLong" );

$tbar->AddTool( -1, $bmpok, 'a', 'b' );
ok( $addtoolshort, "Wx::ToolBar::AddToolShort" );
}

##############################################################################
# Wx::StaticBitmap
##############################################################################
{
my( $newicon, $newbitmap ) = ( 0, 0 );
hijack( Wx::StaticBitmap::newIcon   => sub { $newicon = 1 },
        Wx::StaticBitmap::newBitmap => sub { $newbitmap =1 } );

Wx::StaticBitmap->new( $frame, -1, Wx::wxNullIcon() );
ok( $newicon,   "Wx::StaticBitmap::newIcon" );

Wx::StaticBitmap->new( $frame, -1, Wx::wxNullBitmap() );
ok( $newbitmap, "Wx::StaticBitmap::newBitmap" );
}

##############################################################################
# Wx::Rect
##############################################################################
{
my( $newxywh, $newps, $newpp ) = ( 0, 0, 0 );
hijack( Wx::Rect::newXYWH => sub { $newxywh = 1 },
        Wx::Rect::newPS   => sub { $newps = 1 },
        Wx::Rect::newPP   => sub { $newpp = 1 } );

Wx::Rect->new( 0, 1, 2, 3 );
ok( $newxywh, "Wx::Rect::newXYWH" );

Wx::Rect->new( Wx::Point->new( 0, 1 ), Wx::Size->new( 1, 2 ) );
ok( $newps, "Wx::Rect::newPS" );

Wx::Rect->new( Wx::Point->new( 0, 1 ), Wx::Point->new( 2, 3 ) );
ok( $newpp, "Wx::Rect::newPP" );
}

##############################################################################
# Wx::ScreenDC
##############################################################################
{
my( $sdotwin, $sdotrec ) = ( 0, 0 );
hijack( Wx::ScreenDC::StartDrawingOnTopWindow => sub { $sdotwin = 1 },
        Wx::ScreenDC::StartDrawingOnTopRect   => sub { $sdotrec = 1 } );

my $dc = Wx::ScreenDC->new;

$dc->StartDrawingOnTop( $frame );
ok( $sdotwin, "Wx::ScreenDC::StartDrawingOnTopWindow" );

$dc->EndDrawingOnTop;
$dc->StartDrawingOnTop( Wx::Rect->new( 0, 1, 2, 3 ) );
ok( $sdotrec, "Wx::ScreenDC::StartDrawingOnTopRect" );
}

##############################################################################
# Wx::Window
##############################################################################
{
my( $ssxywh, $sswh, $sssize, $ssrect, $stttip, $sttstr, $ctsxy, $ctspoint,
    $cdppoint, $cdpsize, $cpdpoint, $cpdsize, $iepoint, $ierect, $iexywh,
    $movepoint, $movexy, $stcpoi, $stcxy, $scspoi, $scswh )
  = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
hijack( Wx::Window::SetSizeXYWHF => sub { $ssxywh = 1 },
        Wx::Window::SetSizeWH    => sub { $sswh = 1 },
        Wx::Window::SetSizeSize  => sub { $sssize = 1 },
        Wx::Window::SetSizeRect  => sub { $ssrect = 1 },
        Wx::Window::SetToolTipTip    => sub { $stttip = 1 },
        Wx::Window::SetToolTipString => sub { $sttstr = 1 },
        Wx::Window::ClientToScreenXY    => sub { $ctsxy = 1 },
        Wx::Window::ClientToScreenPoint => sub { $ctspoint = 1 },
        Wx::Window::ConvertDialogPointToPixels => sub { $cdppoint = 1 },
        Wx::Window::ConvertDialogSizeToPixels  => sub { $cdpsize =1 },
        Wx::Window::ConvertPixelsPointToDialog => sub { $cpdpoint = 1 },
        Wx::Window::ConvertPixelsSizeToDialog  => sub { $cpdsize =1 },
        Wx::Window::IsExposedPoint => sub { $iepoint = 1 },
        Wx::Window::IsExposedRect  => sub { $ierect = 1 },
        Wx::Window::IsExposedXYWH  => sub { $iexywh = 1 },
        Wx::Window::MovePoint      => sub { $movepoint = 1 },
        Wx::Window::MoveXY         => sub { $movexy = 1 },
#        Wx::Window::PopupMenuPoint => sub { $poppoint = 1 },
#        Wx::Window::PopupMenuXY    => sub { $popxy = 1 },
        Wx::Window::ScreenToClientPoint => sub { $stcpoi = 1 },
        Wx::Window::ScreenToClientXY    => sub { $stcxy = 1 },
        Wx::Window::SetClientSizeSize   => sub { $scspoi = 1 },
        Wx::Window::SetClientSizeWH     => sub { $scswh = 1 } );

$frame->SetSize( 20, 20, 30, 30 );
ok( $ssxywh, "Wx::Window::SetSizeXYWHF" );

$frame->SetSize( 40, 40 );
ok( $sswh, "Wx::Window::SetSizeWH" );

$frame->SetSize( [ 50, 50 ] );
ok( $sssize, "Wx::Window::SetSizeSize" );

$frame->SetSize( Wx::Rect->new( 40, 40, 60, 60 ) );
ok( $ssrect, "Wx::Window::SetSizeRect" );

$frame->SetToolTip( "FOO" );
ok( $sttstr, "Wx::Window::SetToolTipString" );

$frame->SetToolTip( Wx::ToolTip->new( "Bar" ) );
ok( $stttip, "Wx::Window::SetToolTipTip" );

$frame->ClientToScreen( 1, 2 );
ok( $ctsxy, "Wx::Window::ClientToScreenXY" );

$frame->ClientToScreen( [1, 2] );
ok( $ctspoint, "Wx::Window::ClientToScreenPoint" );

$frame->ConvertDialogToPixels( Wx::Point->new( 2, 3 ) );
ok( $cdppoint, "Wx::Window::ConvertDialogPointToPixels" );

$frame->ConvertDialogToPixels( Wx::Size->new( 1, 2 ) );
ok( $cdpsize, "Wx::Window::ConvertDialogSizeToPixels" );

$frame->ConvertPixelsToDialog( Wx::Point->new( 2, 3 ) );
ok( $cpdpoint, "Wx::Window::ConvertPixelsPointToDialog" );

$frame->ConvertPixelsToDialog( Wx::Size->new( 1, 2 ) );
ok( $cpdsize, "Wx::Window::ConvertPixelsSizeToDialog" );

$frame->IsExposed( Wx::Point->new( 1, 2 ) );
ok( $iepoint, "Wx::Window::IsExposedPoint" );

$frame->IsExposed( Wx::Rect->new( 1, 2, 3, 4 ) );
ok( $ierect, "Wx::Window::IsExposedRect" );

$frame->IsExposed( 1, 2, 3, 4 );
ok( $iexywh, "Wx::Window::IsExposedXYWH" );

$frame->Move( [ 50, 50 ] );
ok( $movepoint, "Wx::Window::MovePoint" );

$frame->Move( 6, 60 );
ok( $movexy, "Wx::Window::MoveXY" );

$frame->ScreenToClient( [ 1, 2 ] );
ok( $stcpoi, "Wx::Window::ScreenToClientPoint" );

$frame->ScreenToClient( 1, 2 );
ok( $stcxy, "Wx::Window::ScreenToClientXY" );

$frame->SetClientSize( [50, 50] );
ok( $scspoi, "Wx::Window::SetClientSizePoint" );

$frame->SetClientSize( 200, 200 );
ok( $scswh, "Wx::Window::SetClientSizeWH" );
}

##############################################################################
# Wx::DC
##############################################################################
{
my( $drawcxywh, $drawcrec, $setclxywh, $setclreg ) = ( 0, 0, 0, 0 );
hijack( Wx::DC::DrawCheckMarkXYWH => sub { $drawcxywh = 1 },
        Wx::DC::DrawCheckMarkRect => sub { $drawcrec = 1 },
        Wx::DC::SetClippingRegionXYWH  => sub { $setclxywh = 1 },
        Wx::DC::SetClippingRegionRegion => sub { $setclreg = 1 } );

my $dc = Wx::ClientDC->new( $frame );
$dc->DrawCheckMark( 1, 2, 5, 6 );
ok( $drawcxywh, "Wx::DC::DrawCheckMarkXYWH" );

$dc->DrawCheckMark( Wx::Rect->new( 1, 2, 5, 6 ) );
ok( $drawcrec, "Wx::DC::DrawCheckMarkRect" );

$dc->SetClippingRegion( 0, 0, 50, 50 );
ok( $setclxywh, "Wx::DC::SetClippingRegionXYWH" );

$dc->SetClippingRegion( Wx::Region->new( Wx::Rect->new( 0, 0, 40, 40 ) ) );
ok( $setclreg, "Wx::DC::SetClippingRegionRegion" );
}

##############################################################################
# Wx::TreeCtrl
##############################################################################
{
my( $tgetp, $wgetp, $iitid, $iiint ) = ( 0, 0, 0, 0 );
hijack( Wx::TreeCtrl::GetParent => sub { $tgetp = 1 },
        Wx::Window::GetParent   => sub { $wgetp = 1 },
        Wx::TreeCtrl::InsertItemPrev => sub { $iitid = 1 },
        Wx::TreeCtrl::InsertItemBef  => sub { $iiint = 1 } );

my $tc = Wx::TreeCtrl->new( $frame, -1 );
my $rt = $tc->AddRoot( 'root' );
my $c1 = $tc->AppendItem( $rt, 'first' );
my $c2 = $tc->AppendItem( $rt, 'second' );

$tc->GetParent( $c1 );
ok( $tgetp, "Wx::TreeCtrl::GetParent" );

$tc->GetParent;
ok( $wgetp, "Wx::Window::GetParent" );

$tc->InsertItem( $rt, $c1, 'insert 1' );
ok( $iitid, "Wx::TreeCtrl::InsertItemPrev" );

$tc->InsertItem( $rt, 1, 'insert 2' );
ok( $iiint, "Wx::TreeCtrl::InsertItemBef" );
}

##############################################################################
# Wx::Pen
##############################################################################
{
my( $newcol, $newbitmap, $newstring,
    $setcolcol, $setcolrgb, $setcolname ) = ( 0, 0, 0, 0, 0, 0 );
hijack( Wx::Pen::newColour    => sub { $newcol = 1 },
        Wx::Pen::newBitmap    => sub { $newbitmap = 1 },
        Wx::Pen::newString    => sub { $newstring = 1 },
        Wx::Pen::SetColourColour => sub { $setcolcol = 1 },
        Wx::Pen::SetColourRGB    => sub { $setcolrgb = 1 },
        Wx::Pen::SetColourName   => sub { $setcolname = 1 } );

Wx::Pen->new( Wx::Colour->new( 'red' ), 0, 0 );
ok( $newcol, "Wx::Pen::newColour" );

SKIP: {
  skip "MSW-only method", 1 unless Wx::wxMSW();

  Wx::Pen->new( $bmpok, 1 );
  ok( $newbitmap, "Wx::Pen::newBitmap" );
}

my $pen = Wx::Pen->new( 'red', 0, 0 );
ok( $newstring, "Wx::Pen::newString" );

$pen->SetColour( Wx::wxRED() );
ok( $setcolcol, "Wx::Pen::SetColourColour" );

$pen->SetColour( 1, 2, 3 );
ok( $setcolrgb, "Wx::Pen::SetColourRGB" );

$pen->SetColour( 'red' );
ok( $setcolname, "Wx::Pen::SetColourName" );
}

##############################################################################
# Wx::Image
##############################################################################
{
my( $newnull, $newicon, $newbitmap, $newstreamt, $newstreamm,
    $newwh, $newdata, $newnametype, $newnamemime,
    $lsm, $lst, $lft, $lfm, $ssm, $sst, $sft, $sfm, $sfo )
  = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
hijack( Wx::Image::newNull        => sub { $newnull = 1 },
        Wx::Image::newIcon        => sub { $newicon = 1 },
        Wx::Image::newBitmap      => sub { $newbitmap = 1 },
        Wx::Image::newStreamType  => sub { $newstreamt = 1 },
        Wx::Image::newStreamMIME  => sub { $newstreamm = 1 },
        Wx::Image::newWH          => sub { $newwh = 1 },
        Wx::Image::newData        => sub { $newdata = 1 },
        Wx::Image::newNameType    => sub { $newnametype = 1 },
        Wx::Image::newNameMIME    => sub { $newnamemime = 1 },
        Wx::Image::LoadStreamType => sub { $lst = 1 },
        Wx::Image::LoadStreamMIME => sub { $lsm = 1 },
        Wx::Image::LoadFileType   => sub { $lft = 1 },
        Wx::Image::LoadFileMIME   => sub { $lfm = 1 },
#        Wx::Image::SaveFileSType  => sub { $sst = 1 },
#        Wx::Image::SaveFileSMIME  => sub { $ssm = 1 },
#        Wx::Image::SaveFileType   => sub { $sft = 1 },
#        Wx::Image::SaveFileMIME   => sub { $sfm = 1 },
#        Wx::Image::SaveFileOnly   => sub { $sfo = 1 }
      );

my $op = '< demo/data/logo.jpg';
Wx::Image->new;
ok( $newnull, "Wx::Image::newNull" );

Wx::Image->new( $icook );
ok( $newicon, "Wx::Image::newIcon" );

Wx::Image->new( $bmpok );
ok( $newbitmap, "Wx::Image::newBitmap" );

open IN, $op; binmode IN;
Wx::Image->new( *IN, Wx::wxBITMAP_TYPE_JPEG() );
ok( $newstreamt, "Wx::Image::newStreamType" );

open IN, $op; binmode IN;
Wx::Image->new( *IN, 'image/jpeg' );
ok( $newstreamm, "Wx::Image::newStreamMIME" );

Wx::Image->new( 1, 2 );
ok( $newwh, "Wx::Image::newWH" );

Wx::Image->new( 3, 4, ' ' x 3 x 4 x 3 );
ok( $newdata, "Wx::Image::newData" );

Wx::Image->new( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG() );
ok( $newnametype, "Wx::Image::newNameType" );

Wx::Image->new( 'demo/data/logo.jpg', 'image/jpeg' );
ok( $newnametype, "Wx::Image::newNameMIME" );

my $img = Wx::Image->new;
open IN, $op; binmode IN;
$img->LoadFile( \*IN, Wx::wxBITMAP_TYPE_JPEG() );
ok( $lst, "Wx::Image::LoadStreamType" );

open IN, $op; binmode IN;
$img->LoadFile( \*IN, 'image/jpeg' );
ok( $lsm, "Wx::Image::LoadStreamMIME" );

$img->LoadFile( 'demo/data/logo.jpg', Wx::wxBITMAP_TYPE_JPEG() );
ok( $lft, "Wx::Image::LoadFileType" );

$img->LoadFile( 'demo/data/logo.jpg', 'image/jpeg' );
ok( $lfm, "Wx::Image::LoadFileMIME" );
}

$frame->Destroy;
} );

# local variables:
# mode: cperl
# end:
