#!/usr/bin/perl
#############################################################################
## Name:        splash.pl
## Purpose:     Show how to use splash screens
## Author:      Mattia Barbon
## Modified by:
## Created:      5/ 6/2002
## RCS-ID:      $Id: splash.pl,v 1.2 2003/05/18 15:05:46 mbarbon Exp $
## Copyright:   (c) 2002-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

BEGIN {
  eval {
    require blib;
    'blib'->import;
  }
}

use Wx;

# every program must have a Wx::App-derived class
package MyApp;

use strict;
use base 'Wx::App';

# show a splash screen
use Wx qw(wxBITMAP_TYPE_JPEG wxSPLASH_CENTRE_ON_SCREEN wxSPLASH_TIMEOUT
          wxDefaultPosition wxDefaultSize wxSIMPLE_BORDER wxFRAME_TOOL_WINDOW
          wxFRAME_NO_TASKBAR wxSTAY_ON_TOP);

sub OnInit {
  Wx::InitAllImageHandlers();

  my $bitmap = Wx::Bitmap->new( 'data/logo.jpg',
                                wxBITMAP_TYPE_JPEG );

  Wx::SplashScreen->new( $bitmap,
                         wxSPLASH_CENTRE_ON_SCREEN|wxSPLASH_TIMEOUT,
                         10000, undef, -1, wxDefaultPosition, wxDefaultSize,
                         wxSIMPLE_BORDER|wxFRAME_NO_TASKBAR|wxSTAY_ON_TOP );

  return 1;
}

package main;

my $app;

BEGIN {
  # create an instance of the Wx::App-derived class
  $app = MyApp->new();
}

package MyApp;

sleep 5; # emulate the dealy for a loing initialization

# this contains the real intialization code
sub MyInit {
  my( $this ) = @_;

  # create new MyFrame
  my( $frame ) = MyFrame->new( "Close me!",
			       Wx::Point->new( 50, 50 ),
			       Wx::Size->new( 450, 350 )
                             );

  # set it as top window (so the app will automatically close when
  # the last top window is closed)
  $this->SetTopWindow( $frame );
  # show the frame
  $frame->Show( 1 );

  1;
}

package MyFrame;

use strict;
use base qw(Wx::Frame);

# Parameters: title, position, size
sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );

  # load an icon and set it as frame icon
  $this->SetIcon( Wx::GetWxPerlIcon() );

  $this;
}

# called when the user selects the 'Exit' menu item
sub OnQuit {
  my( $this, $event ) = @_;

  # closes the frame
  $this->Close( 1 );
}

package main;

# call the initialization function
$app->MyInit();
# start processing events
$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #

__END__

=for description

<html>
<head>
  <title>Splash screen example</title>
</head>
<body>
<h3>Splash screen</h3>

<p>
  The structure of this example is a bit peculiar: the goal is to show the
  splash screen as soon as possible. For this MyApp::OnInit just creates the
  splash screen, and the real application window is created in another
  function, called just before entering the main loop.
</p>

</body>
</html>

=back

