#############################################################################
## Name:        XS/Process.xs
## Purpose:     XS for Wx::Process and Wx::ProcessEvent and Wx::Execute
## Author:      Mattia Barbon
## Modified by:
## Created:     11/02/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002-2004, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/process.h>
#include "cpp/process.h"
#include <wx/utils.h>

MODULE=Wx PACKAGE=Wx::ProcessEvent

wxProcessEvent*
wxProcessEvent::new( id = 0, pid = 0, status = 0 )
    int id
    int pid
    int status

int
wxProcessEvent::GetPid()

int
wxProcessEvent::GetExitCode()

MODULE=Wx PACKAGE=Wx::Process

wxProcess*
wxProcess::new( parent = 0, id = -1 )
    wxEvtHandler* parent
    int id
  CODE:
    RETVAL = new wxPliProcess( CLASS, parent, id );
  OUTPUT:
    RETVAL

void
wxProcess::Destroy()
  CODE:
    delete THIS;

void
wxProcess::CloseOutput()

void
wxProcess::Detach()

wxInputStream*
wxProcess::GetErrorStream()

wxInputStream*
wxProcess::GetInputStream()

wxOutputStream*
wxProcess::GetOutputStream()

bool
wxProcess::IsErrorAvailable()

bool
wxProcess::IsInputAvailable()

bool
wxProcess::IsInputOpened()

#if WXPERL_W_VERSION_LT( 2, 5, 4 )
#define wxKILL_NOCHILDREN 0
#endif

wxKillError
Kill( pid, signal = wxSIGNONE, flags = wxKILL_NOCHILDREN )
    int pid
    wxSignal signal
    int flags
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 4 )
    RETVAL = wxProcess::Kill( pid, signal, flags );
#else
    RETVAL = wxProcess::Kill( pid, signal );
#endif
  OUTPUT:
    RETVAL

bool
Exists( pid )
    int pid
  CODE:
    RETVAL = wxProcess::Exists( pid );
  OUTPUT:
    RETVAL

void
wxProcess::OnTerminate( pid, status )
    int pid
    int status
  CODE:
    THIS->wxProcess::OnTerminate( pid, status );

void
wxProcess::Redirect()

wxProcess*
Open( cmd, flags = wxEXEC_ASYNC )
    wxString cmd
    int flags
  CODE:
    RETVAL = wxProcess::Open( cmd, flags );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

int
wxProcess::GetPid()

#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

long
wxExecuteCommand( command, sync = wxEXEC_ASYNC, callback = 0 )
    wxString command
    int sync
    wxProcess* callback
  CODE:
    RETVAL = wxExecute( command, sync, callback );
  OUTPUT:
    RETVAL

#if wxUSE_UNICODE

long
wxExecuteArgs( args, sync = wxEXEC_ASYNC, callback = 0 )
    SV* args
    int sync
    wxProcess* callback
  PREINIT:
    wxChar** argv;
    wxChar** t;
    int n, i;
  CODE:
    n = wxPli_av_2_wxcharparray( aTHX_ args, &t );
    argv = new wxChar*[n+1];
    memcpy( argv, t, n*sizeof(char*) );
    argv[n] = 0;
    RETVAL = wxExecute( argv, sync, callback );
    for( i = 0; i < n; ++i )
        delete argv[i];
    delete[] argv;
    delete[] t;
  OUTPUT:
    RETVAL

#else

long
wxExecuteArgs( args, sync = wxEXEC_ASYNC, callback = 0 )
    SV* args
    int sync
    wxProcess* callback
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
        delete argv[i];
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
