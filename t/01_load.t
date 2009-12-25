#!/usr/bin/perl -w

use strict;
use Test::More tests => 6;

BEGIN { use_ok 'Wx' }

use Wx 'wxYES';
my $x = wxYES;

ok( 1, "Exported constant" );

SKIP: {
  use Wx qw(:frame :allclasses wxNO_3D wxTAB_TRAVERSAL);

  $x = wxTAB_TRAVERSAL();
  $x = wxCAPTION();

  ok( 1, "Export list with :allclasses" );
  ok( Wx::HtmlWindow->isa( 'Wx::Window' ), "Wx::Html was loaded" );
}

eval "use Wx qw(wxNO_SUCH_CONSTANT)";
ok( $@, "Error exporting missing constant: $@" );

eval "Wx::wxNO_SUCH_CONSTANT()";
ok( $@, "Error autoloading missing constant: $@" );

# Local variables: #
# mode: cperl #
# End: #
