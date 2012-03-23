#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::_wx_optmod_propgrid(), 'Test::More' => skip_all => 'No PropertyGrid Support';
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use if Wx::wxMOTIF, 'Test::More' => skip_all => 'Hangs under Motif';
use Test::More tests => 4;
use Wx::PropertyGrid;
use Wx::DateTime;

package main;

my $app = Wx::App->new( sub { 1 } );
my $frame = Wx::Frame->new(undef, -1, 'Test Frame');

# setup prop grid to test Property and Editor deletion
my $manager = Wx::PropertyGridManager->new($frame, -1);
my $propgrid = $manager->GetGrid;
my $page = $manager->AddPage('Test Properties');

my @keeps;
my @undef;

push @keeps, $page->Append(Wx::StringProperty->new('Test 1','Test 1', 'Hello'));
push @undef, $page->Append(Wx::StringProperty->new('Test 2','Test 2', 'Hello'));
push @keeps, Wx::StringProperty->new('Test 3','Test 3', 'Hello');
push @undef, Wx::StringProperty->new('Test 4','Test 4', 'Hello');

push @keeps, $page->Append(Wx::LongStringProperty->new('Test 5','Test 5', 'Hello'));
push @undef, $page->Append(Wx::LongStringProperty->new('Test 6','Test 6', 'Hello'));
push @keeps, Wx::LongStringProperty->new('Test 7','Test 7', 'X1');
push @undef, Wx::LongStringProperty->new('Test 8','Test 8', 'X2');

push @keeps, $page->Append(Wx::DirProperty->new('Test 9','X3 9', ''));
push @undef, $page->Append(Wx::DirProperty->new('Test 10','X4 10', ''));
push @keeps, Wx::DirProperty->new('Test 11','X5 11', '');
push @undef, Wx::DirProperty->new('Test 12','X6 12', '');

push @keeps, $page->Append(Wx::FileProperty->new('Test 13','X7 9', ''));
push @undef, $page->Append(Wx::FileProperty->new('Test 14','X8 10', ''));
push @keeps, Wx::FileProperty->new('Test 15','X9 11', '');
push @undef, Wx::FileProperty->new('Test 16','A1 12', '');

push @keeps, $page->Append(Wx::ImageFileProperty->new('Test 17','A2 9', ''));
push @undef, $page->Append(Wx::ImageFileProperty->new('Test 18','A3 10', ''));
push @keeps, Wx::ImageFileProperty->new('Test 19','A4 11', '');
push @undef, Wx::ImageFileProperty->new('Test 20','A5 12', '');

push @keeps, $page->Append(Wx::PropertyCategory->new('Test 21'));
push @undef, $page->Append(Wx::PropertyCategory->new('Test 22'));
push @keeps, Wx::PropertyCategory->new('A6 23');
push @undef, Wx::PropertyCategory->new('A7 24');

push @keeps, $page->Append(Wx::FloatProperty->new('Test 25','A8 9', '0.098'));
push @undef, $page->Append(Wx::FloatProperty->new('Test 26','A9 10', '0.098'));
push @keeps, Wx::FloatProperty->new('Test 27','A10 11', '0.098');
push @undef, Wx::FloatProperty->new('Test 28','A11 12', '0.098');

push @keeps, $page->Append(Wx::IntProperty->new('B1 29','B1 9', 1));
push @undef, $page->Append(Wx::IntProperty->new('B2 30','B2 10', 1));
push @keeps, Wx::IntProperty->new('Test 31','B3 11', 1);
push @undef, Wx::IntProperty->new('Test 32','B4 12', 1);

push @keeps, $page->Append(Wx::UIntProperty->new('Test 33','B5 9', 1));
push @undef, $page->Append(Wx::UIntProperty->new('Test 34','B6 10', 1));
push @keeps, Wx::UIntProperty->new('Test 35','Test 11', 1);
push @undef, Wx::UIntProperty->new('Test 36','Test 12', 1);

push @keeps, $page->Append(Wx::BoolProperty->new('Test 33','B7 9', 1));
push @undef, $page->Append(Wx::BoolProperty->new('Test 34','B8 10', 1));
push @keeps, Wx::BoolProperty->new('Test 35','B9 11', 1);
push @undef, Wx::BoolProperty->new('Test 36','C1 12', 1);

push @keeps, $page->Append( Wx::EnumProperty->new('T1', 'C2',[ 'A','B'],[1,2],2));
push @undef, $page->Append( Wx::EnumProperty->new('T2', 'C3',[ 'A','B'],[1,2],2));
push @keeps, Wx::EnumProperty->new('T3', 'C4',[ 'A','B'],[1,2],2);
push @undef, Wx::EnumProperty->new('T4', 'C5',[ 'A','B'],[1,2],2);

{
    my $ch1 = Wx::PGChoices->new();
    $ch1->Add("Choice 1");
    $ch1->Add("Choice 2");
    my $ch2 = Wx::PGChoices->new();
    $ch2->Add("Choice 1");
    $ch2->Add("Choice 2");
    my $ch3 = Wx::PGChoices->new();
    $ch3->Add("Choice 1");
    $ch3->Add("Choice 2");
    my $ch4 = Wx::PGChoices->new();
    $ch4->Add("Choice 1");
    $ch4->Add("Choice 2");
    my $ch5 = Wx::PGChoices->new();
    $ch5->Add("Choice 1");
    $ch5->Add("Choice 2");
    my $ch6 = Wx::PGChoices->new();
    $ch6->Add("Choice 1");
    $ch6->Add("Choice 2");
    push @keeps, $page->Append( Wx::EditEnumProperty->new('E1', 'C6', $ch1, 'none' ));
    push @undef, $page->Append( Wx::EditEnumProperty->new('E2', 'C7', $ch2, 'none' ));
    push @keeps, Wx::EditEnumProperty->new('E3', 'C8', $ch3, 'none' );
    push @undef, Wx::EditEnumProperty->new('E4', 'C9', $ch4, 'none' );
    
    push @keeps, ( $ch2, $ch4, $ch6  );
    push @undef, ( $ch1, $ch3, $ch5 );
}

