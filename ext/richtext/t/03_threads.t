#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use if Wx::wxMOTIF, 'Test::More' => skip_all => 'Hangs under Motif';
use Test::More tests => 4;
use Wx::RichText;

my $app = Wx::App->new( sub { 1 } );
my $frame = Wx::Frame->new( undef, -1, 'a' );
my $rtc = Wx::RichTextCtrl->new( $frame );
my $rtb = $rtc->GetBuffer;

my $rtr = Wx::RichTextRange->new;
my $rtr2 = Wx::RichTextRange->new;
my $tae = Wx::TextAttrEx->new;
my $tae2 = Wx::TextAttrEx->new;
my $rta = Wx::RichTextAttr->new;
my $rta2 = Wx::RichTextAttr->new;
my $rtsd = Wx::RichTextParagraphStyleDefinition->new;
my $rtsd2 = Wx::RichTextParagraphStyleDefinition->new;
my $rtss = Wx::RichTextStyleSheet->new;
my $rtss2 = Wx::RichTextStyleSheet->new;
my $rtp = Wx::RichTextPrinting->new;
my $rtp2 = Wx::RichTextPrinting->new;
my $rtpo = Wx::RichTextPrintout->new;
my $rtpo2 = Wx::RichTextPrintout->new;
my $rthfd = Wx::RichTextHeaderFooterData->new;
my $rthfd2 = Wx::RichTextHeaderFooterData->new;

my $rtb1 = Wx::RichTextBuffer->new($rtb);
my $rtb2 = Wx::RichTextBuffer->new($rtb);
my $rtb3 = Wx::RichTextBuffer->new($rtb);
my $rtb4 = Wx::RichTextBuffer->new($rtb);
my $rtb5 = Wx::RichTextBuffer->new($rtb);
my $rtb6 = Wx::RichTextBuffer->new($rtb);

my $rtp3 = Wx::RichTextPrinting->new;
my $rtp4 = Wx::RichTextPrinting->new;

my $rtpo3 = Wx::RichTextPrintout->new;
my $rtpo4 = Wx::RichTextPrintout->new;

$rtp3->SetRichTextBufferPreview($rtb1);
$rtp4->SetRichTextBufferPreview($rtb2);

$rtpo3->SetRichTextBuffer($rtb3);
$rtpo4->SetRichTextBuffer($rtb4);

undef $rtr2;
undef $tae2;
undef $rta2;
undef $rtsd2;
undef $rtss2;
undef $rtp2;
undef $rtpo2;
undef $rthfd2;
undef $rtp4;
undef $rtpo4;
undef $rtb6;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
