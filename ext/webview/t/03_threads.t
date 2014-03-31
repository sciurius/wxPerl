#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::_wx_optmod_webview(), 'Test::More' => skip_all => 'No WebView Support';
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';

use Test::More tests => 4;
use Wx::WebView;

my $app = Wx::App->new( sub { 1 } );

my $frame = Wx::Frame->new(undef, -1, 'Test Frame');

my $wcontrol  = Wx::WebView::NewDefault();
my $wcontrol2 = Wx::WebView::New($frame, -1);

my $march1 = Wx::WebViewArchiveHandler->new('zip');
my $march2 = Wx::WebViewArchiveHandler->new('zip');

my $item1  = Wx::WebViewHistoryItem->new('someurl', 'sometitle');
my $item2  = Wx::WebViewHistoryItem->new('someurl', 'sometitle');

$wcontrol2->Destroy;
undef $wcontrol2;
undef $march2;
undef $item2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );


END { ok( 1, 'At END' ) };
