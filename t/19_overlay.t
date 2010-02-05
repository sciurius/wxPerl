#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';
use Tests_Helper qw(in_frame);
use Test::More 'tests' => 1;

# test will crash if creation / destruction does not happen as
# we expect

sub run_overlay_tests {
    my $self = shift;
    # Wx::Overlay real usage test
    $self->{wx_overlay} = Wx::Overlay->new;
    run_mouse_captured_drawing($self);
    run_mouse_captured_drawing($self);
    run_mouse_release($self);
    ok(1, 'Test completed');
}

sub run_mouse_captured_drawing {
    my $self = shift;
    my $dc = Wx::ClientDC->new( $self );
    my $olay = Wx::DCOverlay->new($self->{wx_overlay}, $dc);
    $dc->DrawLine(1,1,10,10);
}


sub run_mouse_release {
    my $self = shift;
    {
        # dc scope MUST be narrower than Reset call to overlay
        my $dc = Wx::ClientDC->new( $self );
        my $olay = Wx::DCOverlay->new($self->{wx_overlay}, $dc);
        $olay->Clear;
    }
    $self->{wx_overlay}->Reset;
}

in_frame(\&run_overlay_tests);

