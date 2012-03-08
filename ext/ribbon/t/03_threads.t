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

my $rgitem1 = Wx::RibbonGalleryItem->new();
my $rgitem2 = Wx::RibbonGalleryItem->new();

my $rgitem3 = $rgallery->AppendClientData( Wx::Bitmap->new( 100, 100, -1 ), -1, MyDataContainer->new('Stashed Data 0'));
my $rgitem4 = $rgallery->AppendClientData( Wx::Bitmap->new( 100, 100, -1 ), -1, MyDataContainer->new('Stashed Data 1'));

my $cdata1 = $rgallery->GetItemClientData( $rgitem3 );
my $cdata2 = $rgitem4->GetClientData();

isa_ok($cdata1, 'MyDataContainer');
is( $cdata1->{somedata}, 'Stashed Data 0' );
isa_ok($cdata2, 'MyDataContainer');
is( $cdata2->{somedata}, 'Stashed Data 1' );

undef $artprov2;
undef $rgitem2;
undef $rgitem4;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );


END { ok( 1, 'At END' ) };
