#############################################################################
## Name:        Socket.pm
## Purpose:     Wx::Socket
## Author:      Graciliano M. P.
## Modified by:
## Created:     27/02/2003
## RCS-ID:      
## Copyright:   (c) 2003 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Socket ;

use Wx;
use strict;

use vars qw($VERSION);

$VERSION = '0.01';

Wx::wx_boot( 'Wx::Socket', $VERSION );

no strict ;
package Wx::SocketClient ; @ISA = qw(Wx::SocketBase) ;
package Wx::SocketServer ; @ISA = qw(Wx::SocketBase) ;
package Wx::SocketBase ; @ISA = qw(Wx::Socket Wx::Object) ;
package Wx::SocketEvent ; @ISA = qw(Wx::Event) ;
use strict ;

#####################
# WX::SOCKET::EVENT #
#####################

package Wx::Socket::Event ;
use Wx qw(wxSOCKET_INPUT_FLAG wxSOCKET_OUTPUT_FLAG wxSOCKET_CONNECTION_FLAG
          wxSOCKET_LOST_FLAG wxSOCKET_INPUT wxSOCKET_OUTPUT
          wxSOCKET_CONNECTION wxSOCKET_LOST) ;

my $EVTID ;

sub EVT_SOCKET($$$)             { $_[0]->Connect($_[1] , -1, &Wx::wxEVT_SOCKET , $_[2] ); }
sub EVT_SOCKET_ALL($$$)        { &MAKE_EVT('all',@_) ;}
sub EVT_SOCKET_INPUT($$$)      { &MAKE_EVT(wxSOCKET_INPUT,@_) ;}
sub EVT_SOCKET_OUTPUT($$$)     { &MAKE_EVT(wxSOCKET_OUTPUT,@_) ;}
sub EVT_SOCKET_CONNECTION($$$) { &MAKE_EVT(wxSOCKET_CONNECTION,@_) ;}
sub EVT_SOCKET_LOST($$$)       { &MAKE_EVT(wxSOCKET_LOST,@_) ;}

sub MAKE_EVT {
  my $type = shift ;
  &ENABLE_SKEVT($_[1] , $_[0] , $_[2]) ;
  my $sock = $_[1] ;
  $sock->{EVT}{SUB}{$type} = $_[2] ;
  if (!$sock->{EVT}{CONNECT}) {
    $_[0]->Connect( $_[0] , $_[1]->{EVT}{ID} , &Wx::wxEVT_SOCKET ,
                    sub{ &CHECK_EVT_TYPE($sock,@_) } );
    $sock->{EVT}{CONNECT} = 1 ;
  }
}

sub ENABLE_SKEVT {
  my ( $sock , $parent ) = @_ ;
  if ( $sock->{EVT}{ENABLE} ) { return ;}
  $sock->{EVT}{ID} = ++$EVTID ;
  $sock->SetEventHandler($parent, $sock->{EVT}{ID}) ;
  $sock->SetNotify(wxSOCKET_INPUT_FLAG|wxSOCKET_OUTPUT_FLAG|
                   wxSOCKET_CONNECTION_FLAG|wxSOCKET_LOST_FLAG) ;
  $sock->Notify(1) ;
  $sock->{EVT}{ENABLE} = 1 ;
}

sub CHECK_EVT_TYPE {
  my ( $sock , $this , $evt ) = @_ ;
  #print "$sock\n" ;
  my $evt_type = $evt->GetSocketEvent ;
  my $sub = $sock->{EVT}{SUB}{$evt_type} || $sock->{EVT}{SUB}{all} ;
  if ($sub) { return &$sub($sock , $this , $evt) ;}
  return( undef ) ;
}

#######
# END #
#######

1;

__END__

=head1 NAME

Wx::Socket - wxSocket* classes

