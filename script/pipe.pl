#############################################################################
## Name:        pipe.pl
## Purpose:     redirects stderr to stdout and execs arguments
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

open STDERR, ">&STDOUT";

exec @ARGV;

# Local variables: #
# mode: cperl #
# End: #
