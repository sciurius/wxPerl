#############################################################################
## Name:        ext/richtext/lib/Wx/RichText.pm
## Purpose:     Wx::RichTextCtrl and related classes
## Author:      Mattia Barbon
## Modified by:
## Created:     05/11/2006
## RCS-ID:      $Id: RichText.pm,v 1.1 2006/11/05 16:28:01 mbarbon Exp $
## Copyright:   (c) 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::RichText;

use strict;

our $VERSION = '0.01';

Wx::load_dll( 'adv' );
Wx::load_dll( 'richtext' );
Wx::wx_boot( 'Wx::RichText', $VERSION );

#
# properly setup inheritance tree
#

no strict;

package Wx::RichTextCtrl;    @ISA = qw(Wx::TextCtrl);
package Wx::TextAttrEx;      @ISA = qw(Wx::TextAttr);
package Wx::RichTextEvent;   @ISA = qw(Wx::NotifyEvent);

1;