push @keeps, $page->Append( Wx::FlagsProperty->new('F1', 'D1',['F1','F2'],[1,2],1));
push @undef, $page->Append( Wx::FlagsProperty->new('F2', 'D2',['F1','F2'],[1,2],1));
push @keeps, Wx::FlagsProperty->new('F1', 'D3',['F1','F2'],[1,2],1);
push @undef, Wx::FlagsProperty->new('F2', 'D4',['F1','F2'],[1,2],1);

push @keeps, $page->Append(Wx::CursorProperty->new('D5','D6') );
push @undef, $page->Append(Wx::CursorProperty->new('D6','D7') );
push @keeps, Wx::CursorProperty->new('D7','D8');
push @undef, Wx::CursorProperty->new('D8','D5');

push @keeps, $page->Append(Wx::ArrayStringProperty->new('G1','G1',['S1','S2'] ) );
push @undef, $page->Append(Wx::ArrayStringProperty->new('G2','G2',['S1','S2'] ) );
push @keeps, Wx::ArrayStringProperty->new('G3','G3',['S1','S2'] );
push @undef, Wx::ArrayStringProperty->new('G4','G4',['S1','S2'] );

push @keeps, $page->Append(Wx::MultiChoiceProperty->new('G5','G5',[qw( A B C)], [qw(B C)] ) );
push @undef, $page->Append(Wx::MultiChoiceProperty->new('G6','G6',[qw( A B C)], [qw(B C)] ) );
push @keeps, Wx::MultiChoiceProperty->new('G7','G7',[qw( A B C)], [qw(B C)] ) ;
push @undef, Wx::MultiChoiceProperty->new('G8','G8',[qw( A B C)], [qw(B C)] ) ;

push @keeps, $page->Append(Wx::ColourProperty->new('H1','H1', Wx::Colour->new(1,1,1)) );
push @undef, $page->Append(Wx::ColourProperty->new('H2','H2', Wx::Colour->new(1,1,1)) );
push @keeps, Wx::ColourProperty->new('H3','H3', Wx::Colour->new(1,1,1)) ;
push @undef, Wx::ColourProperty->new('H4','H4', Wx::Colour->new(1,1,1)) ;

push @keeps, $page->Append(Wx::SystemColourProperty->new('H5','H5',
            Wx::ColourPropertyValue->new(wxSYS_COLOUR_MENU)) );
push @undef, $page->Append(Wx::SystemColourProperty->new('H6','H6',
            Wx::ColourPropertyValue->new(wxSYS_COLOUR_MENU)) );
push @keeps, Wx::SystemColourProperty->new('H7','H7',
            Wx::ColourPropertyValue->new(0xFF6633)) ;
push @undef, Wx::SystemColourProperty->new('H8','H8',
             Wx::ColourPropertyValue->new(wxSYS_COLOUR_MENU)) ;

push @keeps, $page->Append( Wx::FontProperty->new('J1', 'J1', wxNullFont ) );
push @undef, $page->Append( Wx::FontProperty->new('J2', 'J2', wxNullFont ) );
push @keeps, $page->Append( Wx::FontProperty->new('J3', 'J3', wxNullFont ) );
push @undef, $page->Append( Wx::FontProperty->new('J4', 'J4', wxNullFont ) );

push @keeps, $page->Append( Wx::DateProperty->new('J5', 'J5', Wx::DateTime::Now()));
push @undef, $page->Append( Wx::DateProperty->new('J6', 'J6', Wx::DateTime::Now()));
push @keeps, Wx::DateProperty->new('J7', 'J7', Wx::DateTime::Now());
push @undef, Wx::DateProperty->new('J8', 'J8', Wx::DateTime::Now());

for my $ename ( qw( TextCtrl Choice ComboBox TextCtrlAndButton
                 CheckBox ChoiceAndButton SpinCtrl DatePickerCtrl ) ) {
      
      my $classname = qq(Wx::PG${ename}Editor);
      my $kpa = $page->Append(Wx::StringProperty->new($ename, $ename, ''));
      $page->SetPropertyEditor($kpa, $ename);
      # editors from grid
      push @keeps, $page->GetPropertyEditor($kpa);
      push @undef, $page->GetPropertyEditor($kpa);
      # editors created
      # can't create a DatePickerCtrl
      next if $ename eq 'DatePickerCtrl';
      push @keeps,$classname->new();
      push @undef,$classname->new();
}

while ( my $prop = pop( @undef ) ) {
      undef $prop;
}
undef @undef;

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
my $pgwlist1  = Wx::PGWindowList->new;
my $pgwlist2  = Wx::PGWindowList->new;
my $pgmbut1  = Wx::PGMultiButton->new( $propgrid, Wx::Size->new(10,10) );
my $pgmbut2  = Wx::PGMultiButton->new($propgrid, Wx::Size->new(10,10));

my $pgviter1 = Wx::PGVIterator->new;
my $pgviter2 = Wx::PGVIterator->new;

undef $cell2;
undef $choice2;
undef $choiced2;
undef $choicee2;
undef $pgvi2;
undef $pgmbut2;
undef $pgwlist2;

undef $pgviter2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );


END { ok( 1, 'At END' ) };
