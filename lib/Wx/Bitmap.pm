#############################################################################
## Name:        Bitmap.pm
## Purpose:     Wx::Bitmap and Wx::mask classes
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Mask;

sub new {
  shift;
  if( @_ == 1 ) { return Wx::Mask::newBitmap( @_ ) }
  else { return Wx::Mask::newBitmapColour( @_ ) }
}

package Wx::Bitmap;

use strict;

sub new {
  shift;
  if( @_ == 3 || $_[0] =~m/^\s*\d+\s*$/ ) { return Wx::Bitmap::newEmpty( @_ ) }
  elsif( $_[0]->isa( 'Wx::Icon' ) ) { return Wx::Bitmap::newIcon( @_ ) }
  else { return Wx::Bitmap::newFile( @_ ) }
}

sub FindHandler {
  if( @_ == 2 ) { return Wx::Bitmap::FindHandlerName( @_ ) }
  elsif( @_ == 1 && $_[0] =~ m/^\s*\d+\s*$/ ) { return Wx::Bitmap::FindHandlerType( @_ ) }
  else { return Wx::Bitmap::FindHandlerExtType( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
