#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::_wx_optmod_ribbon(), 'Test::More' => skip_all => 'No Ribbon Support';
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use if Wx::wxMOTIF, 'Test::More' => skip_all => 'Hangs under Motif';
use Test::More tests => 8;
use Wx::Ribbon;

package MyDataContainer;
sub new {
    my $class = shift;
    my $self = bless {}, $class;
    $self->{somedata} = $_[0];
    return $self;
}

package main;

my $app = Wx::App->new( sub { 1 } );

my $frame = Wx::Frame->new(undef, -1, 'Test Frame');
my $rcontrol = Wx::RibbonControl->new($frame, -1);
my $rgallery = Wx::RibbonGallery->new($frame, -1);
my $rpanel = Wx::RibbonPanel->new($frame, -1);
my $rbar = Wx::RibbonBar->new($frame, -1);
my $rpage = Wx::RibbonPage->new($rbar, -1);
my $rbbar = Wx::RibbonButtonBar->new($frame, -1);
my $rtbar = Wx::RibbonToolBar->new($frame, -1);

my $artprov1 = $rbar->GetArtProvider->Clone;
my $artprov2 = $rbar->GetArtProvider->Clone;
my $artprov3 = Wx::RibbonDefaultArtProvider->new();
my $artprov4 = Wx::RibbonDefaultArtProvider->new();

my $rgitem1 = $rgallery->Append( Wx::Bitmap->new( 100, 100, -1 ), -1, MyDataContainer->new('Stashed Data 0'));
my $rgitem2 = $rgallery->Append( Wx::Bitmap->new( 100, 100, -1 ), -1, MyDataContainer->new('Stashed Data 1'));

my $cdata1 = $rgallery->GetItemClientData( $rgitem1 );
my $cdata2 = $rgitem2->GetClientData();

my ( $buttonbar, $button,  $buttonbar2, $button2, $buttonbar3, $button3 );

if ( Wx::wxVERSION < 3.000000 ) {
    $buttonbar = Wx::RibbonButtonBar->new($rpanel, -1 );
    $button = $buttonbar->AddButton(-1, "Hello World",
        Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap, wxNullBitmap, wxNullBitmap,
        Wx::wxRIBBON_BUTTON_NORMAL(), "HW Help",
        { data => 'Stashed Data' } );

    $buttonbar2 = Wx::RibbonButtonBar->new($rpanel, -1 );
    $button2 = $buttonbar2->AddButton(-1, "Hello World",
        Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap, wxNullBitmap, wxNullBitmap,
        Wx::wxRIBBON_BUTTON_NORMAL(), "HW Help",
        { data => 'Stashed Data' } );

    $buttonbar3 = Wx::RibbonButtonBar->new($rpanel, -1 );
    $button3 = $buttonbar3->AddButton(-1, "Hello World",
        Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap, wxNullBitmap, wxNullBitmap,
        Wx::wxRIBBON_BUTTON_NORMAL(), "HW Help",
        { data => 'Stashed Data' } );
} else {
    $buttonbar = Wx::RibbonButtonBar->new($rpanel, -1 );
    $button = $buttonbar->AddButton(-1, "Hello World",
        Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap, wxNullBitmap, wxNullBitmap,
        Wx::wxRIBBON_BUTTON_NORMAL(), "HW Help");

    $buttonbar2 = Wx::RibbonButtonBar->new($rpanel, -1 );
    $button2 = $buttonbar2->AddButton(-1, "Hello World",
        Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap, wxNullBitmap, wxNullBitmap,
        Wx::wxRIBBON_BUTTON_NORMAL(), "HW Help");

    $buttonbar3 = Wx::RibbonButtonBar->new($rpanel, -1 );
    $button3 = $buttonbar3->AddButton(-1, "Hello World",
        Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap, wxNullBitmap, wxNullBitmap,
        Wx::wxRIBBON_BUTTON_NORMAL(), "HW Help");
}

my $toolbar = Wx::RibbonToolBar->new($rpanel, 1 );
my $tool = $toolbar->AddTool(-1, Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap,
      "HW Help", Wx::wxRIBBON_BUTTON_NORMAL(), 
      { data => 'Stashed Data' } );

my $toolbar2 = Wx::RibbonToolBar->new($rpanel, 1 );
my $tool2 = $toolbar2->AddTool(-1, Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap,
      "HW Help", Wx::wxRIBBON_BUTTON_NORMAL(), 
      { data => 'Stashed Data' } );

my $toolbar3 = Wx::RibbonToolBar->new($rpanel, 1 );
my $tool3 = $toolbar3->AddTool(-1, Wx::Bitmap->new( 100, 100, -1 ), wxNullBitmap,
      "HW Help", Wx::wxRIBBON_BUTTON_NORMAL(), 
      { data => 'Stashed Data' } );

isa_ok($cdata1, 'MyDataContainer');
is( $cdata1->{somedata}, 'Stashed Data 0' );
isa_ok($cdata2, 'MyDataContainer');
is( $cdata2->{somedata}, 'Stashed Data 1' );

undef $artprov2;
undef $artprov4;
undef $rgitem2;
undef $buttonbar2;
$buttonbar3->Destroy;
undef $buttonbar3;
undef $button2;
undef $button3;
undef $toolbar2;
$toolbar3->Destroy;
undef $toolbar3;
undef $tool2;
undef $tool3;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );


END { ok( 1, 'At END' ) };
