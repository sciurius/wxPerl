#############################################################################
## Name:        Sizer.pm
## Purpose:     Wx::Sizer class
## Author:      Mattia Barbon
## Modified by:
## Created:     28/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Sizer;

use strict;

sub Add {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wwin_n_n_n_s, 1, 1 ) && ( $this->AddWindow( @_ ), return );
  Wx::_match( @_, $Wx::_wszr_n_n_n_s, 1, 1 ) && ( $this->AddSizer( @_ ), return );
  Wx::_match( @_, $Wx::_n_n_n_n_n_s, 2, 1 )  && ( $this->AddSpace( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

sub Insert {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_wwin_n_n_n_s, 2, 1 ) && ( $this->InsertWindow( @_ ), return );
  Wx::_match( @_, $Wx::_n_wszr_n_n_n_s, 2, 1 ) && ( $this->InsertSizer( @_ ), return );
  Wx::_match( @_, $Wx::_n_n_n_n_n_n_s, 3, 1 )  && ( $this->InsertSpace( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

sub Prepend {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wwin_n_n_n_s, 1, 1 ) && ( $this->PrependWindow( @_ ), return );
  Wx::_match( @_, $Wx::_wszr_n_n_n_s, 1, 1 ) && ( $this->PrependSizer( @_ ), return );
  Wx::_match( @_, $Wx::_n_n_n_n_n_s, 2, 1 )  && ( $this->PrependSpace( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

sub Remove {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wwin, 1 ) && return $this->RemoveWindow( @_ );
  Wx::_match( @_, $Wx::_wszr, 1 ) && return $this->RemoveSizer( @_ );
  Wx::_match( @_, $Wx::_n, 1 )    && return $this->RemoveNth( @_ );
  Wx::_croak Wx::_ovl_error;
}

sub SetItemMinSize {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_wwin_n_n, 3 ) && ( $this->SetItemMinSizeWindow( @_ ), return );
  Wx::_match( @_, $Wx::_wszr_n_n, 3 ) && ( $this->SetItemMinSizeSizer( @_ ), return );
  Wx::_match( @_, $Wx::_n_n_n, 3 )    && ( $this->SetItemMinSizeNth( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

sub SetMinSize {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n, 2 )  && ( $this->SetMinSizeXY( @_ ), return );
  Wx::_match( @_, $Wx::_wsiz, 1 ) && ( $this->SetMinSizeSize( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

package Wx::SizerItem;

use strict;

sub SetRatio {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n, 1 )    && ( $this->SetRatioFloat( @_ ), return );
  Wx::_match( @_, $Wx::_n_n, 2 )  && ( $this->SetRatioWH( @_ ), return );
  Wx::_match( @_, $Wx::_wsiz, 1 ) && ( $this->SetRatioSize( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
