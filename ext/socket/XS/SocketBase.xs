#############################################################################
## Name:        SocketBase.xs
## Purpose:     XS for Wx::SocketBase
## Author:      Graciliano M. P.
## Created:     27/02/2003
## RCS-ID:
## Copyright:   (c) 2003 Graciliano M. P.
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################


MODULE=Wx PACKAGE=Wx::SocketBase

wxSocketBase*
wxSocketBase::new()
  CODE:
    RETVAL = new wxPlSocketBase( CLASS ) ;
  OUTPUT: RETVAL


bool
wxSocketBase::Ok()

bool
wxSocketBase::IsConnected()

bool
wxSocketBase::IsDisconnected()

bool
wxSocketBase::IsData()

long
wxSocketBase::LastCount()

void
wxSocketBase::Notify( notify )
    bool notify
    
void 
wxSocketBase::SetTimeout( seconds )
    int seconds
    
bool
wxSocketBase::Wait( seconds = -1 , millisecond = 0 )
    long seconds
    long millisecond

bool
wxSocketBase::WaitForRead( seconds = -1 , millisecond = 0 )
    long seconds
    long millisecond
    
bool
wxSocketBase::WaitForWrite( seconds = -1 , millisecond = 0 )
    long seconds
    long millisecond
    
long
wxSocketBase::Read( buf , size , leng = 0 )
    SV* buf
    long size
    long leng
  CODE:
    // Upgrade the SV to scalar if needed. If the scalar is undef can't use SvGROW.
    SvUPGRADE(buf , SVt_PV) ;
    // Tell that the scalar is string only (not integer, double, utf8...):
    SvPOK_only(buf) ;
    
    // Grow the scalar to receive the data and return a char* point:
    char* buffer = SvGROW( buf , leng + size + 2 ) ;

    // To read at the offset the user specified (works even if offset = 0):
    if ( leng > 0 ) { buffer += leng ;}

    THIS->Read( buffer , size ) ;
    int nread = THIS->LastCount() ;

    // Null-terminate the buffer, not necessary, but does not hurt:
    buffer[nread] = 0 ;
    // Tell Perl how long the string is:
    SvCUR_set( buf , leng + nread ) ;
    // Undef on read error:
    if( THIS->Error() ) XSRETURN_UNDEF ;
    // Return the amount of data read, like Perl read().
    RETVAL = nread ;
  OUTPUT: RETVAL

void
wxSocketBase::Close()

void
wxSocketBase::Discard()

bool
wxSocketBase::Error()

long
wxSocketBase::GetFlags()


void
wxSocketBase::GetLocal()
  PPCODE:
    wxIPV4address addr ;
    THIS->GetLocal( addr ) ;
    XPUSHs( sv_2mortal( newSVpvf("%s", (addr.Hostname()).c_str() ) ) );
    XPUSHs( sv_2mortal( newSVpvf("%d", addr.Service() ) ) );


void
wxSocketBase::GetPeer()
  PPCODE:
    wxIPV4address addr ;
    THIS->GetPeer( addr ) ;
    XPUSHs( sv_2mortal( newSVpvf("%s", (addr.Hostname()).c_str() ) ) );
    XPUSHs( sv_2mortal( newSVpvf("%d", addr.Service() ) ) );


void
wxSocketBase::InterruptWait()

long
wxSocketBase::LastError()

long
wxSocketBase::Peek(buf , size , leng = 0 )
    SV* buf
    long size
    long leng
  CODE:
    SvUPGRADE(buf , SVt_PV) ;
    SvPOK_only(buf) ;
    char* buffer = SvGROW( buf , leng + size + 2 ) ;
    if ( leng > 0 ) { buffer += leng ;}

    THIS->Peek( buffer , size ) ;
    int nread = THIS->LastCount() ;

    buffer[nread] = 0 ;
    SvCUR_set( buf , leng + nread ) ;
    if( THIS->Error() ) XSRETURN_UNDEF ;
    RETVAL = nread ;
  OUTPUT: RETVAL


long
wxSocketBase::ReadMsg(buf , size , leng = 0 )
    SV* buf
    long size
    long leng
  CODE:
    SvUPGRADE(buf , SVt_PV) ;
    SvPOK_only(buf) ;
    char* buffer = SvGROW( buf , leng + size + 2 ) ;
    if ( leng > 0 ) { buffer += leng ;}

    THIS->ReadMsg( buffer , size ) ;
    int nread = THIS->LastCount() ;

    buffer[nread] = 0 ;
    SvCUR_set( buf , leng + nread ) ;
    if( THIS->Error() ) XSRETURN_UNDEF ;
    RETVAL = nread ;
  OUTPUT: RETVAL


void
wxSocketBase::RestoreState()

void
wxSocketBase::SaveState()

void
wxSocketBase::SetFlags(flags)
    long flags

void
wxSocketBase::SetNotify(flags)
    long flags


long
wxSocketBase::Unread(buf , size = 0)
    SV* buf
    long size
  CODE:
    // Upgrade the SV to scalar if needed. If the scalar is undef can't use SvGROW.
    SvUPGRADE(buf , SVt_PV) ;
    // Tell that the scalar is string only (not integer, double, utf8...):
    SvPOK_only(buf) ;
    
    if ( size == 0 ) { size = SvCUR(buf) ;}
    THIS->Unread( SvPV_nolen(buf) , size ) ;
    RETVAL = THIS->LastCount() ;
  OUTPUT: RETVAL

bool
wxSocketBase::WaitForLost( seconds = -1 , millisecond = 0 )
    long seconds
    long millisecond

long
wxSocketBase::Write(buf , size = 0)
    SV* buf
    long size
  CODE:
    // Upgrade the SV to scalar if needed. If the scalar is undef can't use SvGROW.
    SvUPGRADE(buf , SVt_PV) ;
    // Tell that the scalar is string only (not integer, double, utf8...):
    SvPOK_only(buf) ;

    if ( size == 0 ) { size = SvCUR(buf) ;}
    THIS->Write( SvPV_nolen(buf) , size ) ;
    RETVAL = THIS->LastCount() ;
  OUTPUT: RETVAL

long
wxSocketBase::WriteMsg(buf , size = 0)
    SV* buf
    long size
  CODE:
    // Upgrade the SV to scalar if needed. If the scalar is undef can't use SvGROW.
    SvUPGRADE(buf , SVt_PV) ;
    // Tell that the scalar is string only (not integer, double, utf8...):
    SvPOK_only(buf) ;
    
    if ( size == 0 ) { size = SvCUR(buf) ;}
    THIS->WriteMsg( SvPV_nolen(buf) , size ) ;
    RETVAL = THIS->LastCount() ;
  OUTPUT: RETVAL


void
wxSocketBase::SetEventHandler( evthnd , id = -1)
    Wx_EvtHandler* evthnd
    int id
  CODE:
    THIS->SetEventHandler( *evthnd , id );


