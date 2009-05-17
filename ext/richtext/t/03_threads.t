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

undef $rtr2;
undef $tae2;
undef $rta2;
undef $rtsd2;
undef $rtss2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };
