#############################################################################
## Name:        wxFileSystem.pm
## Purpose:     wxFileSystem demo
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package FileSystemDemo;

use Wx qw(:textctrl wxDefaultPosition wxDefaultSize);
use Wx::FS;

Wx::FileSystem::AddHandler( Wx::ZipFSHandler->new() );

sub window {
  shift;

  my $parent = shift;

  my $t = Wx::TextCtrl->new( $parent, -1, '', wxDefaultPosition,
                             wxDefaultSize, wxTE_MULTILINE );

  $t->AppendText( "Listing files in 'fs.zip/dir/subdir' ( 4 files )\n" );

  my $fs = Wx::FileSystem->new();
  my $name;

  $fs->ChangePathTo( main::filename( 'data/fs.zip' ) . "#zip:dir/", 1 );
  $t->AppendText( 'Path: ' . $fs->GetPath . "\n" );

  $name = $fs->FindFirst( "subdir/*" );
  while( $name ) {
    $t->AppendText( $name . "\n" );
    $name = $fs->FindNext();
  };

  $t->AppendText( "\nRetrieving attributes for a file\n" );

  my $file = $fs->OpenFile( "file2.txt" );

  return $t unless $file;

  $t->AppendText( "Anchor:       " . $file->GetAnchor() . "\n" );
  $t->AppendText( "Location:     " . $file->GetLocation() . "\n" );
  $t->AppendText( "MIME:         " . $file->GetMimeType() . "\n" );
#  $t->AppendText( "Modification: " . $file->GetModificationTime() . "\n" );

  $t->AppendText( "\nContent:\n\n--start--\n" );
  my $stream = $file->GetStream();
  my( $i, $line );

  while( defined( $line = <$stream> ) ) {
      ++$i;
      $t->AppendText( "$i: $line" );
  }
  $t->AppendText( "--end--\n" );

  return $t;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>wxFileSystem</title>
</head>
<body>
<h3>Wx::FileSystem, Wx::FSFile, Wx::FileSystemHandler</h3>

<p>
  these classes let you access various kinds of filesystem-like
  objects ( FTP, HTTP, ZIP, Memory ) through a simple and common
  API.
</p>

</body>
</html>
EOT
}

1;

# Local variables: #
# mode: cperl #
# End: #
