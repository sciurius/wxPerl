#############################################################################
## Name:        XRC.pm
## Purpose:     wxWindows' XML Resources demo
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::XRC;

package XRC;

use strict;

sub window {
  shift;
  my $parent = shift;

  # initialize new resource object
  my $rs = Wx::XmlResource->new;
  $rs->InitAllHandlers;
  $rs->Load( main::filename( 'data/resource.xrc' ) );

  my $panel = $rs->LoadPanel( $parent, 'mypanel' );
  $panel->Layout();

  return $panel;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>wxWindows XML Resources</title>
</head>
<body>
<h3>wxWindows XML Resources</h3>

<p>
  Sorry, there is no documentation (yet)...
</p>
</body>
</html>
EOT
}

1;

# Local variables: #
# mode: cperl #
# End: #
