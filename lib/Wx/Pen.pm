#############################################################################
## Name:        Pen.pm
## Purpose:     Wx::Pen class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Pen;

use UNIVERSAL qw(isa);

sub new {
  shift;
  if( @_ == 2 ) { return Wx::Pen::newBitmap( @_ ) }
  elsif( isa( $_[0], 'Wx::Colour' ) ) { return Wx::Pen::newColour( @_ ) }
  else { return Wx::Pen::newString( @_ ) }
}

sub SetColour {
  my( $this ) = shift;

  if( @_ == 3 ) { return $this->SetColourRGB( @_ ) }
  elsif( isa( $_[0], 'Wx::Colour' ) ) { $this->SetColourColour( @_ ) }
  else { $this->SetColourName( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
