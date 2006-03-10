#############################################################################
## Name:        demo/wxMediaCtrl.pm
## Purpose:     wxPerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     03/04/2006
## RCS-ID:      $Id: wxMediaCtrl.pm,v 1.1 2006/03/10 19:25:33 mbarbon Exp $
## Copyright:   (c) 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package MediaCtrlDemo;

sub window {
  shift;
  my $parent = shift;

  my $window = MediaCtrlDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::MediaCtrl</title>
</head>
<body>
<h3>Wx::MediaCtrl</h3>

</body>
</html>
EOT
}

package MediaCtrlDemoWin;

use base qw(Wx::Panel);

use Wx;
use Wx::Media;

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  $media = Wx::MediaCtrl->new;
  Wx::LogMessage( $media->Create( $this, -1, '', [-1,-1], [-1,-1], 0,
#                                  'wxAMMediaBackend'
                                  ) );
  $media->SetSize( 500, 500 );
  Wx::LogMessage( $media );
  $media->Show( 1 );
  $media->ShowPlayerControls;
  $media->LoadFile( 'C:\WINNT\clock.avi' );
  Wx::LogMessage( 'b %s', $media->Play );

  return $this;
}

1;

# Local variables: #
# mode: cperl #
# End: #
