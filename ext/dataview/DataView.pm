#############################################################################
## Name:        ext/dataview/DataView.pm
## Purpose:     Wx::DataViewCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     05/11/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::DataView;

use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::load_dll( 'adv' );
Wx::wx_boot( 'Wx::DataView', $VERSION );

SetEvents();

#
# properly setup inheritance tree
#

no strict;

package Wx::DataViewCtrl;    @ISA = qw(Wx::Control);
package Wx::DataViewModel;
package Wx::DataViewIndexListModel; @ISA = qw(Wx::DataViewModel);
package Wx::PlDataViewIndexListModel; @ISA = qw(Wx::DataViewIndexListModel);

1;
