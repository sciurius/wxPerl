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

#include <wx/log.h>
#include "cpp/log.h"

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

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

void
ClearTraceMasks()
  CODE:
    wxLog::ClearTraceMasks();

#endif

void
RemoveTraceMask( mask )
    wxString mask
  CODE:
    wxLog::RemoveTraceMask( mask );

bool
IsAllowedTraceMask( mask )
    const wxChar* mask
  CODE:
    RETVAL = wxLog::IsAllowedTraceMask( mask );
  OUTPUT:
    RETVAL

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
    const wxChar* format

const wxChar*
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
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::PlLog

wxPlLog*
wxPlLog::new()
  CODE:
    RETVAL = new wxPlLog( CLASS );
  OUTPUT:
    RETVAL

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

MODULE=Wx PACKAGE=Wx

# this is a test for INTERFACE:
# in thi specific case it saves around 256 bytes / function,
# more for more complex typemaps / longer parameter lists

#if 0

#define XSINTERFACE__ccharp( _ret, _cv, _f ) \
  ( ( void (*)( const wxChar * ) ) _f)

#define XSINTERFACE__ccharp_SET( _cv, _f ) \
  ( CvXSUBANY( _cv ).any_ptr = (void*) _f ) 

#undef dXSFUNCTION
#define dXSFUNCTION( a ) \
  void (*XSFUNCTION)( const wxChar* )

# xsubpp from Perl 5.004_04 does not like this at all.

# void
# interface__ccharp( string )
#     const wxChar* string
#   INTERFACE_MACRO:
#     XSINTERFACE__ccharp
#     XSINTERFACE__ccharp_SET
#   INTERFACE:
#     wxLogError wxLogFatalError wxLogWarning
#     wxLogVerbose wxLogDebug
#     wxLogMessage
    
#else

void
wxLogError( string )
    const wxChar* string

void
wxLogFatalError( string )
    const wxChar* string

void
wxLogWarning( string )
    const wxChar* string

void
wxLogMessage( string )
    const wxChar* string

void
wxLogVerbose( string )
    const wxChar* string

void
wxLogDebug( string )
    const wxChar* string

#endif

void
wxLogStatusFrame( frame, string )
    Wx_Frame* frame
    const wxChar* string
  CODE:
    wxLogStatus( frame, string );

void
wxLogStatus( string )
    const wxChar* string

void
wxLogTrace( string )
    const wxChar* string

void
wxLogTraceMask( mask, string )
    const wxChar* mask
    const wxChar* string
  CODE:
    ::wxLogTrace( mask, string );

void
wxLogSysError( string )
    const wxChar* string

MODULE=Wx PACKAGE=Wx PREFIX=wx

unsigned long
wxSysErrorCode()

const wxChar*
wxSysErrorMsg( errCode = 0 )
    unsigned long errCode

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

MODULE=Wx PACKAGE=Wx::LogChain

wxLogChain*
wxLogChain::new( logger )
    wxLog* logger

wxLog*
wxLogChain::GetOldLog()

bool
wxLogChain::IsPassingMessages()

void
wxLogChain::PassMessages( passMessages )
    bool passMessages

void
wxLogChain::SetLog( logger )
    wxLog* logger

MODULE=Wx PACKAGE=Wx::LogPassThrough

wxLogPassThrough*
wxLogPassThrough::new()

MODULE=Wx PACKAGE=Wx::PlLogPassThrough

wxPlLogPassThrough*
wxPlLogPassThrough::new()
  CODE:
    RETVAL = new wxPlLogPassThrough( CLASS );
  OUTPUT:
    RETVAL

#endif
