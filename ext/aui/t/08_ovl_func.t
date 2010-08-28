#!/usr/bin/perl -w

# test that overload dispatch works for
# specific functions

use strict;
use Wx;
use Wx::AUI;
use lib '../../t';
use Test::More 'tests' => 15;
use Tests_Helper qw(test_app :overload);
use Fatal qw(open);

my $nolog = Wx::LogNull->new;

test_app( sub {
my $frame = Wx::Frame->new( undef, -1, 'a' );
my $aui = Wx::AuiManager->new( $frame );

my $win1 = Wx::Window->new( $frame, -1 );
my $win2 = Wx::Window->new( $frame, -1 );
my $win3 = Wx::Window->new( $frame, -1 );

test_override { $aui->AddPane( $win1, Wx::AuiPaneInfo->new ) }
              'Wx::AuiManager::AddPaneDefault';
test_override { $aui->AddPane( $win2, Wx::AuiPaneInfo->new, [ 0, 0 ] ) }
              'Wx::AuiManager::AddPanePoint';
test_override { $aui->AddPane( $win3, Wx::wxLEFT(), 'Title' ) }
              'Wx::AuiManager::AddPaneDirection';

test_override { $aui->GetPane( $win1 ) }
              'Wx::AuiManager::GetPaneWindow';
test_override { $aui->GetPane( 'Title' ) }
              'Wx::AuiManager::GetPaneString';

my $pi = Wx::AuiPaneInfo->new;

test_override { $pi->BestSize( [ 100, 100 ] ) }
              'Wx::AuiPaneInfo::BestSizeSize';
test_override { $pi->BestSize( 100, 100 ) }
              'Wx::AuiPaneInfo::BestSizeWH';

test_override { $pi->MaxSize( [ 100, 100 ] ) }
              'Wx::AuiPaneInfo::MaxSizeSize';
test_override { $pi->MaxSize( 100, 100 ) }
              'Wx::AuiPaneInfo::MaxSizeWH';

test_override { $pi->MinSize( [ 100, 100 ] ) }
              'Wx::AuiPaneInfo::MinSizeSize';
test_override { $pi->MinSize( 100, 100 ) }
              'Wx::AuiPaneInfo::MinSizeWH';

test_override { $pi->FloatingSize( [ 100, 100 ] ) }
              'Wx::AuiPaneInfo::FloatingSizeSize';
test_override { $pi->FloatingSize( 100, 100 ) }
              'Wx::AuiPaneInfo::FloatingSizeWH';

test_override { $pi->FloatingPosition( [ 100, 100 ] ) }
              'Wx::AuiPaneInfo::FloatingPositionPoint';
test_override { $pi->FloatingPosition( 100, 100 ) }
              'Wx::AuiPaneInfo::FloatingPositionXY';
} );
