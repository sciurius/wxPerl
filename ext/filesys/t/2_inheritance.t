#!/usr/bin/perl -w

use strict;
use Wx;
use lib "../../build";
use Tests_Helper qw(:inheritance);

BEGIN { test_inheritance_start() }
use Wx::FS;
test_inheritance_end();

exit 0;

# Local variables: #
# mode: cperl #
# End: #
