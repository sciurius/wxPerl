#############################################################################
## Name:        wxListCtrl.pm
## Purpose:     wxerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package SplashScreenDemo;

use strict;

use Wx qw(wxBITMAP_TYPE_JPEG);
use Wx::Event qw(EVT_BUTTON);
use Wx qw(:splashscreen);

Wx::InitAllImageHandlers();

sub window {
  shift;
  my $parent = shift;

  my $panel = Wx::Panel->new( $parent, -1 );
  my $button = Wx::Button->new( $panel, -1, 'Splash!', [ 10, 10 ] );
  my $bitmap = Wx::Bitmap->new( main::filename( 'data/logo.jpg' ),
                                                wxBITMAP_TYPE_JPEG );

  EVT_BUTTON( $panel, $button, sub {
                Wx::SplashScreen->new( $bitmap,
                                       wxSPLASH_CENTRE_ON_SCREEN|wxSPLASH_TIMEOUT,
                                       2000, $panel, -1 ); } );

  return $panel;
}

sub description {
  return <<EOT;
EOT
}

1;

# Local variables: #
# mode: cperl #
# End: #

