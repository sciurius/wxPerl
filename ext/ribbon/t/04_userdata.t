#!/usr/bin/perl -w

# test for client data handling in various controls

use strict;
use Wx;
use lib '../../t';
use if !Wx::_wx_optmod_ribbon(), 'Test::More' => skip_all => 'No Ribbon Support';
use Tests_Helper qw(in_frame);
use Wx::Event qw(EVT_BUTTON);
use Wx::Ribbon;

package MyClass;

sub new {
  my $class = shift;
  my $code = shift;
  die "want a CODE reference" unless ref $code eq 'CODE';

  return bless [ $code ], $class;
}

sub DESTROY { &{$_[0][0]} }

package MyDataContainer;
sub new {
    my $class = shift;
    my $self = bless {}, $class;
    $self->{somedata} = $_[0];
    return $self;
}

sub get_data { $_[0]->{somedata}; }

package main;

use Test::More 'tests' => 4;

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
  
  my $rgitem3 = $gallery->AppendClientData( Wx::Bitmap->new( 100, 100, -1 ), -1, MyDataContainer->new('Stashed Data 0'));
  my $rgitem4 = $gallery->AppendClientData( Wx::Bitmap->new( 100, 100, -1 ), -1, MyDataContainer->new('Stashed Data 1'));
   
  is( $gallery->GetItemClientData( $rgitem4 )->get_data, 'Stashed Data 1', "Wx::RibbonGallery::GetItemClientData" );
  is( $rgitem3->GetClientData()->get_data, 'Stashed Data 0', "Wx::RibbonGalleryItem::GetClientData" );
    
  $rgitem3->SetClientData( MyDataContainer->new('Stashed Data 3') );
  is( $gallery->GetItemClientData( $rgitem3 )->get_data, 'Stashed Data 3', "Wx::RibbonGallery::GetItemClientData ( again )" );
  my $ctrldelete =  0;
  my $ctrlitem = $gallery->AppendClientData( Wx::Bitmap->new( 100, 100, -1 ), -1, cdata(sub { $ctrldelete = 1 }) );
  $gallery->Destroy;
  ok( $ctrldelete, 'Wx::RibbonGallery: deleting the gallery deletes the data' );
}

in_frame( \&tests );

# local variables:
# mode: cperl
# end:

