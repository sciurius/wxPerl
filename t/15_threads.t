#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS(), 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 8;
use Wx::Event qw(EVT_BUTTON);

Wx::InitAllImageHandlers;

my @tocheck;
sub check_init(&) {
    my( $code ) = @_;

    push @tocheck, [ $code->(), $code->() ];
}

sub check_undef {
    $_->[1] = undef foreach @tocheck;
}

my $testtreelist = defined(&Wx::TreeListCtrl::new);

my $app = Wx::App->new( sub { 1 } );
# ancillary
my $frame = Wx::Frame->new( undef, -1, 'Test frame' );
$frame->Show; # otherwise overlay tests fail
my $treectrl = Wx::TreeCtrl->new( $frame, -1 );
my $textctrl = Wx::TextCtrl->new( $frame, -1, 'Some text' );
my $treelist = Wx::TreeListCtrl->new( $frame, -1) if $testtreelist;
my $point = Wx::Point->new( 100, 100 );
my $size = Wx::Size->new( 100, 100 );
my $rect = Wx::Rect->new( $point, $size );
my $region = Wx::Region->new( $rect );
my $bitmap = Wx::Bitmap->new( 100, 100, -1 );
my $image = Wx::Image->new( 16, 16 );
my $locker;
my $animation;
if( Wx::wxVERSION >= 2.008 ) {
    $locker = Wx::WindowUpdateLocker->new( $frame );
    $animation = Wx::Animation->new;
}
my $blocker;
if( Wx::wxVERSION >= 2.009 ) {
    $blocker = Wx::EventBlocker->new( $frame );
}
my $display = Wx::Display->new;
my $vidmode = Wx::VideoMode->new;
my $variant = Wx::Variant->new( 1 );
my $sound = Wx::Sound->new;
my $dc = Wx::ScreenDC->new;
my $dcclipper;
if( Wx::wxVERSION >= 2.008 ) {
    $dcclipper = Wx::DCClipper->new( $dc, 20, 20, 40, 40 );
}
my $notification;
if( Wx::wxVERSION >= 2.009 ) {
    $notification = Wx::NotificationMessage->new( 'Test' );
    $notification->Show(1); # avoid crash with current version
}
my $mimetypes = Wx::MimeTypesManager->new;

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
check_init { Wx::Image->new( 16, 16 ) };
my $pen = Wx::Pen->new( $color2, 0, wxSOLID );
my $pen2 = Wx::Pen->new( $color2, 0, wxSOLID );
check_init { Wx::Bitmap->new( 100, 100, -1 ) };
check_init { Wx::Icon->new( 'wxpl.ico', Wx::wxBITMAP_TYPE_ICO() ) };
check_init { Wx::Brush->new( $bitmap ) };
check_init { Wx::Palette->new( ( [ 50 ] ) x 3 ) };
check_init { Wx::Cursor->new( $image ) };
check_init { Wx::Font->new( 15, wxROMAN, wxNORMAL, wxNORMAL ) };
check_init { Wx::NativeFontInfo->new };
check_init { Wx::Point->new( 100, 100 ) };
check_init { Wx::Size->new( 100, 100 ) };
check_init { Wx::Rect->new( $point, $size ) };
check_init { Wx::Region->new( $rect ) };
check_init { Wx::RegionIterator->new( $region ) };
check_init { Wx::FontData->new };
check_init { Wx::Locale->new( wxLANGUAGE_DEFAULT ) };
my $imagelist = Wx::ImageList->new( 16, 16 );
my $imagelist2 = Wx::ImageList->new( 32, 32 );
check_init { Wx::CaretSuspend->new( Wx::Frame->new( undef, -1, 'Moo' ) ) };
if( Wx::wxVERSION > 2.009001 ) {
    # OSX fails to handle null window or 1
    check_init { Wx::WindowDisabler->new(0) };
} else {
    check_init { Wx::WindowDisabler->new };
}

check_init { Wx::BusyCursor->new };
my $bi = Wx::BusyInfo->new( 'x' );
my $bi2 = Wx::BusyInfo->new( 'y' );
check_init { Wx::StopWatch->new };
my $tid = $treectrl->AddRoot( 'Test root' );
my $tid2 = $treectrl->AppendItem( $tid, 'Test child' );
my ($tlid, $tlid1, $tlid2, $tlid3, $tlid4, $tlccomp, $tlccompkeep);

if($testtreelist) {
    $tlid = $treelist->GetRootItem;
    $tlid1 = $treelist->AppendItem( $tlid, 'Test Child' );
    $tlid2 = $treelist->AppendItem( $tlid, 'Test Child' );
    check_init { Wx::PlTreeListItemComparator->new };
    $tlccomp = Wx::PlTreeListItemComparator->new;
    $tlccompkeep = Wx::PlTreeListItemComparator->new;
    $treelist->SetItemComparator( Wx::PlTreeListItemComparator->new );
}

if(defined(&Wx::UIActionSimulator::new)) {
    check_init { Wx::UIActionSimulator->new };
}

check_init { Wx::TextAttr->new };
check_init { Wx::LanguageInfo->new( 12345, 'Dummy', 2, 3, 'Dummy' ) };
check_init { Wx::SingleInstanceChecker->new };
check_init { Wx::ListItem->new };
check_init { Wx::ListItemAttr->new };
check_init { Wx::LogNull->new };
check_init { Wx::ClientDC->new( $frame ) };
check_init { Wx::ScreenDC->new };
check_init { Wx::ColourData->new };
check_init { Wx::FontEnumerator->new };
check_init { Wx::AcceleratorEntry->new( 0, 1, 1 ) };
check_init { Wx::AcceleratorTable->new };
check_init { Wx::PlValidator->new };

if( Wx::wxVERSION > 2.009002 ) {
    check_init { Wx::RichToolTip->new('Hello', 'Goodbye') } ;
}

# Wx::Overlay / Wx::DCOverlay thread tests
# creation / destruction order is important
my( $overlay1, $overlay2, $checkdc1, $checkdc2, $dcoverlay1, $dcoverlay2 );
if( Wx::wxVERSION >= 2.008 ) {
    $overlay1 = Wx::Overlay->new;
    $overlay2 = Wx::Overlay->new;
    $checkdc1 = Wx::ClientDC->new( $frame );
    $checkdc2 = Wx::ClientDC->new( $frame );
    $dcoverlay1 =  Wx::DCOverlay->new($overlay1,  $checkdc1);
    $dcoverlay2 =  Wx::DCOverlay->new($overlay2,  $checkdc2);
}
undef $dcoverlay1;
undef $checkdc1;
undef $overlay1;

# check the ref hash is safe!
undef $color2;
undef $pen2;
undef $imagelist2;
undef $bi2;
undef $tid2;
undef $tlid2 if $testtreelist;
undef $tlccomp if $testtreelist;
check_undef;
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
