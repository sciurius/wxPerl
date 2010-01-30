#!/usr/bin/perl -w

BEGIN { print "1..2\n"; }

use strict;
use Wx;
use Wx::Html;

print "ok\n";
print Wx::ClassInfo::FindClass( 'wxHtmlCell' ) ? "ok\n" : "not ok\n";

# Local variables: #
# mode: cperl #
# End: #
