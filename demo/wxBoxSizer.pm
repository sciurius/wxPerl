#############################################################################
## Name:        wxBoxSizer.pm
## Purpose:     wxPerl demo helper for Wx::BoxSizer and Wx::StaticBoxSizer
## Author:      Mattia Barbon
## Modified by:
## Created:      3/ 7/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package BoxSizerDemo;

use strict;

sub window {
  shift;
  my $parent = shift;

  my $dialog = BSDemoWindow->new( $parent );
  $dialog->ShowModal;
  $dialog->Destroy;

  return undef;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::BoxSizer and Wx::StaticBoxSizer</title>
</head>
<body>
<h3>Wx::BoxSizer</h3>

<p>
  This sizer lays out windows in single rows or columns. Each item
  can have a fixed size, or a size proportional to the available space.
</p>

<p>
  A Wx::StaticBoxSizer works like a normal Wx::BoxSizer except that
  is surrounded by a static box.
</p>
</body>
</html>
EOT
}

package BSDemoWindow;

use strict;
use base qw(Wx::Dialog);
use Wx qw(:sizer wxDefaultPosition wxDefaultSize
          wxDEFAULT_DIALOG_STYLE wxRESIZE_BORDER wxID_OK);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, "Wx::BoxSizer",
                                 wxDefaultPosition, wxDefaultSize,
                                 wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER );

  # top level sizer
  my $tsz = Wx::BoxSizer->new( wxVERTICAL );

  my $fr = Wx::BoxSizer->new( wxHORIZONTAL );
  # this button is fixed size, with some border
  $fr->Add( Wx::Button->new( $this, wxID_OK, 'Close window' ), 0, wxALL, 10 );
  # this button has no border
  $fr->Add( Wx::Button->new( $this, -1, 'Button 2' ), 0, 0 );
  # this one has borders just on the top and bottom
  $fr->Add( Wx::Button->new( $this, -1, 'Button 3' ), 0, wxTOP|wxBOTTOM, 5 );

  # first row can grow vertically, and horizontally
  $tsz->Add( $fr, 1, wxGROW );
  # second row is just some space
  $tsz->Add( 10, 10, 0, wxGROW );

  my $sr = Wx::BoxSizer->new( wxHORIZONTAL );
  # these elements compete for the available horizontal space
  $sr->Add( Wx::Button->new( $this, -1, 'Button 1' ), 1, wxALL, 5 );
  $sr->Add( 1, 30, 1, 0, 0 );
  $sr->Add( Wx::Button->new( $this, -1, 'Button 2' ), 1, wxGROW|wxALL, 5 );
  # sizers can be arbitrarily nested
  my $nsz = Wx::StaticBoxSizer->new( Wx::StaticBox->new( $this, -1,
                                                       'Wx::StaticBoxSizer' ),
                                     wxVERTICAL );
  $nsz->Add( Wx::Button->new( $this, -1, 'Button 3' ), 1, wxGROW|wxALL, 5 );
  $nsz->Add( Wx::Button->new( $this, -1, 'Button 4' ), 1, wxGROW|wxALL, 5 );
  $sr->Add( $nsz, 2, wxGROW );

  # add third row
  $tsz->Add( $sr, 1, wxGROW );

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
