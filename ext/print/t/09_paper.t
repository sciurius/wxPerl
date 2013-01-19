#!/usr/bin/perl -w

use strict;
use Wx qw( wxThePrintPaperDatabase :print );
use Wx::Print;
use Test::More 'tests' => 3;

my $papersize = wxThePrintPaperDatabase->GetSize(wxPAPER_A4);
is( $papersize->x, 2100, 'A4 Width' );
is( $papersize->y, 2970, 'A4 Height' );

my $size = Wx::Size->new(2159,2794);
my $papertypeid = wxThePrintPaperDatabase->GetSize($size);

# size selection differs across versions and installations.
# wxPAPER_NOTE and wxPAPER_LETTER are the same size so either
# may be returned.

ok( $papertypeid == wxPAPER_LETTER || $papertypeid == wxPAPER_NOTE, 'Got Letter Size' );

# Local variables: #
# mode: cperl #
# End: #

