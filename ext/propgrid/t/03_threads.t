#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !defined(&Wx::wxPG_ATTR_AUTOCOMPLETE), 'Test::More' => skip_all => 'No PropertyGrid Support';
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use if Wx::wxMOTIF, 'Test::More' => skip_all => 'Hangs under Motif';
use Test::More tests => 4;
use Wx::PropertyGrid;

#// Classes
#// wxPGCell
#// wxPGChoices
#// wxPGChoicesData
#// wxPGChoiceEntry
#// wxPGValidationInfo
#// wxPGCellRenderer
#// wxPlPGCellRenderer
#// wxPGEditor
#// wxPlPGEditor
#// wxPGEditorDialogAdapter
#// wxPlPGEditorDialogAdapter
#// wxPGMultiButton
#// wxPGWindowList
#// wxPropertyGridIteratorBase
#// wxPropertyGridIterator
#// wxPGVIterator
#// wxPGProperty
#   wxPlPGProperty
#// wxPGPropArgCls ( wxPGPropArg )
#// wxPropertyGridHitTestResult
#// wxPropertyGrid
#   wxPlPropertyGrid
#// wxPropertyGridPage
#   wxPlPropertyGridPage
#// wxPropertyGridEvent
#// wxPropertyGridManager
#   wxPlPropertyGridManager
#   wxPropertyGridPage

package MyPGGrid;
use base qw( Wx::PlPropertyGrid );
sub new { shift->SUPER::new(@_) }

package MyPGEdit;
use base qw( Wx::PlPGEditor );
sub new { shift->SUPER::new(@_) }

package MyPGAdapt;
use base qw( Wx::PlPGEditorDialogAdapter );
sub new { shift->SUPER::new(@_) }

package main;

my $app = Wx::App->new( sub { 1 } );

my $frame = Wx::Frame->new(undef, -1, 'Test Frame');
my $propgrid = MyPGGrid->new($frame, -1);

my $cell1 = Wx::PGCell->new;
my $cell2 = Wx::PGCell->new;
my $pgvi1 = Wx::PGValidationInfo->new;
my $pgvi2 = Wx::PGValidationInfo->new;
my $choice1 = Wx::PGChoices->new;
my $choice2 = Wx::PGChoices->new;
my $choiced1 = Wx::PGChoicesData->new;
my $choiced2 = Wx::PGChoicesData->new;
my $choicee1 = Wx::PGChoiceEntry->new;
my $choicee2 = Wx::PGChoiceEntry->new;
my $pgrend1 = Wx::PlPGCellRenderer->new;
my $pgrend2 = Wx::PlPGCellRenderer->new;
my $pgwlist1  = Wx::PGWindowList->new;
my $pgwlist2  = Wx::PGWindowList->new;
my $pgmbut1  = Wx::PGMultiButton->new( $propgrid, Wx::Size->new(10,10) );
my $pgmbut2  = Wx::PGMultiButton->new($propgrid, Wx::Size->new(10,10));

my $pgedit1 = MyPGEdit->new;
my $pgedit2 = MyPGEdit->new;
my $pgdlga1  = MyPGAdapt->new;
my $pgdlga2  = MyPGAdapt->new;

my $plpgp1 = Wx::PlPGProperty->new;
my $plpgp2 = Wx::PlPGProperty->new;

my $hittest1 = Wx::PropertyGridHitTestResult->new();
my $hittest2 = Wx::PropertyGridHitTestResult->new();

my $manager1 = Wx::PlPropertyGridManager->new;
my $manager2 = Wx::PlPropertyGridManager->new;

my $pgpage1 = Wx::PlPropertyGridPage->new;
my $pgpage2 = Wx::PlPropertyGridPage->new;

my $pgviter1 = Wx::PGVIterator->new;
my $pgviter2 = Wx::PGVIterator->new;

undef $plpgp2;
undef $cell2;
undef $choice2;
undef $choiced2;
undef $choicee2;
undef $pgvi2;
undef $pgrend2;
undef $pgedit2;
undef $pgdlga2;
undef $pgmbut2;
undef $pgwlist2;

undef $hittest2;
undef $manager2;
undef $pgpage2;
undef $pgviter2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );


END { ok( 1, 'At END' ) };
