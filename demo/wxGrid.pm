#############################################################################
## Name:        wxGrid.pm
## Purpose:     wxGrid demo
## Author:      Mattia Barbon
## Modified by:
## Created:      8/12/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package GridDemo;

use strict;

sub window {
  shift;
  my $parent = shift;

  my $window = wxGridDemoWindow->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::Grid example</title>
</head>
<body>
<h3>Wx::Grid</h3>

<p>
  Wx::Grid can be used to display and edit tabular data.
</p>

<p>
  You can use editors and renderers to alter the way data is displayed by the
  grid or the way the user inputs data into cells.
</p>

</body>
</html>
EOT
}

package wxGridDemoWindow;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Panel);
use Wx::Grid;

use Wx qw(:sizer);
use Wx::Event qw(EVT_BUTTON);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $top_s = Wx::BoxSizer->new( wxVERTICAL );
  my $but_s = Wx::BoxSizer->new( wxHORIZONTAL );

  my $simple = Wx::Button->new( $this, -1, 'Simple grid' );
  my $editors_renderers = Wx::Button->new( $this, -1, 'Editors/Renderers' );

  $but_s->Add( $simple, 0, wxALL, 5 );
  $but_s->Add( $editors_renderers, 0, wxALL, 5 );

  $top_s->Add( $but_s, 0, wxGROW );

  $this->{SIZER} = $top_s;

  $this->OnGrid2();

  EVT_BUTTON( $this, $simple, MakeEvtHandler( \&OnGrid1 ) );
  EVT_BUTTON( $this, $editors_renderers, MakeEvtHandler( \&OnGrid2 ) );

  $this->SetSizer( $top_s );
  $this->SetAutoLayout( 1 );

  return $this;
}

sub sizer { $_[0]->{SIZER} }
sub grid { $_[0]->{GRID} }

sub MakeEvtHandler {
  my $createfun = shift;

  return sub {
    my( $this, $event ) = @_;

    $this->sizer->Remove( 0 );
    $this->grid->Destroy();
    $this->$createfun();
    $this->Layout();
  }
}

sub OnGrid1 {
  my( $this, $event ) = @_;

  my $grid = wxTestGrid1->new( $this );
  $this->sizer->Prepend( $grid, 1, wxGROW );
  $this->{GRID} = $grid;
}

sub OnGrid2 {
  my( $this, $event ) = @_;

  my $grid = wxTestGrid2->new( $this );
  $this->sizer->Prepend( $grid, 1, wxGROW );
  $this->{GRID} = $grid;
}

package wxTestGrid2;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Grid);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  $this->CreateGrid( 11, 7 );
  # set every cell read-only
  for my $x ( 1 .. 7 ) {
    for my $y ( 1 .. 11 ) {
      $this->SetReadOnly( $x, $y );
    }
  }

  $this->SetColSize( 0, 20 );
  $this->SetColSize( 1, 150 );
  $this->SetColSize( 2, 100 );
  $this->SetColSize( 3, 20 );
  $this->SetColSize( 4, 150 );
  $this->SetColSize( 5, 100 );
  $this->SetColSize( 6, 20 );

  $this->SetCellValue( 1, 1, "Default editor and renderer" );
  $this->SetCellValue( 1, 2, "Test 1" );

  $this->SetCellValue( 3, 1, "Float editor" );
  $this->SetCellValue( 3, 2, "1.00" );
  $this->SetCellEditor( 3, 2, Wx::GridCellFloatEditor->new() );
  # set read-write
  $this->SetReadOnly( 3, 2, 0 );

  $this->SetCellValue( 5, 1, "Bool editor" );
  $this->SetCellValue( 5, 2, "1" );
  $this->SetCellEditor( 5, 2, Wx::GridCellBoolEditor->new() );
  # set read-write
  $this->SetReadOnly( 5, 2, 0 );

  $this->SetCellValue( 7, 1, "Number editor" );
  $this->SetCellValue( 7, 2, "14" );
  $this->SetCellEditor( 7, 2, Wx::GridCellNumberEditor->new( 12, 20 ) );
  # set read-write
  $this->SetReadOnly( 7, 2, 0 );

  $this->SetCellValue( 9, 1, "Choice editor" );
  $this->SetCellValue( 9, 2, "Test" );
  $this->SetCellEditor( 9, 2, Wx::GridCellChoiceEditor->new( [qw(This Is a Test) ] ) );
  # set read-write
  $this->SetReadOnly( 9, 2, 0 );

  $this->SetCellValue( 3, 4, "Float renderer" );
  $this->SetCellValue( 3, 5, "1.00" );
  $this->SetCellRenderer( 3, 5, Wx::GridCellFloatRenderer->new( 12, 7 ) );
  $this->SetReadOnly( 3, 5, 0 );

  $this->SetCellValue( 5, 4, "Bool renderer" );
  $this->SetCellValue( 5, 5, "1" );
  $this->SetCellRenderer( 5, 5, Wx::GridCellBoolRenderer->new() );
  $this->SetReadOnly( 5, 5, 0 );

  $this->SetCellValue( 7, 4, "Number renderer" );
  $this->SetCellValue( 7, 5, "12" );
  $this->SetCellRenderer( 7, 5, Wx::GridCellNumberRenderer->new() );
  $this->SetReadOnly( 7, 5, 0 );

  return $this;
}

