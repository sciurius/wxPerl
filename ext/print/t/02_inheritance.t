#!/usr/bin/perl -w

use strict;
use Wx;
use lib "../../t";
use Test::More 'no_plan';
use Tests_Helper qw(:inheritance);

BEGIN { test_inheritance_start() }
use Wx::Print;
test_inheritance_end();

# Local variables: #
# mode: cperl #
# End: #
