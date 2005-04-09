#############################################################################
## Name:        demo/wxGridTable.pm
## Purpose:     wxGrid demo: custom wxGridTable
## Author:      Mattia Barbon
## Modified by:
## Created:     05/08/2003
## RCS-ID:      $Id: wxGridTable.pm,v 1.3 2005/04/09 13:25:43 mbarbon Exp $
## Copyright:   (c) 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::Grid;

package GridTableDemo;

use strict;

sub window {
  shift;
  my $parent = shift;

  my $window = GridTableDemoWindow->new( $parent );

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

</body>
</html>
EOT
}

package MyGridTable;

use strict;
use base 'Wx::PlGridTable';

sub GetNumberRows { 100000 }
sub GetNumberCols { 100000 }
sub IsEmptyCell { 0 }

sub GetValue {
  my( $this, $y, $x ) = @_;

  return "($y, $x)";
}

sub SetValue {
  my( $this, $x, $y, $value ) = @_;

  die "Read-Only table";
}

sub GetTypeName {
  my( $this, $r, $c ) = @_;

  return $c == 0 ? 'bool' :
         $c == 1 ? 'double' :
                   'string';
}

sub CanGetValueAs {
  my( $this, $r, $c, $type ) = @_;

  return $c == 0 ? $type eq 'bool' :
         $c == 1 ? $type eq 'double' :
                   $type eq 'string';
}

sub GetValueAsBool {
  my( $this, $r, $c ) = @_;

  return $r % 2;
}

sub GetValueAsDouble {
  my( $this, $r, $c ) = @_;

  return $r + $c / 1000;
}

package GridTableDemoWindow;

use strict;
use base 'Wx::Grid';

use Wx::Event qw(EVT_GRID_CELL_LEFT_CLICK EVT_GRID_CELL_RIGHT_CLICK
    EVT_GRID_CELL_LEFT_DCLICK EVT_GRID_CELL_RIGHT_DCLICK
    EVT_GRID_LABEL_LEFT_CLICK EVT_GRID_LABEL_RIGHT_CLICK
    EVT_GRID_LABEL_LEFT_DCLICK EVT_GRID_LABEL_RIGHT_DCLICK
    EVT_GRID_ROW_SIZE EVT_GRID_COL_SIZE EVT_GRID_RANGE_SELECT
    EVT_GRID_CELL_CHANGE EVT_GRID_SELECT_CELL);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $table = MyGridTable->new;

  $this->SetTable( $table );

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
                           $_[0]->ShowSelections;
                           $_[1]->Skip;
                         } );
  EVT_GRID_CELL_CHANGE( $this, c_log_skip( "Cell content changed" ) );
  EVT_GRID_SELECT_CELL( $this, c_log_skip( "Cell select" ) );

  return $this;
}

sub ShowSelections {
    my $this = shift;

    my @cells = $this->GetSelectedCells;
    if( @cells ) {
        Wx::LogMessage( "Cells %s selected", join ', ',
                                                  map { "(" . $_->GetCol .
                                                        ", " . $_->GetRow . ")"
                                                       } @cells );
    } else {
        Wx::LogMessage( "No cells selected" );
    }

    my @tl = $this->GetSelectionBlockTopLeft;
    my @br = $this->GetSelectionBlockBottomRight;
    if( @tl && @br ) {
        Wx::LogMessage( "Blocks %s selected",
                        join ', ',
                        map { "(" . $tl[$_]->GetCol .
                              ", " . $tl[$_]->GetRow . "-" .
                              $br[$_]->GetCol . ", " .
                              $br[$_]->GetRow . ")"
                            } 0 .. $#tl );
    } else {
        Wx::LogMessage( "No blocks selected" );
    }

    my @rows = $this->GetSelectedRows;
    if( @rows ) {
        Wx::LogMessage( "Rows %s selected", join ', ', @rows );
    } else {
        Wx::LogMessage( "No rows selected" );
    }

    my @cols = $this->GetSelectedCols;
    if( @cols ) {
        Wx::LogMessage( "Columns %s selected", join ', ', @cols );
    } else {
        Wx::LogMessage( "No columns selected" );
    }
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
    $_[0]->ShowSelections;
    $_[1]->Skip;
  };
}

1;

# local variables:
# mode: cperl
# end:
