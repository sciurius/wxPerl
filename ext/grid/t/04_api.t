#!/usr/bin/perl -w

use Test::More tests => 8;

use strict;
use lib '../../t';
use Tests_Helper qw(in_frame);
use Wx;
use Wx::Grid;

sub test {
    my $self = shift;
    my $grid = Wx::Grid->new( $self, -1 );
    $grid->CreateGrid( 20, 20 );
    my @s;

    $grid->SelectRow( 1 );
    @s = $grid->GetSelectedRows;
    is( scalar( @s ), 1 );
    is_deeply( \@s, [ 1 ] );

    $grid->SelectRow( 2 );
    @s = $grid->GetSelectedRows;
    is( scalar( @s ), 1 );
    is_deeply( \@s, [ 2 ] );

    $grid->SelectRow( 5, 1 );
    @s = $grid->GetSelectedRows;
    is( scalar( @s ), 2 );
    is_deeply( \@s, [ 2, 5 ] );

    $grid->SelectCol( 1 );
    $grid->SelectCol( 2, 1 );
    @s = $grid->GetSelectedCols;
    is( scalar( @s ), 2 );
    is_deeply( \@s, [ 1, 2 ] );
}

in_frame( \&test );

# local variables:
# mode: cperl
# end:
