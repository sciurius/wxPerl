#############################################################################
## Name:        ext/socket/XS/SocketClient.xs
## Purpose:     XS for Wx::SocketClient
## Author:      Graciliano M. P.
## Created:     27/02/2003
## RCS-ID:      $Id: SocketClient.xs,v 1.2 2004/10/19 20:28:11 mbarbon Exp $
## Copyright:   (c) 2003 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::SocketClient

wxSocketClient*
wxSocketClient::new( style = 0 )
    long style
  CODE:
    RETVAL = new wxPliSocketClient( CLASS , style ) ;
  OUTPUT: RETVAL

bool
wxSocketClient::Connect( host , port , wait = 1 )
    wxString host
    wxString port
    bool wait
  CODE:
    wxIPV4address addr ;
    addr.Hostname(host) ;
    addr.Service(port) ;
    RETVAL = THIS->Connect( addr , wait ) ;
  OUTPUT: RETVAL



