#############################################################################
## Name:        demo/wxGridTable.pm
## Purpose:     wxGrid demo: custom wxGridTable
## Author:      Mattia Barbon
## Modified by:
## Created:     05/08/2003
## RCS-ID:      $Id: wxGridTable.pm,v 1.2 2003/08/15 21:53:17 mbarbon Exp $
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

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $table = MyGridTable->new;

  $this->SetTable( $table );

  return $this;
}

1;

# local variables:
# mode: cperl
# end:
