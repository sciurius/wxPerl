#############################################################################
## Name:        ext/ipc/Makefile.PL
## Purpose:     Makefile.PL for Inter-Process Communication Framework
## Author:      Mark Dootson
## Modified by:
## Created:     13 April 2013
## RCS-ID:      $Id$
## Copyright:   (c) 2013, 2010 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use lib '../../build';
use Wx::build::MakeMaker;

wxWriteMakefile( NAME             => 'Wx::IPC',
                 VERSION_FROM     => 'lib/Wx/IPC.pm',
                 WX_CORE_LIB      => 'net core base',
                 );

# local variables:
# mode: cperl
# end:
