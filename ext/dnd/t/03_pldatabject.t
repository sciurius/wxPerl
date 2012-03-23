#!/usr/bin/perl -w

use strict;
use Wx qw(wxTheClipboard);
use Wx::DND;
use lib '../../t';
use Tests_Helper qw(in_frame);
use Test::More;
BEGIN {
    if( !Wx::wxMAC ) {
        plan 'tests' => 9;
    } else {
        plan 'tests' => 11;
    }
}

my $FORMAT = 'Wx::Perl::MyCustomFormat';
my $silent = 1;

in_frame(
    sub {
        my $self = shift;
        my $complex = { x => [ qw(a b c), { 'c' => 'd' } ] };
        my $copied = MyDataObject->new( $complex );

        wxTheClipboard->Open;
        wxTheClipboard->Clear;

        ok( !wxTheClipboard->IsSupported( Wx::DataFormat->newUser( $FORMAT ) ),
            "clipboard empty" );

        $silent = 0;

        ok( wxTheClipboard->SetData( $copied ), "copying succeeds" );

        undef $copied;
    
        my $pasted = MyDataObject->new;

        ok( wxTheClipboard->IsSupported( Wx::DataFormat->newUser( $FORMAT ) ),
            "format supported" );

# intermittent non-repeatable failure on MSW and GTK
# On GTK I see when running tests on a VM accessed by
# VNC that doesn't have the focus on the client machine.
# I had assumed this was a GTK +  Visual Box  + VNC
# issue - but I recently have seen this on MSW box (no
# VNC present, not VM). Can't repeat the problem on MSW.
# What to do? The 'undef copied' above looks suspicious
# but all the code behind it looks correct to me re ref
# counting the Perl SV and not destroying the C++ data.

TODO: {
        local $TODO = 'intermittent failure to GetData on wxMSW and wxGTK';    
        ok( wxTheClipboard->GetData( $pasted ), "pasting succeeds" );
}
        isnt( $pasted->GetPerlData, $complex, "Check that identity is not the same" );
TODO: {
        local $TODO = 'intermittent failure to GetPerlData on wxMSW and wxGTK';    
        is_deeply( $pasted->GetPerlData, $complex, "Correctly copied" );
        wxTheClipboard->Close;
}
    } );

package MyDataObject;

use strict;
use base qw(Wx::PlDataObjectSimple);
use Storable;
use Test::More;

sub new {
    my( $class, $data ) = @_;
    my $self = $class->SUPER::new( Wx::DataFormat->newUser( $FORMAT ) );

    $self->{data} = $data;

    return $self;
}

sub SetData {
    my( $self, $serialized ) = @_;

    $self->{data} = Storable::thaw $serialized;
    ok( 1, "SetData called" ) unless $silent;

    return 1;
}

sub GetDataHere {
    my( $self ) = @_;

    ok( 1, "GetDataHere called" ) unless $silent;

    return Storable::freeze $self->{data};
}

sub GetDataSize {
    my( $self ) = @_;

    ok( 1, "GetDataSize called" ) unless $silent;

    return length Storable::freeze $self->{data};
}

sub GetPerlData { $_[0]->{data} }

1;
