#############################################################################
## Name:        DragDrop.pm
## Purpose:     Drag and Drop demo
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::DND;

package DNDDemo;

use strict;

sub window {
  my( $this, $parent ) = @_;

  return DNDDemoWindow->new( $parent );
}

sub description {
  return <<EOT;
EOT
}

package DNDDemoWindow;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Panel);
use Wx qw(wxNullBitmap wxTheApp wxICON_HAND);
use Wx::Event qw(EVT_LEFT_DOWN);
require DataObjects;

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  my $droptext = Wx::ListBox->new( $this, -1 );
  my $dropbitmap = Wx::StaticBitmap->new( $this, -1, wxNullBitmap,
                                          [ 200, 200 ], [ 200, 200 ] );
  $droptext->SetDropTarget( DNDTextDropTarget->new() );
  $dropbitmap->SetDropTarget( DNDBitmapDropTarget->new( $dropbitmap ) );
  $dropbitmap->SetBitmap( Wx::Bitmap->new( wxTheApp->GetStdIcon( wxICON_HAND ) ) );
  EVT_LEFT_DOWN( $this, \&OnDrag );

  return $this;
}

sub OnDrag {
  my( $this, $event ) = @_;

#  my $data = Wx::TextDataObject->new( "Test!" );
  my $data = DataObjects::GetBothDataObject();
  my $source = Wx::DropSource->new( $this );
  $source->SetData( $data );
  $source->DoDragDrop( 1 );
}

package DNDTextDropTarget;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::TextDropTarget);

sub OnDropText {
  my( $this, $x, $y, $data ) = @_;

  Wx::LogMessage( "Dropped text: '$data'" );

  return 1;
}

package DNDBitmapDropTarget;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::DropTarget);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new;

  my $data = Wx::BitmapDataObject->new;
  $this->SetDataObject( $data );
  $this->{DATA} = $data;
  $this->{CANVAS} = $_[0];

  return $this;
}

sub data { $_[0]->{DATA} }
sub canvas { $_[0]->{CANVAS} }

sub OnData {
  my( $this, $x, $y, $def ) = @_;

  $this->GetData;
  $this->canvas->SetBitmap( $this->data->GetBitmap );

  return $def;
}

1;

# Local variables: #
# mode: cperl #
# End: #
