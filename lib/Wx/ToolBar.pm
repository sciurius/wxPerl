#############################################################################
## Name:        ToolBar.pm
## Purpose:     Wx::ToolBar class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::ToolBar;

use strict;

sub AddTool {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_wbmp_wbmp_b_s_s_s, 2, 1 ) && return $this->AddToolLong( @_ );
  Wx::_match( @_, $Wx::_n_wbmp_s_s, 2, 1 )          && return $this->AddToolShort( @_ );

  Wx::_croak Wx::_ovl_error;
}

sub SetMargins {
  my( $this ) = shift;

  Wx::_match( @_, $Wx::_n_n, 2 )  && ( $this->SetMarginsXY( @_ ), return );
  Wx::_match( @_, $Wx::_wsiz, 1 ) && ( $this->SetMarginsSize( @_ ), return );
  Wx::_croak Wx::_ovl_error;
}

1;

# Local variables: #
# mode: cperl #
# End: #
