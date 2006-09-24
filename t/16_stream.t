#!/usr/bin/perl -w

use strict;
use Wx qw(wxBITMAP_TYPE_ICO);
use lib './t';
use Test::More 'tests' => 6;
use Fatal qw(open);

my $app = Wx::SimpleApp->new;
Wx::InitAllImageHandlers;

sub _slurp {
    local $/;
    open my $fh, '< :raw', $_[0];
    return <$fh>;
}

# plain Perl handle (file)
{
    open my $fh, '< :raw', 'wxpl.ico';
    my $img = Wx::Image->new( $fh, wxBITMAP_TYPE_ICO );
    ok( $img->Ok );
    is( $img->GetWidth, 32 );
}

# in-memory file (uses PerlIO, hasn't a filehandle
SKIP: {
    skip 'Perl 5.8 required', 2 if $] < 5.008;

    my $data = _slurp( 'wxpl.ico' );
    open my $fh, '<', \$data;
    my $img = Wx::Image->new( $fh, wxBITMAP_TYPE_ICO );
    ok( $img->Ok );
    is( $img->GetWidth, 32 );
}

# Tied filehandle
SKIP: {
    eval { require IO::String };
    skip 'IO::String required', 2 if $@;

    my $data = _slurp( 'wxpl.ico' );
    my $fh = IO::String->new( $data );
    my $img = Wx::Image->new( $fh, wxBITMAP_TYPE_ICO );
    ok( $img->Ok );
    is( $img->GetWidth, 32 );
}
