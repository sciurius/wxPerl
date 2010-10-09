#!/usr/bin/perl -w

use strict;
use Test::More tests => 2;
use Wx;
use Wx::DateTime;

# Test IsValid
my $valid = Wx::DateTime::Now();
my $invalid = Wx::DateTime->new();

ok($valid->IsValid, 'Testing Valid Object');
ok(!$invalid->IsValid, 'Testing Invalid Object');

# Local variables: #
# mode: cperl #
# End: #

