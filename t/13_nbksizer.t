#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';
use Tests_Helper qw(in_frame);
use Test::More 'tests' => 3;

in_frame(
    sub {
        my $self = shift;
        my $nbk = Wx::Notebook->new( $self, -1 );
        my $szr = Wx::NotebookSizer->new( $nbk );
        isa_ok( $szr, 'Wx::NotebookSizer' );

        $self->SetSizer( $szr );
        ok( 1, 'Got there' );
        $self->Layout;
        ok( 1, 'Got there too' );
    } );
