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
use Wx qw(wxNullBitmap wxTheApp wxICON_HAND wxRED);
require DataObjects;

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  Wx::StaticText->new( $this, -1, 'Drop text in listbox', [ 10, 10 ] );
  my $droptext = Wx::ListBox->new( $this, -1, [ 10 , 40 ], [ 150, 90 ] );

  Wx::StaticText->new( $this, -1, 'Drop bitmap below', [ 200, 10 ] );
  my $window = Wx::Window->new( $this, -1, [ 200, 40 ], [ 100, 50 ] );
  $window->SetBackgroundColour( wxRED );
  my $dropbitmap = Wx::StaticBitmap->new( $this, -1, wxNullBitmap,
                                          [ 200, 100 ], [ 200, 200 ] );
  Wx::StaticText->new( $this, -1, 'Drop files below', [ 10, 140 ] );
  my $dropfiles = Wx::ListBox->new( $this, -1, [ 10, 170 ], [ 150, 50 ] );

  my $dragsource = DNDDropSource->new( $this, -1, [ 10, 230 ] );

  $droptext->SetDropTarget( DNDTextDropTarget->new( $droptext ) );
  $dropfiles->SetDropTarget( DNDFilesDropTarget->new( $dropfiles ) );
  $window->SetDropTarget( DNDBitmapDropTarget->new( $dropbitmap ) );
  $dropbitmap->SetBitmap( Wx::Bitmap->new( wxTheApp->GetStdIcon( wxICON_HAND ) ) );

  return $this;
}

package DNDDropSource;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Window);
use Wx::Event qw(EVT_LEFT_DOWN EVT_PAINT);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_[0,1,2], [200,50] );

  EVT_PAINT( $this, \&OnPaint );
  EVT_LEFT_DOWN( $this, \&OnDrag );

  return $this;
}

sub OnPaint {
  my( $this, $event ) = @_;
  my $dc = Wx::PaintDC->new( $this );

  $dc->DrawText( "Drag text/bitmap from here", 2, 2 );
}

sub OnDrag {
  my( $this, $event ) = @_;

  my $data = DataObjects::GetBothDataObject();
#  my $data = DataObjects::GetBitmapDataObject();
  my $source = Wx::DropSource->new( $this );
  $source->SetData( $data );
  $source->DoDragDrop( 1 );
}

package DNDTextDropTarget;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::TextDropTarget);

sub new {
  my $class = shift;
  my $listbox = shift;
  my $this = $class->SUPER::new( @_ );

  $this->{LISTBOX} = $listbox;

  return $this;
}

sub OnDropText {
  my( $this, $x, $y, $data ) = @_;

  $data =~ s/[\r\n]+$//;
  Wx::LogMessage( "Dropped text: '$data'" );
  $this->{LISTBOX}->InsertItems( [ $data ], 0 );

  return 1;
}

package DNDFilesDropTarget;

use base qw(Wx::FileDropTarget);

sub new {
  my $class = shift;
  my $listbox = shift;
  my $this = $class->SUPER::new( @_ );

  $this->{LISTBOX} = $listbox;

  return $this;
}

sub OnDropFiles {
  my( $this, $x, $y, $files ) = @_;

  $this->{LISTBOX}->Clear;
  Wx::LogMessage( "Dropped files at ($x, $y)" );
  foreach my $i ( @$files ) {
    $this->{LISTBOX}->Append( $i );
  }

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
