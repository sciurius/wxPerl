#############################################################################
## Name:        TreeCtrl.pm
## Purpose:     Wx::TreeCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     16/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::TreeItemId;

use overload '<=>' => \&tiid_spaceship;

package Wx::TreeCtrl;

use strict;

sub GetParent {
  my $this = shift;

  if( @_ == 1 && ref( $_[0] ) && $_[0]->isa( 'Wx::TreeItemId' ) ) { return $this->GetItemParent( @_ ) }
  if( @_ == 0 ) { return $this->SUPER::GetParent() }
  Wx::_croak Wx::_ovl_error;
}

sub InsertItem {
  my $this = shift;

  if( isa( $_[1], 'Wx::TreeItemId' ) ) { return $this->InsertItemPrev( @_ ) }
  return $this->InsertItemBef( @_ );
}

1;

# Local variables: #
# mode: cperl #
# End: #
