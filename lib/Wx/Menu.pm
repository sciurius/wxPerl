#############################################################################
## Name:        Menu.pm
## Purpose:     Wx::Menu class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Menu;

use UNIVERSAL qw(isa);

sub Append {
  my( $this ) = shift;

  if( @_ == 1 ) { return $this->AppendItem( @_ ) }
  elsif( isa( $_[2], 'Wx::Menu' ) ) { return $this->AppendSubMenu( @_ ) }
  else { return $this->AppendString( @_ ) }
}

sub Delete {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::MenuItem' ) ) { return $this->DeleteItem( @_ ) }
  else { return $this->DeleteId( @_ ) }
}

sub Destroy {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::MenuItem' ) ) { return $this->DestroyItem( @_ ) }
  else { return $this->DestroyId( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
