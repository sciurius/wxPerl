#############################################################################
## Name:        FS.pm
## Purpose:     Wx::FS ( pulls in all Wx::FileSystem stuff )
## Author:      Mattia Barbon
## Modified by:
## Created:     28/ 4/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::FS;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::FS', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::FileSystemHandler;
package Wx::InternetFSHandler;  @ISA = qw(Wx::FileSystemHandler);
package Wx::ZipFSHandler;       @ISA = qw(Wx::FileSystemHandler);
package Wx::PlFileSystemHandler; @ISA = qw(Wx::FileSystemHandler);
package Wx::PlFSFile;           @ISA = qw(Wx::FSFile);

use strict;

1;

# Local variables: #
# mode: cperl #
# End: #

