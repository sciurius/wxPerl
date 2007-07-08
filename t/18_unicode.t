#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';
use Tests_Helper qw(in_frame);
use Test::More 'tests' => 8;
use encoding qw(iso-8859-1);
use Encode qw(is_utf8);

my $ascii   = 'Abcde';
my $ascii2  = 'XXX';
my $latin1  = 'Àbcdë';
my $unicode = "\x{1234}";

utf8::downgrade( $latin1 ); # safe beacuse it's latin1

in_frame(
    sub {
        my $self = shift;

        my $label = Wx::StaticText->new( $self, -1, $ascii );
        is( $label->GetLabel, $ascii );

        $label->SetLabel( $ascii2 );
        is( $label->GetLabel, $ascii2 );

        SKIP: {
            skip "Unicode support needed for the tests", 6
                unless Wx::wxUNICODE;

            $label->SetLabel( $latin1 );
            is( $label->GetLabel, $latin1 );

            ok( !is_utf8( $latin1 ) );
            ok( is_utf8( $label->GetLabel ) );

            skip "wrongly asserts under 2.5.x", 3
                if Wx::wxVERSION < 2.006;

            $label->SetLabel( $unicode );
            is( $label->GetLabel, $unicode );

            ok( is_utf8( $unicode ) );
            ok( is_utf8( $label->GetLabel ) );
        }
    } );
