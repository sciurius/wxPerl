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

use strict;
use Carp;

sub Add {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wbmp_wbmp, 1, 1 ) && return $this->AddBitmap( @_ );
  Wx::_match( @_, $Wx::_wbmp_wcol, 2 )    && return $this->AddWithColourMask( @_ );
  Wx::_match( @_, $Wx::_wico, 1 )         && return $this->AddIcon( @_ );
  croak Wx::_ovl_error 'Wx::ImageList::Add';
}

sub Replace {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_wico, 2 )         && return $this->ReplaceIcon( @_ );
  Wx::_match( @_, $Wx::_n_wbmp_wbmp, 2, 1 ) && return $this->ReplaceBitmap( @_ );
  croak Wx::_ovl_error 'Wx::ImageList::Replace';
}

1;

# Local variables: #
# mode: cperl #
# End: #
