#############################################################################
## Name:        Process.xs
## Purpose:     XS for Wx::Process and Wx::ProcessEvent and Wx::Execute
## Author:      Mattia Barbon
## Modified by:
## Created:     11/ 2/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/process.h>
#include "cpp/process.h"
#include <wx/utils.h>

MODULE=Wx PACKAGE=Wx::ProcessEvent

Wx_ProcessEvent*
Wx_ProcessEvent::new( id = 0, pid = 0, status = 0 )
    int id
    int pid
    int status

int
Wx_ProcessEvent::GetPid()

int
Wx_ProcessEvent::GetExitCode()

MODULE=Wx PACKAGE=Wx::Process

Wx_Process*
Wx_Process::new( parent = 0, id = -1 )
    Wx_EvtHandler* parent
    int id
  CODE:
    RETVAL = new wxPliProcess( CLASS, parent, id );
  OUTPUT:
    RETVAL

void
Wx_Process::Destroy()
  CODE:
    delete THIS;

void
Wx_Process::CloseOutput()

void
Wx_Process::Detach()

wxInputStream*
Wx_Process::GetErrorStream()

wxInputStream*
Wx_Process::GetInputStream()

wxOutputStream*
Wx_Process::GetOutputStream()

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

wxKillError
Kill( pid, signal = wxSIGNONE )
    int pid
    wxSignal signal
  CODE:
    RETVAL = wxProcess::Kill( pid, signal );
  OUTPUT:
    RETVAL

bool
Exists( pid )
    int pid
  CODE:
    RETVAL = wxProcess::Exists( pid );
  OUTPUT:
    RETVAL

#endif

void
Wx_Process::OnTerminate( pid, status )
    int pid
    int status
  CODE:
    THIS->wxProcess::OnTerminate( pid, status );

void
Wx_Process::Redirect()

MODULE=Wx PACKAGE=Wx PREFIX=wx

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

long
wxExecuteCommand( command, sync = wxEXEC_ASYNC, callback = 0 )
    wxString command
    int sync
    Wx_Process* callback
  CODE:
    RETVAL = wxExecute( command, sync, callback );
  OUTPUT:
    RETVAL

long
wxExecuteArgs( args, sync = wxEXEC_ASYNC, callback = 0 )
    SV* args
    int sync
    Wx_Process* callback
  PREINIT:
    char** argv;
    char** t;
    int n, i;
  CODE:
    n = wxPli_av_2_charparray( aTHX_ args, &t );
    argv = new char*[n+1];
    memcpy( argv, t, n*sizeof(char*) );
    argv[n] = 0;
    RETVAL = wxExecute( argv, sync, callback );
    for( i = 0; i < n; ++i )
        free( argv[i] );
    delete[] argv;
    delete[] t;
  OUTPUT:
    RETVAL

#else

long
wxExecuteCommand( command, sync = FALSE, callback = 0 )
    wxString command
    bool sync
    Wx_Process* callback
  CODE:
    RETVAL = wxExecute( command, sync, callback );
  OUTPUT:
    RETVAL

long
wxExecuteArgs( args, sync = FALSE, callback = 0 )
    SV* args
    bool sync
    Wx_Process* callback
  PREINIT:
    char** argv;
    char** t;
    int n, i;
  CODE:
    n = wxPli_av_2_charparray( aTHX_ args, &t );
    argv = new char*[n+1];
    memcpy( argv, t, n*sizeof(char*) );
    argv[n] = 0;
    RETVAL = wxExecute( argv, sync, callback );
    for( i = 0; i < n; ++i )
        free( argv[i] );
    delete[] argv;
    delete[] t;
  OUTPUT:
    RETVAL

#endif

void
wxExecuteStdout( command )
    wxString command
  PREINIT:
    wxArrayString out;
    AV* ret;
    long code;
  PPCODE:
    code = wxExecute( command, out );
    ret = wxPli_stringarray_2_av( aTHX_ out );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( code ) ) );
    PUSHs( sv_2mortal( newRV_noinc( (SV*)ret ) ) );

void
wxExecuteStdoutStderr( command )
    wxString command
  PREINIT:
    wxArrayString out, err;
    AV *rout, *rerr;
    long code;
  PPCODE:
    code = wxExecute( command, out, err );
    rout = wxPli_stringarray_2_av( aTHX_ out );
    rerr = wxPli_stringarray_2_av( aTHX_ err );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( code ) ) );
    PUSHs( sv_2mortal( newRV_noinc( (SV*)rout ) ) );
    PUSHs( sv_2mortal( newRV_noinc( (SV*)rerr ) ) );
