#############################################################################
## Name:        demo/wxScrolledWindow.pm
## Purpose:     wxPerl demo helper for Wx::ScrollerWindow
## Author:      Mattia Barbon
## Modified by:
## Created:     18/ 5/2003
## RCS-ID:      $Id: wxScrolledWindow.pm,v 1.1 2003/05/18 15:04:11 mbarbon Exp $
## Copyright:   (c) 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package ScrolledWindowDemo;

use strict;

sub window {
  shift;
  my $parent = shift;

  return SWDemoWindow->new( $parent );
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::ScrolledWindow
</head>
<body>
<h3>Wx::ScrolledWindow</h3>

<p>
  The wxScrolledWindow class manages scrolling for its client area,
  transforming the coordinates according to the scrollbar positions, and
  setting the scroll positions, thumb sizes and ranges according to the
  area in view.
</p>

<p>
  In order to draw in a scrolled window you should override its
  OnDraw method.
</p>

</body>
</html>
EOT
}

package SWDemoWindow;

use strict;
use base qw(Wx::ScrolledWindow);
use Wx qw(:sizer wxWHITE);

sub SIZE() { 1000 }

sub new {
  my $class = shift;
  my $parent = shift;
  my $this = $class->SUPER::new( $parent, -1 );

  # set the total area the scrolled window will show: note that at any
  # given time the window will only show a part of it
  $this->SetVirtualSize( SIZE, SIZE );
  # set the numer of pixels the window will scroll at a time
  $this->SetScrollRate( 1, 1 );


  $this->SetBackgroundColour( wxWHITE );

  return $this;
}

# this is the easiest way to use a scrolled window; it is passed a
# pre-scrolled Wx::DC. Alternatively derived classes may catch
# paint events and call ->PrepareDC to pre-scroll the DC
sub OnDraw {
  my( $this, $dc ) = @_;

  for ( 1 .. 9 ) {
    $dc->DrawLine( 0, $_ * 100, SIZE, $_ * 100 );
    $dc->DrawLine( $_ * 100, 0, $_ * 100, SIZE );
  }
}

1;
