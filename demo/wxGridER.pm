#############################################################################
## Name:        demo/wxGridER.pm
## Purpose:     wxGrid demo: editors and renderers
## Author:      Mattia Barbon
## Modified by:
## Created:     05/06/2003
## RCS-ID:      $Id: wxGridER.pm,v 1.1 2003/06/05 17:28:10 mbarbon Exp $
## Copyright:   (c) 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package GridERDemo;

use strict;

sub window {
  shift;
  my $parent = shift;

  my $window = wxGridERDemoWindow->new( $parent );

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

package wxGridERDemoWindow;

use strict;
use base 'Wx::Grid';

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

1;

# local variables:
# mode: cperl
# end:
