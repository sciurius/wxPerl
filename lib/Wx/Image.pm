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

use UNIVERSAL qw(isa);

sub new {
  shift;

  if( @_ == 0 ) { return Wx::Image::newNull() }
  elsif( isa( $_[0], 'Wx::Bitmap' ) ) { return Wx::Image::newBitmap( @_ ) }
  elsif( $_[1] =~ m/^\s*\d+\s*$/ ) {
    if( $_[0] =~ m/^\s*\d+\s*$/ ) {
      return Wx::Image::newWH( @_ )
    } else {
      return Wx::Image::newNameType( @_ )
    }
  } else {
    return Wx::Image::newNameMIME( @_ )
  }
}

# sub FindHandler {
#   if( $_[0] =~ /^\s*\d+\s*$/ ) { return Wx::Image::FindHandlerType( @_ ) }
#   elsif( @_ == 1 ) { return Wx::Image::FindHandlerName( @_ ) }
#   else { return Wx::Image::FindHandlerExtType( @_ ) }
# }

sub LoadFile {
  my( $this ) = shift;

  if( $_[1] =~ m/^\s*\d+\s*$/ ) { return $this->LoadFileType( @_ ) }
  else { return $this->LoadFileMIME( @_ ) }
}

sub SaveFile {
  my( $this ) = shift;

  if( $_[1] =~ m/^\s*\d+\s*$/ ) { return $this->SaveFileType( @_ ) }
  else { return $this->SaveFileMIME( @_ ) }
}

1;

# Local variables: #
# mode; cperl #
# End: #
