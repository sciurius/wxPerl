#############################################################################
## Name:        wxFlexGridSizer.pm
## Purpose:     wxPerl demo helper for Wx::FlexGridSizer
## Author:      Mattia Barbon
## Modified by:
## Created:      3/ 7/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package FlexGridSizerDemo;

use strict;

sub window {
  shift;
  my $parent = shift;

  my $dialog = FGSDemoWindow->new( $parent );
  $dialog->ShowModal;
  $dialog->Destroy;

  return undef;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::FlexGridSizer
</head>
<body>
<h3>Wx::FlexGridSizer</h3>

<p>
  This sizer lays out windows in a grid much like Wx::GridSizer,
  except that you can use Add/RemoveGrowableRow/Col to mark
  rows and columns as growable.
</p>

</body>
</html>
EOT
}

package FGSDemoWindow;

use strict;
use base qw(Wx::Dialog);
use Wx qw(:sizer wxDefaultPosition wxDefaultSize
          wxDEFAULT_DIALOG_STYLE wxRESIZE_BORDER);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, "Wx::FlexGridSizer",
                                 wxDefaultPosition, wxDefaultSize,
                                 wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER );

  # top level sizer
  my $tsz = Wx::FlexGridSizer->new( 5, 5, 1, 1, );

  for my $i ( 1 .. 25 ) {
    $tsz->Add( Wx::Button->new( $this, -1, "Button $i" ),
               0, wxGROW|wxALL, 2 );
  }

  # add growable rows/columns
  $tsz->AddGrowableCol( 1 );
  $tsz->AddGrowableCol( 3 );
  $tsz->AddGrowableRow( 2 );

  # tell we want automatic layout
  $this->SetAutoLayout( 1 );
  $this->SetSizer( $tsz );
  # size the window optimally and set its minimal size
  $tsz->Fit( $this );
  $tsz->SetSizeHints( $this );

  return $this;
}

1;

# local variables:
# mode: cperl
# end:
