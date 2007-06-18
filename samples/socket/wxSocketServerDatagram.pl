#############################################################################
## Name:        samples/socket/wxSocketServerDatagram.pl
## Purpose:     wxDatagramSocket demo
## Author:      Graciliano M. P., Mattia Barbon
## Created:     07/02/2004
## RCS-ID:      $Id$
## Copyright:   (c) 2004 Graciliano M. P., Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;
use Wx::Socket ;

package MyApp;

  use vars qw(@ISA);
  @ISA=qw(Wx::App);

sub OnInit {
  my( $this ) = @_;

  my( $frame ) = MyFrame->new( "wxSocket Minimal demo",
			       Wx::Point->new( 50, 50 ),
			       Wx::Size->new( 450, 350 )
                             );

  $this->SetTopWindow( $frame );
  $frame->Show( 1 );

  1;
}

package MyFrame;
  use vars qw(@ISA);
  @ISA=qw(Wx::Frame);

  use Wx qw(:sizer wxTE_MULTILINE );
  use Wx::Event qw(EVT_BUTTON) ;

  use Wx qw(wxDefaultPosition wxDefaultSize wxDEFAULT wxNORMAL);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );

  my $top_s = Wx::BoxSizer->new( wxVERTICAL );

  my $text = Wx::TextCtrl->new( $this , -1, '' , wxDefaultPosition, [200,-1] , wxTE_MULTILINE|wxTE_RICH2 );
  my $button = Wx::Button->new( $this, -1, 'Start' );

  $this->{TEXT} = $text ;

  $top_s->Add( $text , 1, wxGROW|wxALL, 5 );
  $top_s->Add( $button , 0, wxGROW|wxALL, 0);

  $this->SetSizer( $top_s );
  $this->SetAutoLayout( 1 );

  EVT_BUTTON( $this, $button, \&OnConnect );

  return( $this ) ;

  $this;
}


#############
# ONCONNECT #
#############

sub OnConnect {
  my $this = shift ;

  use Wx qw(:socket) ;
  use Wx::Event qw(EVT_SOCKET_INPUT) ;

  my $addr = Wx::IPV4address->new;
  $addr->SetAnyAddress;
  $addr->SetService( 4444 );
  my $sock = Wx::DatagramSocket->new( $addr );

  EVT_SOCKET_INPUT($this , $sock , \&onConnect ) ;

  my $stat = $sock->Ok ;
  $this->{TEXT}->AppendText("Ok: <$stat>\n") ;
  if (! $stat) { return ;}

}

sub onConnect {
  my ( $sock , $this , $evt ) = @_ ;

  my $addr = Wx::IPV4address->new;
  my $buf = '';
  $sock->RecvFrom($addr, $buf, 1000) ;
  my $addr_str = $addr->GetHostname . ' ' . $addr->GetService;

  $this->{TEXT}->AppendText("-------------------------\n") ;    
  $this->{TEXT}->AppendText("New Client\n") ;
  $this->{TEXT}->AppendText("  Peer: <$addr_str>\n") ;

  $sock->SendTo($addr, "This is a data test!\n", 21) ;
  $this->{TEXT}->AppendText("\n-------------------------(closed)\n") ;
}

package main;

  my( $app ) = MyApp->new();
  $app->MainLoop();

exit ;

# Local variables: #
# mode: cperl #
# End: #
