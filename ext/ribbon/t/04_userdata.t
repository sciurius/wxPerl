#!/usr/bin/perl -w

# test for client data handling in various controls

use strict;
use Wx;
use lib '../../t';
use if !Wx::_wx_optmod_ribbon(), 'Test::More' => skip_all => 'No Ribbon Support';
use Tests_Helper qw(in_frame);
use Wx::Event qw(EVT_BUTTON);
use Wx::Ribbon;
use Wx qw( :bitmap );

# Currently asserts cause wxRibbonButtonBar to fault
# in some released wxWidgets versions.
# Switch asserts off for this test
Wx::DisableAssertHandler();

#-------------------------------------------------------------

package MyClass;

sub new {
  my $class = shift;
  my $code = shift;
  die "want a CODE reference" unless ref $code eq 'CODE';
  return bless [ $code ], $class;
}

sub DESTROY { &{$_[0][0]} }

#--------------------------------------------------------------

package MyDataContainer;

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    $self->{somedata} = $_[0];
    return $self;
}

sub get_data { $_[0]->{somedata}; }

#--------------------------------------------------------------

package main;

use Test::More 'tests' => 15;

use strict;
#use base 'Wx::Frame';
use vars '$TODO';

sub cdata($) { MyClass->new( $_[0] ) }

