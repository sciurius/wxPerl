#############################################################################
## Name:        demo/wxGrid.pm
## Purpose:     wxGrid demo
## Author:      Mattia Barbon
## Modified by:
## Created:     08/12/2001
## RCS-ID:      $Id: wxGrid.pm,v 1.4 2003/06/05 17:28:11 mbarbon Exp $
## Copyright:   (c) 2001, 2003 Mattia Barbon
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
use base 'Wx::Grid';

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

# local variables:
# mode: cperl
# end:
