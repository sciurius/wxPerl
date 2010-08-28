#!/usr/bin/perl -w

# test that overload dispatch works for
# specific functions

use strict;
use Wx;
use Wx::DataView;
use lib '../../t';
use Test::More 'tests' => 12;
use Tests_Helper qw(test_app :overload);

my $nolog = Wx::LogNull->new;

{
    package TestModel;

    use base qw(Wx::PlDataViewIndexListModel);

    sub GetColumnCount { 1 }
    sub GetColumnType { 'wxString' }
}

test_app( sub {
my $frame = Wx::Frame->new( undef, -1, 'a' );
my $bmpok = Wx::Bitmap->new( '../../wxpl.ico', Wx::wxBITMAP_TYPE_ICO() );
my $imgok = Wx::Image->new( '../../wxpl.ico', Wx::wxBITMAP_TYPE_ICO() );
my $icook = Wx::GetWxPerlIcon();

my $model = TestModel->new;
my $dv = Wx::DataViewCtrl->new( $frame );

$dv->AssociateModel( $model );

test_override { $dv->AppendBitmapColumn( 'a', 0 ) }
              'Wx::DataViewCtrl::AppendBitmapColumnLabel';
test_override { $dv->AppendBitmapColumn( $bmpok, 0 ) }
              'Wx::DataViewCtrl::AppendBitmapColumnBitmap';

test_override { $dv->AppendDateColumn( 'a', 0 ) }
              'Wx::DataViewCtrl::AppendDateColumnLabel';
test_override { $dv->AppendDateColumn( $bmpok, 0 ) }
              'Wx::DataViewCtrl::AppendDateColumnBitmap';

test_override { $dv->AppendProgressColumn( 'a', 0 ) }
              'Wx::DataViewCtrl::AppendProgressColumnLabel';
test_override { $dv->AppendProgressColumn( $bmpok, 0 ) }
              'Wx::DataViewCtrl::AppendProgressColumnBitmap';

test_override { $dv->AppendIconTextColumn( 'a', 0 ) }
              'Wx::DataViewCtrl::AppendIconTextColumnLabel';
test_override { $dv->AppendIconTextColumn( $bmpok, 0 ) }
              'Wx::DataViewCtrl::AppendIconTextColumnBitmap';

test_override { $dv->AppendTextColumn( 'a', 0 ) }
              'Wx::DataViewCtrl::AppendTextColumnLabel';
test_override { $dv->AppendTextColumn( $bmpok, 0 ) }
              'Wx::DataViewCtrl::AppendTextColumnBitmap';

test_override { $dv->AppendToggleColumn( 'a', 0 ) }
              'Wx::DataViewCtrl::AppendToggleColumnLabel';
test_override { $dv->AppendToggleColumn( $bmpok, 0 ) }
              'Wx::DataViewCtrl::AppendToggleColumnBitmap';
} );
