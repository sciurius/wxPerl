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

void
Wx_Log::Destroy()
  CODE:
    delete THIS;

void
AddTraceMask( mask )
    wxString mask
  CODE:
    wxLog::AddTraceMask( mask );

void
RemoveTraceMask( mask )
    wxString mask
  CODE:
    wxLog::RemoveTraceMask( mask );

bool
IsAllowedTraceMask( mask )
    wxChar* mask
  CODE:
    wxLog::IsAllowedTraceMask( mask );

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

void
SetTraceMask( mask )
    wxTraceMask mask
  CODE:
    wxLog::SetTraceMask( mask );

wxTraceMask
GetTraceMask()
  CODE:
    RETVAL = wxLog::GetTraceMask();

MODULE=Wx PACKAGE=Wx::LogTextCtrl

Wx_LogTextCtrl*
Wx_LogTextCtrl::new( ctrl )
    Wx_TextCtrl* ctrl

MODULE=Wx PACKAGE=Wx::LogNull

Wx_LogNull*
Wx_LogNull::new()

void
Wx_LogNull::DESTROY()

MODULE=Wx PACKAGE=Wx::LogGui

Wx_LogGui*
Wx_LogGui::new()

MODULE=Wx PACKAGE=Wx::LogWindow

Wx_LogWindow*
Wx_LogWindow::new( parent, title, show = TRUE, passtoold = TRUE )
    Wx_Frame* parent
    wxString title
    bool show
    bool passtoold



