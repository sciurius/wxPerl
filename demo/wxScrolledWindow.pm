#############################################################################
## Name:        demo/wxScrolledWindow.pm
## Purpose:     wxPerl demo helper for Wx::ScrollerWindow
## Author:      Mattia Barbon
## Modified by:
## Created:     18/05/2003
## RCS-ID:      $Id: wxScrolledWindow.pm,v 1.3 2004/10/19 20:28:06 mbarbon Exp $
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
  <title>Wx::ScrolledWindow</title>
</head>
<body>
<h3>Wx::ScrolledWindow</h3>

<p>
  The Wx::ScrolledWindow class manages scrolling for its client area,
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
use Wx qw(:sizer wxWHITE wxHORIZONTAL wxVERTICAL);

sub SIZE() { 1000 }

sub log_scroll_event {
  my( $event, $type ) = @_;

  Wx::LogMessage( 'Scroll %s event: orientation = %s, position = %d', $type,
                  ( ( $event->GetOrientation == wxHORIZONTAL ) ? 'horizontal' : 'vertical' ),
                  $event->GetPosition );

  # important! skip event for default processing to happen
  $event->Skip;
}

use Wx::Event qw(/EVT_SCROLLWIN_*/);

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

  EVT_SCROLLWIN_TOP( $this,
                     sub { log_scroll_event( $_[1], 'to top' ) } );
  EVT_SCROLLWIN_BOTTOM( $this,
                        sub { log_scroll_event( $_[1], 'to bottom' ) } );
  EVT_SCROLLWIN_LINEUP( $this,
                        sub { log_scroll_event( $_[1], 'a line up' ) } );
  EVT_SCROLLWIN_LINEDOWN( $this,
                          sub { log_scroll_event( $_[1], 'a line down' ) } );
  EVT_SCROLLWIN_PAGEUP( $this,
                        sub { log_scroll_event( $_[1], 'a page up' ) } );
  EVT_SCROLLWIN_PAGEDOWN( $this,
                          sub { log_scroll_event( $_[1], 'a page down' ) } );
#  EVT_SCROLLWIN_THUMBTRACK( $this,
#                            sub { log_scroll_event( $_[1], 'thumbtrack' ) } );
  EVT_SCROLLWIN_THUMBRELEASE( $this,
                              sub { log_scroll_event( $_[1], 'thumbrelease' ) } );

  return $this;
}

# this is the easiest way to use a scrolled window; it is passed a
# pre-scrolled Wx::DC. Alternatively derived classes may catch
# paint events and call ->PrepareDC to pre-scroll the DC
use Wx qw(wxSOLID wxTRANSPARENT_PEN wxBLACK_PEN);

sub OnDraw {
  my( $this, $dc ) = @_;

  $dc->SetPen( wxBLACK_PEN );

  for ( 0 .. 10 ) {
    $dc->DrawLine( 0, $_ * 100, SIZE, $_ * 100 );
    $dc->DrawLine( $_ * 100, 0, $_ * 100, SIZE );
  }

  $dc->SetPen( wxTRANSPARENT_PEN );

  for my $x ( 0 .. 9 ) {
      for my $y ( 0 .. 9 ) {
          my $c = 255 - ( $x + $y ) * 255 / 18;

          $dc->SetBrush( Wx::Brush->new( Wx::Colour->new( $c, $c, $c ),
                                         wxSOLID ) );

          $dc->DrawRectangle( $x * 100 + 1,  $y * 100 + 1,
                              99, 99 );
      }
  }
}

1;
