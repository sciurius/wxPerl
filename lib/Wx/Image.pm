#############################################################################
## Name:        Image.pm
## Purpose:     Wx::Image class
## Author:      Mattia Barbon
## Modified by:
## Created:      2/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Image;

use strict;

sub new {
  shift;

  @_ == 0                     && return Wx::Image::newNull();
  Wx::_match( @_, $Wx::_wico, 1 ) && return Wx::Image::newIcon( @_ );
  Wx::_match( @_, $Wx::_wbmp, 1 ) && return Wx::Image::newBitmap( @_ );
  Wx::_match( @_, $Wx::_wist_n, 2 ) && return Wx::Image::newStreamType( @_ );
  Wx::_match( @_, $Wx::_wist_s, 2 ) && return Wx::Image::newStreamMIME( @_ );
  Wx::_match( @_, $Wx::_n_n, 2 )  && return Wx::Image::newWH( @_ );
  Wx::_match( @_, $Wx::_n_n_s, 3 )  && return Wx::Image::newData( @_ );
  Wx::_match( @_, $Wx::_s_n, 2 )  && return Wx::Image::newNameType( @_ );
  Wx::_match( @_, $Wx::_s_s, 2 )  && return Wx::Image::newNameMIME( @_ );

  Wx::_croak Wx::_ovl_error;
}

# sub FindHandler {
#   if( $_[0] =~ /^\s*\d+\s*$/ ) { return Wx::Image::FindHandlerType( @_ ) }
#   elsif( @_ == 1 ) { return Wx::Image::FindHandlerName( @_ ) }
#   else { return Wx::Image::FindHandlerExtType( @_ ) }
# }

sub LoadFile {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wist_n, 2 ) && return Wx::Image::LoadStreamType( @_ );
  Wx::_match( @_, $Wx::_wist_s, 2 ) && return Wx::Image::LoadStreamMIME( @_ );
  Wx::_match( @_, $Wx::_s_n, 2 ) && return $this->LoadFileType( @_ );
  Wx::_match( @_, $Wx::_s_s, 2 ) && return $this->LoadFileMIME( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub SaveFile {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wost_n, 2 ) && return Wx::Image::SaveFileSType( @_ );
  Wx::_match( @_, $Wx::_wost_s, 2 ) && return Wx::Image::SaveFileSMIME( @_ );
  Wx::_match( @_, $Wx::_s_n, 2 ) && return $this->SaveFileType( @_ );
  Wx::_match( @_, $Wx::_s_s, 2 ) && return $this->SaveFileMIME( @_ );
  Wx::_match( @_, $Wx::_s, 1 ) && return $this->SaveFileOnly( @_ );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
