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

#FIXME// motif?
if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::Control);
}
else {
  @ISA = qw(Wx::ControlWithItems);
}

sub GetLabel {
  my( $this ) = shift;

  if( @_ == 1 ) { return $this->GetItemLabel( @_ ) }
  else { return $this->SUPER::GetLabel() }
}

sub SetLabel {
  my( $this ) = shift;

  if( @_ == 2 ) { return $this->SetItemLabel( @_ ) }
  else { return $this->SUPER::SetLabel( @_ ) }
}

sub Show {
  my( $this ) = shift;

  if( @_ == 2 ) { return $this->Show( @_ ) }
  else { return $this->SUPER::Show( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