sub tests {
  my $this = shift;

  ############################################################################
  # wxRibbonGallery
  ############################################################################
  
  my $gallery = Wx::RibbonGallery->new( $this, -1 );
  
  my $rgitem3 = $gallery->Append( Wx::Bitmap->new( 100, 100, -1 ), -1, MyDataContainer->new('Stashed Data 0'));
  my $rgitem4 = $gallery->Append( Wx::Bitmap->new( 100, 100, -1 ), -1, MyDataContainer->new('Stashed Data 1'));
   
  is( $gallery->GetItemClientData( $rgitem4 )->get_data, 'Stashed Data 1', "Wx::RibbonGallery::GetItemClientData" );
  is( $rgitem3->GetClientData()->get_data, 'Stashed Data 0', "Wx::RibbonGalleryItem::GetClientData" );
    
  $rgitem3->SetClientData( MyDataContainer->new('Stashed Data 3') );
  is( $gallery->GetItemClientData( $rgitem3 )->get_data, 'Stashed Data 3', "Wx::RibbonGallery::GetItemClientData ( again )" );
  my $ctrldelete =  0;
  my $ctrlitem = $gallery->AppendClientData( Wx::Bitmap->new( 100, 100, -1 ), -1, cdata(sub { $ctrldelete = 1 }) );
  $gallery->Destroy;
  ok( $ctrldelete, 'Wx::RibbonGallery: deleting the gallery deletes the data' );
  
  ############################################################################
  # wxRibbonButtonBar
  ############################################################################
  
  my $bitmap = Wx::Bitmap->new('../../wxpl.xpm', Wx::wxBITMAP_TYPE_XPM() );
  my $ribbonpanel = Wx::RibbonPanel->new($this, -1);
  
  # client data in wxRibbonButtonBar seems not useful
  # unless we hang on to the button references ?
  SKIP: {
    skip 'No ClientData in wxRibbonButtonBar 3.x.x', 3 if Wx::wxVERSION >= 3.000000;
  
    my $buttonbar = Wx::RibbonButtonBar->new($ribbonpanel, 1 );
    
    my $button = $buttonbar->AddButton(-1, "Hello World",
          $bitmap, wxNullBitmap, wxNullBitmap, wxNullBitmap,
          Wx::wxRIBBON_BUTTON_NORMAL(), "HW Help",
          MyDataContainer->new('Stashed Data 4') );
    
    $ctrldelete =  0;
    my $delbutton = $buttonbar->AddButton(-1, "Hello World",
              $bitmap, wxNullBitmap, wxNullBitmap, wxNullBitmap,
              Wx::wxRIBBON_BUTTON_NORMAL(), "HW Help",
              cdata(sub { $ctrldelete = 1 } ) );
      
    is( $button->GetClientData()->get_data, 'Stashed Data 4', "Wx::RibbonButtonBarButtonBase::GetClientData" );
      
    ok( $ctrldelete == 0, 'Wx::RibbonButtonBar: Data not changed before delete' );
    
    $delbutton->SetClientData(undef);
      
    $buttonbar->Destroy;
    
    ok( $ctrldelete, 'Wx::RibbonButtonBar: deleting the ribbonbuttonbar deletes the data' );
  };
  
  ############################################################################
  # wxRibbonToolBar
  ############################################################################

  my $toolbar = Wx::RibbonToolBar->new($ribbonpanel, 1 );
  
  # no client data
  my $toolid0 = $toolbar->AddTool(-1, $bitmap,
      "HW Help", Wx::wxRIBBON_BUTTON_NORMAL())->id;
      
  # check that getting && setting some client data where none exists works
  
  my $firstdata = $toolbar->GetToolClientData( $toolid0 );
  
  ok( !defined($firstdata), "Wx::RibbonToolBar::GetToolClientData undefined"); 
  $toolbar->SetToolClientData( $toolid0, MyDataContainer->new('Stashed Data X') );
  $firstdata = $toolbar->GetToolClientData( $toolid0 );
  is( $firstdata->get_data, 'Stashed Data X', "Wx::RibbonToolBar::GetToolClientData defined"); 
  
  my $toolid1 = $toolbar->AddTool(-1, $bitmap, wxNullBitmap,
      "HW Help", Wx::wxRIBBON_BUTTON_NORMAL(), 
      MyDataContainer->new('Stashed Data 5') )->id;
  
  my $toolid2 = $toolbar->AddTool(-1, $bitmap, wxNullBitmap,
      "HW Help", Wx::wxRIBBON_BUTTON_NORMAL(), 
      MyDataContainer->new('Stashed Data 6') )->id;
  
  my $persistentdata = MyDataContainer->new('Stashed Persistent Data 1');
  
  my $tbarbutton = $toolbar->AddTool(-1, $bitmap, wxNullBitmap,
      "HW Help", Wx::wxRIBBON_BUTTON_NORMAL(), 
      $persistentdata );
  
  $ctrldelete =  0;
  
  my $autoid = $toolbar->AddTool(-1, $bitmap, wxNullBitmap,
      "HW Help", Wx::wxRIBBON_BUTTON_NORMAL(), 
        cdata( sub { $ctrldelete = 1 } ) )->id; ;

  is( $toolbar->GetToolClientData($toolid2)->get_data, 'Stashed Data 6', "Wx::RibbonToolBar::GetToolClientData For Tool 2" );
  is( $toolbar->GetToolClientData($toolid1)->get_data, 'Stashed Data 5', "Wx::RibbonToolBar::GetToolClientData For Tool 1" );
  
  is( $toolbar->GetToolClientData( $tbarbutton->id )->get_data,
     'Stashed Persistent Data 1', "Wx::RibbonToolBar::GetToolClientData For Persistent data" );
  
  ok( $ctrldelete == 0, 'Wx::RibbonToolBar: Data not changed before delete' );
  
  # in wxRibbonToolBar ClientData is untyped void so we must delete the clientdata before we delete the tool
  # our XSUB checks SvOK so pass undef
  
  $toolbar->SetToolClientData( $autoid, undef );
  
  ok( $ctrldelete, 'Wx::RibbonToolBar: setting client data undef deletes the data' );
  $toolbar->Destroy;
  
  # The persistent data should still be in the $datatype
  is( $persistentdata->get_data, 'Stashed Persistent Data 1', "Wx::UserDataO Data Persists" );
  
}

in_frame( \&tests );

# local variables:
# mode: cperl
# end:

