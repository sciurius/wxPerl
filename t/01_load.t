#!/usr/bin/perl

use strict;
use Test::More tests => 4;

BEGIN { use_ok 'Wx' }

use Wx 'wxYES';
my $x = wxYES;

ok( 1, "Exported constant" );

SKIP: {
  skip( "Does not work with wxMotif", 2 ) if Wx::wxMOTIF();

  use Wx ( Wx::wxMOTIF() ?
           () : qw(:frame :allclasses wxNO_3D wxTAB_TRAVERSAL) );

  $x = wxTAB_TRAVERSAL();
  $x = wxCAPTION();

  ok( 1, "Export list with :allclasses" );
  ok( Wx::HtmlWindow->isa( 'Wx::Window' ), "Wx::Html was loaded" );
}

# Local variables: #
# mode: cperl #
# End: #
