#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;
use Wx::Html;
use Wx::Print;

my $app = Wx::App->new( sub { 1 } );
my $easyprint = Wx::HtmlEasyPrinting->new;
my $easyprint2 = Wx::HtmlEasyPrinting->new;
my $htmldcrenderer = Wx::HtmlDCRenderer->new;
my $htmldcrenderer2 = Wx::HtmlDCRenderer->new;
my $htmlprintout = Wx::HtmlPrintout->new;
my $htmlprintout2 = Wx::HtmlPrintout->new;

undef $easyprint2;
undef $htmldcrenderer2;
undef $htmlprintout2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
