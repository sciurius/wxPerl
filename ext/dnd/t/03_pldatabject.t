#!/usr/bin/perl -w

use strict;
use Wx qw(wxTheClipboard);
use Wx::DND;
use lib '../../t';
use Tests_Helper qw(in_frame);
use Test::More 'tests' => 9;

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

        ok( wxTheClipboard->SetData( $copied ), "copying succeeds" );

        undef $copied;

        my $pasted = MyDataObject->new;

        $silent = 0;

        ok( wxTheClipboard->IsSupported( Wx::DataFormat->newUser( $FORMAT ) ),
            "format supported" );
        ok( wxTheClipboard->GetData( $pasted ), "pasting succeeds" );
        isnt( $pasted->GetPerlData, $complex, "Check that identity is not the same" );

        is_deeply( $pasted->GetPerlData, $complex, "Correctly copied" );

        wxTheClipboard->Close;
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
