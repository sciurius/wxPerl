#############################################################################
## Name:        SplashScreen.pm
## Purpose:     Wx::SplashScreen classes
## Author:      Mattia Barbon
## Modified by:
## Created:     12/10/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::SplashScreen;

use strict;
use vars qw(@ISA);

if( $Wx::_wx_version < 2.003001 ) {
  @ISA = qw(Wx::_SplashScreenPerl);

  *Wx::wxSPLASH_CENTRE_ON_PARENT = sub { 0x01 };
  *Wx::wxSPLASH_CENTRE_ON_SCREEN = sub { 0x02 };
  *Wx::wxSPLASH_NO_CENTRE = sub { 0x00 };
  *Wx::wxSPLASH_TIMEOUT = sub { 0x04 };
  *Wx::wxSPLASH_NO_TIMEOUT = sub { 0x00 };
} else {
  @ISA = qw(Wx::_SplashScreenCpp);
}

package Wx::_SplashScreenPerl;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Frame);

use Wx qw(wxSIMPLE_BORDER wxFRAME_FLOAT_ON_PARENT wxFRAME_TOOL_WINDOW
          wxDefaultPosition wxDefaultSize);
use Wx::Event qw(EVT_CLOSE EVT_TIMER);

use Wx qw(:splashscreen);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[3], $_[4] || -1, '',
                                 $_[5] || wxDefaultPosition,
                                 $_[6] || wxDefaultSize,
                                 $_[7] ||
                                 (wxSIMPLE_BORDER|wxFRAME_TOOL_WINDOW) );

  @{$this}{qw(BITMAP STYLE MILLISECONDS)} = ( $_[0], $_[1] || 0,
                                              $_[2] || 1000 );
  $this->{TIMER} = Wx::Timer->new( $this, -1 );

  my $bitmap = $this->{BITMAP};
  my $style = $this->{STYLE};

  my $sbmp = Wx::_SplashScreenPerlWindow->new( $this, -1, $bitmap, [0,0],
                                               [$bitmap->GetWidth,
                                                $bitmap->GetHeight] );

  $this->SetClientSize( $bitmap->GetWidth, $bitmap->GetHeight );

  if( $style & wxSPLASH_CENTRE_ON_PARENT ) { $this->CentreOnParent }
  if( $style & wxSPLASH_CENTRE_ON_SCREEN ) { $this->CentreOnScreen }

  if( $style & wxSPLASH_TIMEOUT ) {
    $this->{TIMER}->Start( $this->{MILLISECONDS}, 1 );
  }

  EVT_CLOSE( $this, \&OnCloseWindow );
  EVT_TIMER( $this, -1, \&OnTimer );

  $this->Show( 1 );
  $sbmp->SetFocus();

  return $this;
}

sub OnCloseWindow {
  my( $this, $event ) = @_;

  $this->{TIMER}->Stop;
  $this->{TIMER}->Destroy;

  $this->Destroy;
}

sub OnTimer {
  my( $this, $event ) = @_;

  $this->Close( 1 );
}

package Wx::_SplashScreenPerlWindow;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Window);

use Wx qw(wxNullBitmap);
use Wx::Event qw(EVT_ERASE_BACKGROUND EVT_CHAR EVT_LEFT_DOWN);

sub new {
  my $class = shift;
  my $bitmap = splice @_, 2, 1;
  my $this = $class->SUPER::new( @_ );

  $this->{BITMAP} = $bitmap;

  EVT_ERASE_BACKGROUND( $this, \&OnEraseBackground );
  EVT_CHAR( $this, \&OnChar );
  EVT_LEFT_DOWN( $this, \&OnMouse );

  return $this;
}

sub OnMouse {
  my( $this, $event ) = @_;

  $this->GetParent->Close( 1 );
}

sub OnChar {
  my( $this, $event ) = @_;

  $this->GetParent->Close( 1 );
}

sub OnEraseBackground {
  my( $this, $event ) = @_;
  my $dc = Wx::ClientDC->new( $this );

  DrawBitmap( $dc, $this->{BITMAP} );
}

sub DrawBitmap {
  my( $dc, $bitmap ) = @_;
  my $memdc = Wx::MemoryDC->new;

  $memdc->SelectObject( $bitmap );
  $dc->Blit( 0, 0, $bitmap->GetWidth, $bitmap->GetHeight, $memdc, 0, 0 );
  $memdc->SelectObject( wxNullBitmap );
}

package Wx::_SplashScreenCpp;

use vars qw(@ISA); @ISA = qw(Wx::Frame);

1;

# Local variables: #
# mode: cperl #
# End: #