package wxTestGrid1;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Grid);

use Wx::Event qw(EVT_GRID_CELL_LEFT_CLICK EVT_GRID_CELL_RIGHT_CLICK
    EVT_GRID_CELL_LEFT_DCLICK EVT_GRID_CELL_RIGHT_DCLICK
    EVT_GRID_LABEL_LEFT_CLICK EVT_GRID_LABEL_RIGHT_CLICK
    EVT_GRID_LABEL_LEFT_DCLICK EVT_GRID_LABEL_RIGHT_DCLICK
    EVT_GRID_ROW_SIZE EVT_GRID_COL_SIZE EVT_GRID_RANGE_SELECT
    EVT_GRID_CELL_CHANGE EVT_GRID_SELECT_CELL);

use Wx qw(wxRED wxBLUE wxGREEN);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  $this->CreateGrid( 100, 100 );

  my $attr1 = Wx::GridCellAttr->new;
  $attr1->SetBackgroundColour( wxRED );
  my $attr2 = Wx::GridCellAttr->new;
  $attr2->SetTextColour( wxGREEN );

  $this->SetColAttr( 2, $attr1 );
  $this->SetRowAttr( 3, $attr2 );

  $this->SetCellValue( 1, 1, "First" );
  $this->SetCellValue( 2, 2, "Second" );
  $this->SetCellValue( 3, 3, "Third" );
  $this->SetCellValue( 3, 1, "I'm green" );

  EVT_GRID_CELL_LEFT_CLICK( $this, c_log_skip( "Cell left click" ) );
  EVT_GRID_CELL_RIGHT_CLICK( $this, c_log_skip( "Cell right click" ) );
  EVT_GRID_CELL_LEFT_DCLICK( $this, c_log_skip( "Cell left double click" ) );
  EVT_GRID_CELL_RIGHT_DCLICK( $this, c_log_skip( "Cell right double click" ) );
  EVT_GRID_LABEL_LEFT_CLICK( $this, c_log_skip( "Label left click" ) );
  EVT_GRID_LABEL_RIGHT_CLICK( $this, c_log_skip( "Label right click" ) );
  EVT_GRID_LABEL_LEFT_DCLICK( $this, c_log_skip( "Label left double click" ) );
  EVT_GRID_LABEL_RIGHT_DCLICK( $this, c_log_skip( "Label right double click" ) );

  EVT_GRID_ROW_SIZE( $this, sub {
                       Wx::LogMessage( "%s %s", "Row size", GS2S( $_[1] ) );
                       $_[1]->Skip;
                     } );
  EVT_GRID_COL_SIZE( $this, sub {
                       Wx::LogMessage( "%s %s", "Col size", GS2S( $_[1] ) );
                       $_[1]->Skip;
                     } );

  EVT_GRID_RANGE_SELECT( $this, sub {
                           Wx::LogMessage( "Range %sselect (%d, %d, %d, %d)",
                                           ( $_[1]->Selecting ? '' : 'de' ),
                                           $_[1]->GetLeftCol, $_[1]->GetTopRow,
                                           $_[1]->GetRightCol,
                                           $_[1]->GetBottomRow );
                           $_[1]->Skip;
                         } );
  EVT_GRID_CELL_CHANGE( $this, c_log_skip( "Cell content changed" ) );
  EVT_GRID_SELECT_CELL( $this, c_log_skip( "Cell select" ) );

  return $this;
}

# pretty printer for Wx::GridEvent
sub G2S {
  my $event = shift;
  my( $x, $y ) = ( $event->GetCol, $event->GetRow );

  return "( $x, $y )";
}

# prety printer for Wx::GridSizeEvent
sub GS2S {
  my $event = shift;
  my $roc = $event->GetRowOrCol;

  return "( $roc )";
}

# creates an anonymous sub that logs and skips any grid event
sub c_log_skip {
  my $text = shift;

  return sub {
    Wx::LogMessage( "%s %s", $text, G2S( $_[1] ) );
    $_[1]->Skip;
  };
}

1;

# Local variables: #
# mode: cperl #
# End: #
