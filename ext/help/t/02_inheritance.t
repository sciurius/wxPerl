#!/usr/bin/perl -w

use strict;
use Wx;
use lib "../../build";
use Test::More 'no_plan';
use Tests_Helper qw(:inheritance);

BEGIN { test_inheritance_start() }
use Wx::Help;
test_inheritance_end();

exit 0;

# Local variables: #
# mode: cperl #
# End: #