=head1 USAGE

  use Wx qw(:socket) ;
  use Wx::Event qw(EVT_SOCKET_INPUT EVT_SOCKET_LOST) ;
  use Wx::Event qw(EVT_SOCKET_CONNECTION) ;

  ##########
  # CLIENT #
  ##########

  my $sock = Wx::SocketClient->new(wxSOCKET_WAITALL);

  EVT_SOCKET_INPUT($parent , $sock , \&onInput ) ;
  EVT_SOCKET_LOST($parent , $sock , \&onClose ) ;

  $sock->Connect('localhost',5050) ;

  if (! $sock->IsConnected ) { print "ERROR\n" ;}

  sub onInput {
    my ( $sock , $this , $evt ) = @_ ;
    my $buffer ;
    $sock->Read($buffer , 1024 , length($buffer) ) ;
  }

  ##########
  # SERVER #
  ##########

  my $sock = Wx::SocketServer->new('localhost',5050,wxSOCKET_WAITALL);

  EVT_SOCKET_CONNECTION($parent , $sock , \&onConnect ) ;

  if ( !$sock->Ok ) { print "ERROR\n" ;}

  sub onConnect {
    my ( $sock , $this , $evt ) = @_ ;
    my $client = $sock->Accept(0) ;

    my ($local_host,$local_port) = $client->GetLocal ;
    my ($peer_host,$peer_port) = $client->GetPeer ;

    $client->Write("This is a data test!\n") ;

    ... or ...

    ## Specially if has \0 inside $data.
    $client->Write( $data , length($data) ) ; 

    $client->Close ;
  }

=head1 METHODS

All the methods work as in wxWindows (see the documentation).

The read functions (Read,ReadMsg,Peek) have 3 arguments,
like the Perl read() function:

  ## To append data:
  $sock->Read($buffer , 1024 , length($buffer) ) ;

  ... or ...

  ## To write in the begin on the $buffer:
  $sock->Read($buffer , 1024) ;

The write functions (Write,WriteMsg,Unread) can be used with 2 or 1 arguments:

  ## Got for simple strings:
  $client->Write("This is a data test!\n") ;

  ## For data (specially binary):
  my $data = "aaa\0bbb\0ccc" ;
  $client->Write($data , length($data)) ;

=head1 EVENTS

  The events are:

    EVT_SOCKET
    EVT_SOCKET_ALL
    EVT_SOCKET_INPUT
    EVT_SOCKET_OUTPUT
    EVT_SOCKET_CONNECTION
    EVT_SOCKET_LOST

The EVT_SOCKET is the original, used in the normal wxWindows.
I have added the others.

Note that the original events of wxSocketClient & wxSocketServer
are different than other objects.
First you need to set the event handler:

    $sock->SetEventHandler($parent, $sock->{EVT}{ID}) ;

Then you set what types of event you want to receive:

    ## this select all.
    $sock->SetNotify(wxSOCKET_INPUT_FLAG|wxSOCKET_OUTPUT_FLAG|
                     wxSOCKET_CONNECTION_FLAG|wxSOCKET_LOST_FLAG) ; 

Enable the event notify:

    $sock->Notify(1) ;

And only after this use:

    EVT_SOCKET($parent , sub{...} )

To make the events easier, all the proccess is automatic, and you just use:

    EVT_SOCKET_INPUT($parent , $socket , sub{...} )
    EVT_SOCKET_OUTPUT($parent , $socket , sub{...} )
    EVT_SOCKET_CONNECTION($parent , $socket , sub{...} )
    EVT_SOCKET_LOST($parent , $socket , sub{...} )

    ## This is for the events not used yet by the above:
    EVT_SOCKET_ALL($parent , $socket , sub{...} )

** The new way is better to handle more than one socket in the same time too.
   Take a look in the demos.

=head1 SEE ALSO

L<Wx>.

See the wxDocumentation too, at L<http://www.wxwindows.org/>

=head1 AUTHOR

Graciliano M. P. <gm@virtuasites.com.br>

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

