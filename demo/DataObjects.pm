#############################################################################
## Name:        demo/DataObjects.pm
## Purpose:     wxPerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     12/09/2001
## RCS-ID:      $Id: DataObjects.pm,v 1.5 2004/10/19 20:28:06 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package DataObjects;

use strict;
use Wx qw(:brush :pen :bitmap);

sub GetImage {
  my $bitmap = Wx::Bitmap->new( 100, 100 );
  my $dc = Wx::MemoryDC->new;
  $dc->SelectObject( $bitmap );

  my @brushes = ( wxWHITE_BRUSH, wxBLUE_BRUSH, wxGREEN_BRUSH,
                  wxGREY_BRUSH, wxCYAN_BRUSH );
  $dc->SetBrush( @brushes[rand(5)] );
  $dc->DrawRectangle( 0, 0, 100, 100 );

  $dc->SetPen( wxBLACK_PEN );
  $dc->SetBrush( new Wx::Brush( 'yellow', wxSOLID ) );

  $dc->DrawEllipse( 1, 1, 98, 98 );

  #$dc->SetPen( wxWHITE_PEN );
  $dc->SetBrush( wxWHITE_BRUSH );
  $dc->DrawEllipse( 20, 20, 25, 25 );
  $dc->DrawEllipse( 100 - 45, 20, 25, 25 );

  $dc->SelectObject( wxNullBitmap );

  return $bitmap;
}

sub GetBitmapDataObject {
  return Wx::BitmapDataObject->new( GetImage() );
}

sub GetTextDataObject {
  return Wx::TextDataObject->new( "Hello, wxPerl!" );
}

sub GetBothDataObject {
  my $data = Wx::DataObjectComposite->new;
  my $text = <<EOT;
This is a yellow face.
EOT
  $text =~ s/\n/\r\n/g;

  $data->Add( Wx::TextDataObject->new( $text ) );
  $data->Add( Wx::BitmapDataObject->new( GetImage() ), 1 );

  return $data;
}

1;

# Local variables: #
# mode: cperl #
# End: #
