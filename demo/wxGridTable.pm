#############################################################################
## Name:        demo/wxGridTable.pm
## Purpose:     wxGrid demo: custom wxGridTable
## Author:      Mattia Barbon
## Modified by:
## Created:     05/08/2003
## RCS-ID:      $Id: wxGridTable.pm,v 1.1 2003/08/05 17:23:47 mbarbon Exp $
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
  my( $this, $x, $y ) = @_;

  return "($x, $y)";
}

sub SetValue {
  my( $this, $x, $y, $value ) = @_;

  die "Read-Only table";
}

package GridTableDemoWindow;

use strict;
use base 'Wx::Grid';

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $table = MyGridTable->new;

  $this->SetTable( $table );

=pod

  $this->CreateGrid( 3, 7 );
  # set every cell read-only
  for my $x ( 1 .. 7 ) {
    for my $y ( 1 .. 3 ) {
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

  $this->SetCellValue( 1, 1, "Custom editor" );
  $this->SetCellValue( 1, 2, "Some value" );
  $this->SetCellEditor( 1, 2, MyCellEditor->new );
  $this->SetReadOnly( 1, 2, 0 );

  $this->SetCellValue( 1, 4, "Custom renderer" );
  $this->SetCellValue( 1, 5, "SoMe TeXt!" );
  $this->SetCellRenderer( 1, 5, MyCellRenderer->new );
  $this->SetReadOnly( 1, 5, 0 );

=cut

  return $this;
}

package MyCellRenderer;

use strict;
use base 'Wx::PlGridCellRenderer';
use Wx qw(wxBLACK_PEN wxWHITE_BRUSH);

sub Draw {
  my( $self, $grid, $attr, $dc, $rect, $row, $col, $sel ) = ( shift, @_ );

  $self->SUPER::Draw( @_ );

  $dc->SetPen( wxBLACK_PEN );
  $dc->SetBrush( wxWHITE_BRUSH );
  $dc->DrawEllipse( $rect->x, $rect->y, $rect->width, $rect->height );
  $dc->DrawText( $grid->GetCellValue( $row, $col ), $rect->x, $rect->y );
}

sub Clone {
  my $self = shift;

  return $self->new;
}

package Wx::GridWindow;

use base 'Wx::Grid';

package MyCellEditor;

use strict;
use base 'Wx::PlGridCellEditor';

sub new {
  my $class = shift;
  my $self = $class->SUPER::new;

  return $self;
}

sub Create {
  my( $self, $parent, $id, $evthandler ) = @_;

  $self->{text_ctrl} = Wx::TextCtrl->new( $parent, $id, 'Default value' );

  Wx::LogMessage( 'Create called' );
}

sub Destroy {
  my $self = shift;

  $self->{text_ctrl}->Destroy if $self->{text_ctrl};
}

sub SetSize {
  my( $self, $size ) = @_;

  $self->{text_ctrl}->SetSize( $size );

  Wx::LogMessage( 'SetSize called' );
}

sub Show {
  my( $self, $show, $attr ) = @_;

  $self->{text_ctrl}->Show( $show );

  Wx::LogMessage( 'Show called' );
}

sub EndEdit {
  my( $self, $row, $col, $grid ) = @_;

  my $value = '>> ' . $self->{text_ctrl}->GetValue . ' <<';
  my $oldValue = $grid->GetCellValue( $row, $col );

  my $changed =  $value ne $oldValue;

  if( $changed ) { $grid->SetCellValue( $row, $col, $value ) }

  Wx::LogMessage( 'EndEdit called' );

  return $changed;
}

1;

# local variables:
# mode: cperl
# end:
