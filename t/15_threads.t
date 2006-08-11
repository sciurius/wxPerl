#!/usr/bin/perl -w

use strict;
use warnings;
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS(), 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 8;
use Wx::Event qw(EVT_BUTTON);

my $app = Wx::App->new( sub { 1 } );

EVT_BUTTON( $app, -1,
            sub {
                my $t = threads->create
                  ( sub {
                        ok( 1, 'In event thread' );
                    } );
                ok( 1, 'Before event join' );
                $t->join;
                ok( 1, 'After event join' );
            } );

my $color = Wx::Colour->new( 0, 10, 20 );
my $color2 = Wx::Colour->new( 0, 10, 20 );
my $color3 = Wx::Colour->new( 0, 10, 20 );
my $image = Wx::Image->new( 16, 16 );
my $image2 = Wx::Image->new( 16, 16 );
my $pen = Wx::Pen->new( $color2, 0, wxSOLID );
my $pen2 = Wx::Pen->new( $color2, 0, wxSOLID );
my $bitmap = Wx::Bitmap->new( 100, 100, -1 );
my $bitmap2 = Wx::Bitmap->new( 100, 100, -1 );
my $icon = Wx::Icon->new( 16, 16, -1 );
my $icon2 = Wx::Icon->new( 16, 16, -1 );
my $brush = Wx::Brush->new( $bitmap );
my $brush2 = Wx::Brush->new( $bitmap );
my $palette = Wx::Palette->new( ( [ 50 ] ) x 3 );
my $palette2 = Wx::Palette->new( ( [ 50 ] ) x 3 );
my $cursor = Wx::Cursor->new( $image );
my $cursor2 = Wx::Cursor->new( $image );
my $font = Wx::Font->new( 15, wxROMAN, wxNORMAL, wxNORMAL );
my $font2 = Wx::Font->new( 15, wxROMAN, wxNORMAL, wxNORMAL );
my $fontinfo = Wx::NativeFontInfo->new;
my $fontinfo2 = Wx::NativeFontInfo->new;
my $point = Wx::Point->new( 100, 100 );
my $point2 = Wx::Point->new( 100, 100 );
my $size = Wx::Size->new( 100, 100 );
my $size2 = Wx::Size->new( 100, 100 );
my $rect = Wx::Rect->new( $point, $size );
my $rect2 = Wx::Rect->new( $point, $size );
my $region = Wx::Region->new( $rect );
my $region2 = Wx::Region->new( $rect );
my $fontdata = Wx::FontData->new;
my $fontdata2 = Wx::FontData->new;
my $locale = Wx::Locale->new( wxLANGUAGE_DEFAULT );
my $locale2 = Wx::Locale->new( wxLANGUAGE_DEFAULT );
my $imagelist = Wx::ImageList->new( 16, 16 );
my $imagelist2 = Wx::ImageList->new( 32, 32 );
my $cs = Wx::CaretSuspend->new( Wx::Frame->new( undef, -1, 'Moo' ) );
my $cs2 = Wx::CaretSuspend->new( Wx::Frame->new( undef, -1, 'Moo' ) );
my $wd = Wx::WindowDisabler->new;
my $wd2 = Wx::WindowDisabler->new;
my $bc = Wx::BusyCursor->new;
my $bc2 = Wx::BusyCursor->new;
my $bi = Wx::BusyInfo->new( 'x' );
my $bi2 = Wx::BusyInfo->new( 'y' );
my $sw = Wx::StopWatch->new;
my $sw2 = Wx::StopWatch->new;

undef $fontinfo2; # check the ref hash is safe!
undef $color2;
undef $point2;
undef $size2;
undef $rect2;
undef $region2;
undef $pen2;
undef $bitmap2;
undef $font2;
undef $brush2;
undef $cursor2;
undef $fontdata2;
undef $icon2;
undef $image2;
undef $palette2;
undef $locale2;
undef $imagelist2;
undef $cs2;
undef $wd2;
undef $bc2;
undef $bi2;
undef $sw2;
my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

my $evt2 = Wx::CommandEvent->new( wxEVT_COMMAND_BUTTON_CLICKED, 123 );
undef $evt2;
$app->ProcessEvent
  ( Wx::CommandEvent->new( wxEVT_COMMAND_BUTTON_CLICKED, 123 ) );
ok( 1, 'After event' );

END { ok( 1, 'At END' ) };
