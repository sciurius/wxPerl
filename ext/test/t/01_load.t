#!/usr/bin/perl -w

BEGIN { print "1..1\n"; }

use strict;
use Wx;
use Wx::PerlTest;

package MyAbstractNonObject;
use base qw( Wx::PlPerlTestAbstractNonObject );

sub new { shift->SUPER::new( @_ ) }

package MyNonObject;
use base qw( Wx::PlPerlTestNonObject );

sub new { shift->SUPER::new( @_ ) }

package MyAbstractObject;
use base qw( Wx::PlPerlTestAbstractObject );

sub new { shift->SUPER::new( @_ ) }

package main;

    my $anonobj =  MyAbstractNonObject->new;
    my $aobj    =  MyAbstractObject->new;
    my $nonobj  =  MyNonObject->new;
    my $obj     =  Wx::PerlTestObject->new;

print "ok\n";

# Local variables: #
# mode: cperl #
# End: #

