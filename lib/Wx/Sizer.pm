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
use UNIVERSAL qw(isa);

sub Add {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Window' ) ) { $this->AddWindow( @_ ) }
  elsif( isa( $_[0], 'Wx::Sizer' ) ) { $this->AddSizer( @_ ) }
  else { $this->AddSpace( @_ ) }
}

sub Insert {
  my( $this ) = shift;

  if( isa( $_[1], 'Wx::Window' ) ) { $this->InsertWindow( @_ ) }
  elsif( isa( $_[1], 'Wx::Sizer' ) ) { $this->InsertSizer( @_ ) }
  else { $this->PrependSpace( @_ ) }
}

sub Prepend {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Window' ) ) { $this->PrependWindow( @_ ) }
  elsif( isa( $_[0], 'Wx::Sizer' ) ) { $this->PrependSizer( @_ ) }
  else { $this->PrependSpace( @_ ) }
}

sub Remove {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Window' ) ) { return $this->RemoveWindow( @_ ) }
  elsif( isa( $_[0], 'Wx::Sizer' ) ) { return $this->RemoveSizer( @_ ) }
  else { return $this->RemoveNth( @_ ) }
}

sub SetItemMinSize {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Window' ) ) { $this->SetItemMinSizeWindow( @_ ) }
  elsif( isa( $_[0], 'Wx::Sizer' ) ) { $this->SetItemMinSizeSizer( @_ ) }
  else { $this->SetItemMinSizeNth( @_ ) }
}

sub SetMinSize {
  my( $this ) = shift;

  if( isa( $_[0], 'Wx::Size' ) ) { $this->SetMinSizeSize( @_ ) }
  else { $this->SetItemMinSizeXY( @_ ) }
}

1;

# Local variables: #
# mode: cperl #
# End: #
