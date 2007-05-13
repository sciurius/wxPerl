#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';

use Tests_Helper qw(test_app);
use Test::More 'tests' => 110;

my $undef = undef;

my $app = test_app( sub { 1 } );

for my $i ( [ \&Wx::_match, 'match' ],
            [ \&Wx::_xsmatch, 'xsmatch' ] ) {
  my( $m, $t ) = @$i;
  local *xx = $m;

  # some simple cases
  ok(  xx( [ [] ], $Wx::_arr ), "$t: match an array" );
  ok(  xx( [ [], 1 ], $Wx::_arr ),
      "$t: more arguments than in prototype" );
  ok( !xx( [ '' ], $Wx::_arr ), "$t: wrong arguments" );
  ok(  xx( [ [] ], $Wx::_arr ), "$t: match with required arguments" );
  ok( !xx( [ [], 1 ], $Wx::_arr, 1 ),
      "$t: don't match with more than required" );
  ok(  xx( [ [] ], $Wx::_arr, 1, 1 ),
      "$t: match with required arguments and allow_more" );
  ok(  xx( [ [], 1 ], $Wx::_arr, 1, 1 ),
      "$t: match with more than required and allow_more" );

  # tests for boolean
  ok(  xx( [ [] ], $Wx::_b ), "$t: boolean matches reference" );
  ok(  xx( [ 1 ],  $Wx::_b ), "$t: boolean matches integer" );
  ok(  xx( [ 0 ],  $Wx::_b ), "$t: boolean matches zero" );
  ok(  xx( [ undef ], $Wx::_b ), "$t: boolean matches literal undef" );
  ok(  xx( [ $undef ], $Wx::_b ), "$t: boolean matches undefined variable" );
  ok(  xx( [ 'foo' ], $Wx::_b ), "$t: boolean matches string" );

  # test for string
  ok(  xx( [ [] ], $Wx::_s ), "$t: string matches reference" );
  ok(  xx( [ 1 ],  $Wx::_s ), "$t: string matches integer" );
  ok(  xx( [ 0 ],  $Wx::_s ), "$t: string matches zero" );
  ok(  xx( [ undef ], $Wx::_s ), "$t: string matches literal undef" );
  ok(  xx( [ $undef ], $Wx::_s ), "$t: string matches undefined variable" );
  ok(  xx( [ 'foo' ], $Wx::_s ), "$t: string matches string" );

  # test for number
  ok( !xx( [ [] ], $Wx::_n ), "$t: number does not match reference" );
  ok(  xx( [ 1 ],  $Wx::_n ), "$t: number matches integer" );
  ok(  xx( [ 0 ],  $Wx::_n ), "$t: number matches zero" );
  ok(  xx( [ 1.2 ],  $Wx::_n ), "$t: number matches floating point" );
  ok(  xx( [ 0.0 ],  $Wx::_n ), "$t: number matches floating point zero" );
  ok( !xx( [ undef ], $Wx::_n ), "$t: number does not match literal undef" );
  ok( !xx( [ $undef ], $Wx::_n ),
      "$t: number does not match undefined variable" );
  ok( !xx( [ 'foo' ], $Wx::_n ), "$t: number does not match string" );

  # test Wx::Sizer
  ok( !xx( [ [] ], $Wx::_wszr ),
      "$t: Wx::Sizer does not match reference" );
  ok( !xx( [ 1 ],  $Wx::_wszr ), "$t: Wx::Sizer does not match integer" );
  ok( !xx( [ 0 ],  $Wx::_wszr ), "$t: Wx::Sizer does not match zero" );
  ok(  xx( [ undef ], $Wx::_wszr ), "$t: Wx::Sizer matches literal undef" );
  ok(  xx( [ $undef ], $Wx::_wszr ),
       "$t: Wx::Sizer matches undefined variable" );
  ok( !xx( [ 'foo' ], $Wx::_wszr ), "$t: Wx::Sizer does not match string" );
  ok(  xx( [ Wx::BoxSizer->new( Wx::wxVERTICAL() ) ], $Wx::_wszr ),
       "$t: Wx::Sizer matches Wx::Sizer" );

  # test Wx::Image
  ok( !xx( [ [] ], $Wx::_wimg ),
      "$t: Wx::Image does not match reference" );
  ok( !xx( [ 1 ],  $Wx::_wimg ), "$t: Wx::Image does not match integer" );
  ok( !xx( [ 0 ],  $Wx::_wimg ), "$t: Wx::Image does not match zero" );
  ok(  xx( [ undef ], $Wx::_wimg ), "$t: Wx::Image matches literal undef" );
  ok(  xx( [ $undef ], $Wx::_wimg ),
       "$t: Wx::Image matches undefined variable" );
  ok( !xx( [ 'foo' ], $Wx::_wimg ), "$t: Wx::Image does not match string" );
  ok(  xx( [ Wx::Image->new( 1, 2 ) ], $Wx::_wimg ),
       "$t: Wx::Image matches Wx::Image" );

  # test for Wx::Point/Wx::Size
  ok(  xx( [ [] ], $Wx::_wpoi ),
      "$t: Wx::Point matches ARRAY reference" );
  ok( !xx( [ {} ], $Wx::_wpoi ),
      "$t: Wx::Point does not match other reference" );
  ok( !xx( [ 1 ],  $Wx::_wpoi ), "$t: Wx::Point does not match integer" );
  ok( !xx( [ 0 ],  $Wx::_wpoi ), "$t: Wx::Point does not match zero" );
  ok(  xx( [ $undef ], $Wx::_wpoi ),
      "$t: Wx::Point matches undefined variable" );
  ok( !xx( [ 'foo' ], $Wx::_wpoi ), "$t: Wx::Point does not match string" );
  ok(  xx( [ Wx::Point->new( 1, 1 ) ], $Wx::_wpoi ),
       "$t: Wx::Point matches Wx::Point" );
  ok(  xx( [ Wx::Size->new( 1, 2 ) ], $Wx::_wsiz ),
       "$t: Wx::Size matches Wx::Size" );

  # test for Wx::Input/OutputStream
  ok(  xx( [ [], 1 ], $Wx::_wist_n ),
      "$t: Wx::InputStream matches references" );
  ok(  xx( [ {}, 1 ], $Wx::_wist_n ),
      "$t: Wx::InputStream matches references (again)" );
  ok( !xx( [ 1, 1 ], $Wx::_wist_n ),
      "$t: Wx::InputStream does not match integer" );
  ok( !xx( [ 'foo', 1 ], $Wx::_wist_n ),
      "$t: Wx::InputStream does not match string" );
  ok(  xx( [ undef, 1 ], $Wx::_wist_n ),
      "$t: Wx::InputStream matches undef" );
  ok(  xx( [ *main::bar, 1 ], $Wx::_wist_n ),
      "$t: Wx::InputStream matches typeglobs" );
  *main::bar = *main::bar; # fool warning
}

