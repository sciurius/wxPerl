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

use strict;
use Carp;

my( $wcol_i_i ) = [ 'Wx::Colour', 'INTEGER', 'INTEGER' ];
my( $s_i_i ) = [ '?', 'INTEGER', 'INTEGER' ];
my( $wbmp_i ) = [ 'Wx::Bitmap', 'INTEGER' ];

sub new {
  shift;

  Wx::_match( @_, $Wx::wcol_n_n, 3 ) && return Wx::Pen::newColour( @_ );
  Wx::_match( @_, $Wx::wbmp_n, 2 )   && return Wx::Pen::newBitmap( @_ );
  Wx::_match( @_, $Wx::s_n_n, 3 )    && return Wx::Pen::newString( @_ );
  croak Wx::_ovl_error;
}

sub SetColour {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wcol, 1 )  && ( $this->SetColourColour( @_ ), return );
  Wx::_match( @_, $Wx::_n_n_n, 3 ) && ( $this->SetColourRGB( @_ ), return );
  Wx::_match( @_, $Wx::_s, 1 )     && ( $this->SetColourName( @_ ), return );
  croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
