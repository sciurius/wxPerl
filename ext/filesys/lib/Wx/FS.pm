#############################################################################
## Name:        FS.pm
## Purpose:     Wx::FS ( pulls in all Wx::FileSystem stuff )
## Author:      Mattia Barbon
## Modified by:
## Created:     28/ 4/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::FS;

use Wx;
use strict;

require DynaLoader;

use vars qw(@ISA $VERSION);

$VERSION = '0.01';

@ISA = qw(DynaLoader);

bootstrap Wx::FS;

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

