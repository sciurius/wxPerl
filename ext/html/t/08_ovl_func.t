#!/usr/bin/perl -w

# test that overload dispatch works for
# specific functions

use strict;
use Wx;
use Wx::Html;
use lib '../../t';
use Test::More 'tests' => 3;
use Tests_Helper qw(test_app :overload);

my $nolog = Wx::LogNull->new;

test_app( sub {
my $frame = Wx::Frame->new( undef, -1, 'a' );
my $slb = Wx::SimpleHtmlListBox->new( $frame, -1, [ -1, -1 ], [ -1, -1 ], [] );

test_override { $slb->Append( [ 'a', 'b', 'c' ] ) }
              'Wx::SimpleHtmlListBox::AppendStrings';
test_override { $slb->Append( 'a', \1 ) }
              'Wx::SimpleHtmlListBox::AppendData';
test_override { $slb->Append( 'a' ) }
              'Wx::SimpleHtmlListBox::AppendString';
} );
