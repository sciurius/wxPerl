#############################################################################
## Name:        demo/DragDrop.pm
## Purpose:     Drag and Drop demo
## Author:      Mattia Barbon
## Modified by:
## Created:     12/09/2001
## RCS-ID:      $Id: DragDrop.pm,v 1.6 2004/02/28 22:59:06 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::DND;

package DNDDemo;

use strict;

sub window {
  my( $this, $parent ) = @_;

  Wx::Image::AddHandler( Wx::PNGHandler->new );
  return DNDDemoWindow->new( $parent );
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Drag and Drop</title>
</head>
<body>
<h3>Drag and Drop</h3>

<p>
  Drag and drop is a relatively complex topic: you are strongly encouraged to
  look at the overview in the wxWidgets documentation
  ( Topic overviews => Drag and drop overview ).
</p>
</body>
</html>
EOT
}

package DNDDemoWindow;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Panel);
use Wx qw(wxNullBitmap wxTheApp wxICON_HAND wxRED);
require DataObjects;

my $tree;

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_ );

  # text drop target
  Wx::StaticText->new( $this, -1, 'Drop text in listbox', [ 10, 10 ] );
  my $droptext = Wx::ListBox->new( $this, -1, [ 10 , 40 ], [ 150, 90 ] );
  $droptext->SetDropTarget( DNDTextDropTarget->new( $droptext ) );

  # bitmap drop target
  Wx::StaticText->new( $this, -1, 'Drop bitmap below', [ 200, 10 ] );
  my $window = Wx::Window->new( $this, -1, [ 200, 40 ], [ 80, 50 ] );
  $window->SetBackgroundColour( wxRED );
  my $dropbitmap = Wx::StaticBitmap->new( $this, -1, wxNullBitmap,
                                          [ 200, 100 ], [ 200, 200 ] );
  $window->SetDropTarget( DNDBitmapDropTarget->new( $dropbitmap ) );
  $dropbitmap->SetBitmap( Wx::Bitmap->new( wxTheApp->GetStdIcon( wxICON_HAND ) ) );

  # files drop target
  Wx::StaticText->new( $this, -1, 'Drop files below', [ 10, 140 ] );
  my $dropfiles = Wx::ListBox->new( $this, -1, [ 10, 170 ], [ 150, 50 ] );
  $dropfiles->SetDropTarget( DNDFilesDropTarget->new( $dropfiles ) );

  # drop source
  my $dragsource = DNDDropSource->new( $this, -1, [ 10, 230 ] );

  # tree control; you can drop on items
  $tree = Wx::TreeCtrl->new( $this, -1, [ 300, 10 ], [ 100, 150 ] );
  my $root = $tree->AddRoot( "Drop here" );
  $tree->AppendItem( $root, "and here" );
  $tree->AppendItem( $root, "and here" );
  $tree->AppendItem( $root, "and here" );
  $tree->SetDropTarget( TreeDropTarget->new( $tree, $dropbitmap ) );

  return $this;
}

package TreeDropTarget;

use base qw(Wx::DropTarget);

sub new {
  my $class = shift;
  my $tree = shift;
  my $canvas = shift;
  my $this = $class->SUPER::new;

  my $data = Wx::BitmapDataObject->new;
  $this->SetDataObject( $data );
  $this->{TREE} = $tree;
  $this->{DATA} = $data;
  $this->{CANVAS} = $canvas;

  return $this;
}

sub data { $_[0]->{DATA} }
sub canvas { $_[0]->{CANVAS} }

use Wx qw(:treectrl wxDragNone wxDragCopy);

# give visual feedback: select the item we're on
# ( probably better forms of feedback are possible )
# also return the desired action to make the OS display an appropriate
# "can drop here" icon
sub OnDragOver {
  my( $this, $x, $y, $desired ) = @_;
  my $tree = $this->{TREE};

  my( $item, $flags ) = $tree->HitTest( [$x, $y] );
  if( $flags & wxTREE_HITTEST_ONITEMLABEL ) {
    $tree->SelectItem( $item );
    return $desired;
  } else {
    $tree->Unselect();
    return wxDragNone;
  }
}

sub OnData {
  my( $this, $x, $y, $def ) = @_;

  $this->GetData;
  $this->canvas->SetBitmap( $this->data->GetBitmap );

  return $def;
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

  # defined inf DataObjects.pm; just returns a data object containing
  # both text and bitmap data
  my $data = DataObjects::GetBothDataObject();
  my $source = Wx::DropSource->new( $this );
  $source->SetData( $data );
  Wx::LogMessage( "Status: %d", $source->DoDragDrop( 1 ) );
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
