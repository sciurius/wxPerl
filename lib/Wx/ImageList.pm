#############################################################################
## Name:        ImageList.pm
## Purpose:     Wx::ImageList class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ImageList;

sub Add {
  my( $this ) = shift;

  if( $_[0]->isa( 'Wx::Icon' ) ) { return $this->AddIcon( @_ ) }
  elsif( defined $_[1] && $_[1]->isa( 'Wx::Colour' ) ) { return $this->AddWithColourMask( @_ ) }
  else { return $this->AddBitmap( @_ ) }
}

sub Replace {
  my( $this ) = shift;

  if( $_[1]->isa( 'Wx::Icon' ) ) { return $this->ReplaceIcon( @_ ) }
  else { return $this->ReplaceBitmap( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
