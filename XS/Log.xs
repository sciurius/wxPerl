#############################################################################
## Name:        Log.xs
## Purpose:     XS for Wx::Log and derived classes
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Log

#FIXME// unimplememnted
# *Trace*

void
Wx_Log::Destroy()
  CODE:
    delete THIS;

void
AddTraceMask( mask )
    wxString mask
  CODE:
    wxLog::AddTraceMask( mask );

Wx_Log*
GetActiveTarget()
  CODE:
    RETVAL = wxLog::GetActiveTarget();
  OUTPUT:
    RETVAL

Wx_Log*
SetActiveTarget( target )
    Wx_Log* target
  CODE:
    RETVAL = wxLog::SetActiveTarget( target );
  OUTPUT:
    RETVAL

void
DontCreateOnDemand()
  CODE:
    wxLog::DontCreateOnDemand();

void
Wx_Log::Flush()

void
Wx_Log::FlushActive()

bool
Wx_Log::HasPendingMessages()

void
Wx_Log::SetVerbose( verbose = TRUE )
    bool verbose

bool
Wx_Log::GetVerbose()

void
Wx_Log::SetTimestamp( format )
    const char* format

const char*
Wx_Log::GetTimestamp()


MODULE=Wx PACKAGE=Wx::LogTextCtrl

Wx_LogTextCtrl*
Wx_LogTextCtrl::new( ctrl )
    Wx_TextCtrl* ctrl


