#############################################################################
## Name:        Region.pm
## Purpose:     Wx::Region class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Region;

use strict;
use UNIVERSAL qw(isa);

sub new {
  shift;
  if( @_ == 4 ) { return Wx::Region::newXYWH( @_ ) }
  elsif( @_ == 2 ) { return Wx::Region::newPP( @_ ) }
  else { return Wx::Region::newRect( @_ ) }
}

sub Contains {
  my( $this ) = shift;

  if( @_ == 4 ) { return $this->ContainsXYWH( @_ ) }
  elsif( @_ == 2 ) { return $this->Contains( @_ ) }
  elsif( isa( $_[0], 'Wx::Point' ) ) { return $this->ContainsPoint( @_ ) }
  else { return $this->ContainsRect( @_ ) }
}

sub Intersect {
  my( $this ) = shift;

  if( @_ == 4 ) { return $this->IntersectXYWH( @_ ) }
  elsif( isa( $_[0], 'Wx::Region' ) ) { return $this->IntersectRegion( @_ ) }
  else { return $this->IntersectRect( @_ ) }
}

sub Subtract {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Region' ) ) { return $this->SubtractRegion( @_ ) }
  else { return $this->SubtractRect( @_ ) }
}

sub Union {
  my( $this ) = shift;

  if( @_ == 4 ) { return $this->UnionXYWH( @_ ) }
  elsif( isa( $_[0], 'Wx::Region' ) ) { return $this->UnionRegion( @_ ) }
  else { return $this->UnionRect( @_ ) }
}

sub Xor {
  my( $this ) = shift;

  if( @_ == 4 ) { return $this->XorXYWH( @_ ) }
  elsif( isa( $_[0], 'Wx::Region' ) ) { return $this->XorRegion( @_ ) }
  else { return $this->XorRect( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
