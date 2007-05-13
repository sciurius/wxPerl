#!/usr/bin/perl -w
#############################################################################
## Name:        script/make_typemap.pl
## Purpose:     Preprocess the typemap file
## Author:      Mattia Barbon
## Modified by:
## Created:     27/03/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Fatal qw(open close);

open my $in, '<', $ARGV[0];
undef $/;
$_ = <$in>;
close $in;

s{typemap\.tmpl}{typemap};
s{PERL_CLASS}'${(my $ntt=$ntype)=~s/^(?:const\s+)?(?:Wx_|wx)(.*?)(?:Ptr)?$/$1/g;$ntt=qq{\"Wx::$ntt\"};\$ntt}'g;
s{CPP_CLASS}'${(my $t=$type)=~s/^Wx_/wx/;\$t}'g;

open my $out, '>', $ARGV[1];
print $out $_;
close $out;

exit 0;
