#!/usr/bin/perl -w

use strict;
use Wx;
use lib './t';

use Test::More 'no_plan';
use Tests_Helper qw(:inheritance);

test_inheritance_all();

exit 0;

# Local variables: #
# mode: cperl #
# End: #
