#############################################################################
## Name:        RadioBox.pm
## Purpose:     Wx::RadioBox class
## Author:      Mattia Barbon
## Modified by:
## Created:     28/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::RadioBox;

use strict;
use Carp;

#FIXME// motif?
if( $Wx::_platform == $Wx::_gtk ) {
  @Wx::RadioBox::ISA = qw(Wx::Control);
}
else {
  @Wx::RadioBox::ISA = qw(Wx::ControlWithItems);
}

sub Enable {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_b, 1 )   && ( $this->SUPER::Enable( @_ ), return );
  Wx::_match( @_, $Wx::_n_b, 2 ) && ( $this->EnableItem( @_ ), return );
  croak Wx::_ovl_error;
}

sub GetLabel {
  my( $this ) = shift;

  @_ == 0                  && return $this->SUPER::GetLabel();
  Wx::_match( @_, $Wx::_n, 1 ) && return $this->GetItemLabel();
  croak Wx::_ovl_error;
}

sub SetLabel {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_s, 2 ) && $this->SetItemLabel( @_ );
  Wx::_match( @_, $Wx::_s, 1 )   && $this->SUPER::SetLabel( @_ );
  croak Wx::_ovl_error;
}

sub Show {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n, 2 ) && $this->ShowItem( @_ );
  Wx::_match( @_, $Wx::_n, 1 )   && $this->Show( @_ );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
