#############################################################################
## Name:        demo/wxClipboard.pm
## Purpose:     Clipboard demo
## Author:      Mattia Barbon
## Modified by:
## Created:     12/09/2001
## RCS-ID:      $Id: wxClipboard.pm,v 1.7 2004/10/19 20:28:06 mbarbon Exp $
## Copyright:   (c) 2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::DND;

package ClipboardDemo;

use strict;

sub window {
  shift;
  my $parent = shift;

  Wx::InitAllImageHandlers; # for wxGTK
  return ClipboardDemoWindow->new( $parent );
}

sub description {
    return <<EOT;
<html>
<head>
  <title>Wx::Clipboard</title>
</head>
<body>
<h3>Wx::Clipboard</h3>

<p>
  This class is used to interact with the system clipboard.
</p>

</body>
</html>
EOT
}

package ClipboardDemoWindow;

use strict;
use Wx qw(wxTheClipboard wxNullBitmap);
use Wx::Event qw(EVT_BUTTON);
require DataObjects;

use vars qw(@ISA); @ISA = qw(Wx::Panel);

use Wx qw(:brush :pen :bitmap :dnd);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $copy = Wx::Button->new( $this, -1, 'Copy Text', [ 20, 20 ] );
  my $paste = Wx::Button->new( $this, -1, 'Paste', [ 120, 20 ] );
  my $copy_im = Wx::Button->new( $this, -1, 'Copy Image', [ 20, 50 ] );

  $this->{TEXT} = Wx::StaticText->new( $this, -1, '', [ 220, 20 ] );
  $this->{IMAGE} = Wx::StaticBitmap->new( $this, -1, wxNullBitmap,
                                          [ 220, 150 ], [ 100, 100 ] );

  EVT_BUTTON( $this, $copy, \&OnCopyText );
  EVT_BUTTON( $this, $paste, \&OnPaste );
  EVT_BUTTON( $this, $copy_im, \&OnCopyImage );
  # unfortunately pasting a composite data object segfaults
  # on wx 2.2/wxGTK
  my $copy_both = Wx::Button->new( $this, -1, 'Copy Both', [ 20, 80 ] );
  EVT_BUTTON( $this, $copy_both, \&OnCopyBoth );

  # wxTheClipboard->UsePrimarySelection( 0 );

  return $this;
}

sub text { $_[0]->{TEXT} }
sub image { $_[0]->{IMAGE} }

sub _Copy {
  my $data = shift;

  wxTheClipboard->Open;
  wxTheClipboard->SetData( $data );
  wxTheClipboard->Close;
}

sub OnCopyText {
  my( $this, $event ) = @_;
  my $data = DataObjects::GetTextDataObject();

  _Copy( $data );
  Wx::LogMessage( "Copied some text" );
}

sub OnCopyImage {
  my( $this, $event ) = @_;
  my $data = DataObjects::GetBitmapDataObject();

  _Copy( $data );
  Wx::LogMessage( "Copied an image" );
}

sub OnCopyBoth {
  my( $this, $event ) = @_;
  my $data = DataObjects::GetBothDataObject();

  _Copy( $data );
  Wx::LogMessage( "Copied both text and image" );
}

sub OnPaste {
  my( $this, $event ) = @_;

  wxTheClipboard->Open;

  my $text = '';
  if( wxTheClipboard->IsSupported( wxDF_TEXT ) ) {
    my $data = Wx::TextDataObject->new;
    my $ok = wxTheClipboard->GetData( $data );
    if( $ok ) {
      Wx::LogMessage( "Pasted text data" );
      $text = $data->GetText;
    } else {
      Wx::LogMessage( "Error pasting text data" );
      $text = '';
    }
  }
  $this->text->SetLabel( $text );

  my $bitmap = wxNullBitmap;
  if( wxTheClipboard->IsSupported( wxDF_BITMAP ) ) {
    my $data = Wx::BitmapDataObject->new;
    my $ok = wxTheClipboard->GetData( $data );
    if( $ok ) {
      Wx::LogMessage( "Pasted bitmap data" );
      $bitmap =  $data->GetBitmap;
    } else {
      Wx::LogMessage( "Error pasting bitmap data" );
      $bitmap = wxNullBitmap;
    }
  }
  $this->image->SetBitmap( $bitmap );

  wxTheClipboard->Close;
}

1;

# Local variables: #
# mode: cperl #
# End: #
