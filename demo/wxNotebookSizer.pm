#############################################################################
## Name:        wxNotebookSizer.pm
## Purpose:     wxPerl demo helper for Wx::NotebookSizer
## Author:      Mattia Barbon
## Modified by:
## Created:      9/ 6/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package NotebookSizerDemo;

sub window {
  shift;
  my $parent = shift;

  my $dialog = NBSDemoWin->new( $parent );
  $dialog->ShowModal;
  $dialog->Destroy;

  return undef;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::NotebookSizer</title>
</head>
<body>
<h3>Wx::NotebookSizer</h3>

<p>
  Wx::NotebookSizer is peculiar among sizers as you don't add childrens to
  it, and it queries the notebook for its childrens. Another special thing
  about notebook sizers is that a page size is taken into account
  only if that page has a sizer attached to it.
</p>
</body>
</html>
EOT
}

package NBSDemoWin;

use strict;
use base qw(Wx::Dialog);
use Wx qw(:sizer wxDEFAULT_DIALOG_STYLE wxRESIZE_BORDER
          wxDefaultPosition wxDefaultSize);
use Wx::Html;

sub new {
  my $class = shift;
  # we want it resizeable
  my $this = $class->SUPER::new( undef, -1, 'Wx::NotebookSizer',
                                 wxDefaultPosition, wxDefaultSize,
                                 wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER );

  my $top_sizer = Wx::BoxSizer->new( wxHORIZONTAL );

  my $notebook = Wx::Notebook->new( $this, -1 );
  my $nbsizer = Wx::NotebookSizer->new( $notebook );

  # each Wx::Notebook page needs to have a sizer if you want
  # to use Wx::NotebookSizer
  my $page1_sz = Wx::BoxSizer->new( wxHORIZONTAL );
  my $page1 = Wx::HtmlWindow->new( $notebook, -1, wxDefaultPosition,
                                   [200, 100] );
  $page1->SetPage( <<EOT );
<html>
<head><title>A page</title></head>
<body>
  <b>Bold</b> <i>Italic</i><br>
  <pre>
    Fixed
  width
text
  </pre>
</body>
</html>
EOT
  $page1_sz->Add( $page1, 1, wxGROW );
  $notebook->AddPage( $page1, 'HtmlWindow' );

  # another page
  my $page2_sz = Wx::BoxSizer->new( wxHORIZONTAL );
  my $page2 = Wx::Button->new( $notebook, -1, "I'm a big button...",
                               wxDefaultPosition, [100, 100] );
  $page2_sz->Add( $page2, 0, wxALL, 5 );
  $notebook->AddPage( $page2, 'Button' );
  #$notebook->SetSizer( $nbsizer );

  $top_sizer->Add( $nbsizer, 1, wxGROW );

  $this->SetAutoLayout( 1 );
  $this->SetSizer( $top_sizer );
  $top_sizer->Fit( $this );
  $top_sizer->SetSizeHints( $this );

  return $this;
}

1;

# local variables:
# mode: cperl
# end:

