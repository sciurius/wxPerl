#############################################################################
## Name:        wxIE.pm
## Purpose:     wxIE minimal demo
## Author:      Graciliano M. P.
## Created:     06/02/2003
## RCS-ID:
## Copyright:   (c) 2003 Graciliano M. P.
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
  
  my $text = Wx::TextCtrl->new( $this , -1, '' , wxDefaultPosition, [200,-1] , wxTE_MULTILINE );
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
  use Wx::Event qw(EVT_SOCKET_CONNECTION) ;

  my $sock = Wx::SocketServer->new('localhost',5050,wxSOCKET_WAITALL);
  
  EVT_SOCKET_CONNECTION($this , $sock , \&onConnect ) ;
  
  my $stat = $sock->Ok ;
  $this->{TEXT}->AppendText("Ok: <$stat>\n") ;
  if (! $stat) { return ;}

}

sub onConnect {
  my ( $sock , $this , $evt ) = @_ ;

  my $client = $sock->Accept(0) ;
 
  my @lcaddr = $client->GetLocal ;
  my @praddr = $client->GetPeer ;

  $this->{TEXT}->AppendText("-------------------------\n") ;    
  $this->{TEXT}->AppendText("New Client\n") ;
  $this->{TEXT}->AppendText("  Local: <@lcaddr>\n") ;
  $this->{TEXT}->AppendText("  Peer: <@praddr>\n") ;

  $client->Write("This is a data test!\n") ;
  $client->Close ;
  $this->{TEXT}->AppendText("\n-------------------------(closed)\n") ;
}

package main;

  my( $app ) = MyApp->new();
  $app->MainLoop();

exit ;

# Local variables: #
# mode: cperl #
# End: #
