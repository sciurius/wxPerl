#!/usr/bin/perl -w

use strict;
use Wx::PerlTest;
use Test::More 'tests' => 4;

package MyAbstractNonObject;
use base qw( Wx::PlPerlTestAbstractNonObject );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( @_ );
    $self->{storedmsg} = 'Foo Bar';
    return $self;
}

sub DoGetMessage {
    return $_[0]->{storedmsg};
}

package MyNonObject;
use base qw( MyAbstractNonObject );

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( 'My None Object' );
    $self->{storedmsg} = 'Foo Bar Crazy';
    return $self;
}

sub DoGetMessage {
    return $_[0]->SUPER::DoGetMessage();
}


package main;

my $anonobj = MyAbstractNonObject->new;
my $nonobj  = MyNonObject->new;

is( $anonobj->GetMoniker, 'AbstractNonObject', 'Base Moniker Works');
is( $anonobj->GetMessage, 'Foo Bar',  'Custom Message From Hash Object' );
is( $nonobj->GetMoniker, 'My None Object', 'Derived Moniker Works');
is( $nonobj->GetMessage, 'Foo Bar Crazy',  'Derived Non obj' );


# Local variables: #
# mode: cperl #
# End: #

