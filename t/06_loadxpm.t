#!/usr/bin/perl -w

BEGIN { print "1..2\n"; }

use strict;
use Wx;
use lib './t';
use Tests_Helper qw(test_app);

my $data = [ map { m/^"(.*)"/ ? ( $1 ) : () } split /\n/, <<'EOT' ];
/* XPM */
static char * wxpl16_xpm[] = {
"16 16 5 1",
" 	c None",
".	c Gray100",
"X	c Red",
"o	c Yellow",
"O	c Blue",
"                ",
" ...........    ",
" .XXXXXXXXX.    ",
" .XXXXXXXXX.    ",
" .XXXX......... ",
" .XXXX.ooooooo. ",
" .XXXX.ooooooo. ",
" .X........ooo. ",
" ...OOOOOO.ooo. ",
"   .OOOOOO.ooo. ",
"   .OOOOOO.ooo. ",
"   .OOOOOO.ooo. ",
"   ........ooo. ",
"      .ooooooo. ",
"      ......... ",
"                "};
EOT

test_app( sub {
            my $xpm = Wx::Bitmap->newFromXPM( $data );
            print +( $xpm->Ok ? "ok" : "not ok" ), "\n";
            print +( $xpm->GetWidth == 16 ? "ok" : "not ok" ), "\n";
} );

# local variables:
# mode: cperl
# end:
