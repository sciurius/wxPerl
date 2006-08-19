#!/usr/bin/perl -w
#############################################################################
## Name:        script/wx_overload.pl
## Purpose:     builds overload constants
## Author:      Mattia Barbon
## Modified by:
## Created:     17/08/2001
## RCS-ID:      $Id: wx_overload.pl,v 1.2 2006/08/19 18:48:04 mbarbon Exp $
## Copyright:   (c) 2001-2003, 2005-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use FindBin;

use strict;
use lib "$FindBin::RealBin/../build";

use Wx::Overload::Driver;

my( $ovlc, $ovlh ) = ( shift, shift );

my $driver = Wx::Overload::Driver->new
  ( files  => \@ARGV,
    header => $ovlh,
    source => $ovlc,
    );
$driver->process;

exit 0;
