#!/usr/bin/perl -w

use strict;
use Wx;
use Wx::Html;
use lib "../../t";
use Test::More tests => 1;
use Tests_Helper qw(in_frame);

# this test indirectly tests that wxModule initialization works
# in wxPerl submodules
in_frame sub {
    my( $frame ) = @_;
    my $htmlwin = Wx::HtmlWindow->new( $frame );
    $htmlwin->Show;
    $htmlwin->SetSize( 400, 400 );
    $htmlwin->SetPage( "<html><head><title>Title</title></head><body><h1>Test</h1><p>A test</p></body></html>" );

    my $text = $htmlwin->ToText;

    # if tag handlers are correctly initialized, the test will only
    # contain the actual test
    is( $text, "\nTest\nA test" );
};
