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

use strict;
use Carp;

sub new {
  shift;

  Wx::_match( @_, $Wx::_wbmp_wcol, 2 ) && return Wx::Mask::newBitmapColour( @_ );
  Wx::_match( @_, $Wx::_wbmp_n, 2 )    && return Wx::Mask::newBitmapIndex( @_ );
  Wx::_match( @_, $Wx::_wbmp, 1 )      && return Wx::Mask::newBitmap( @_ );
  croak Wx::_ovl_error;
}

package Wx::Bitmap;

use strict;
# disabled: needs further testing
# and anyway: is it useful?
#use overload '<=>' => \&bmp_spaceship;
use Carp;

sub new {
  shift;

  Wx::_match( @_, $Wx::_n_n_n, 2, 1 ) && return Wx::Bitmap::newEmpty( @_ );
  Wx::_match( @_, $Wx::_s_n, 2 )      && return Wx::Bitmap::newFile( @_ );
  Wx::_match( @_, $Wx::_wico, 1 )     && return Wx::Bitmap::newIcon( @_ );
  Wx::_match( @_, $Wx::_wimg, 1 )     && return Wx::Bitmap::newImage( @_ );
  croak Wx::_ovl_error;
}

# sub FindHandler {
#   if( @_ == 2 ) { return Wx::Bitmap::FindHandlerName( @_ ) }
#   elsif( @_ == 1 && $_[0] =~ m/^\s*\d+\s*$/ ) { return Wx::Bitmap::FindHandlerType( @_ ) }
#   else { return Wx::Bitmap::FindHandlerExtType( @_ ) }
# }

1;

# Local variables: #
# mode: cperl #
# End: #
