/////////////////////////////////////////////////////////////////////////////
// Name:        Functions.xs
// Purpose:     XS for various functions (esp. wxLog and wx..Dialog)
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>

#include <wx/filedlg.h>
#include <wx/colordlg.h>
#include <wx/textdlg.h>
#include <wx/choicdlg.h>
#include <wx/msgdlg.h>
#include <wx/log.h>
#include <wx/intl.h>
#include <wx/image.h>
#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#include "cpp/compat.h"
#include "cpp/typedef.h"
#include "cpp/helpers.h"

MODULE=Wx_Func PACKAGE=Wx PREFIX=wx

#FIXME// unimplemented
# CreateFileTipProvider
# ShowTip

#
# Dialog Functions
#

wxString
wxGetSingleChoice( message, caption, chs, parent = 0, x = -1, y = -1, centre = TRUE, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    Wx_Window* parent
    int x
    int y
    bool centre
    int width
    int height
  PREINIT:
    wxString* choices;
    int n;
  CODE:
    n = _av_2_stringarray( chs, &choices );
    RETVAL = wxGetSingleChoice( message, caption, n, choices, parent, x, y,
        centre, width, height );
    delete[] choices;
  OUTPUT:
    RETVAL

int
wxGetSingleChoiceIndex( message, caption, chs, parent = 0, x = -1, y = -1, centre = TRUE, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    Wx_Window* parent
    int x
    int y
    bool centre
    int width
    int height
  PREINIT:
    wxString* choices;
    int n;
  CODE:
    n = _av_2_stringarray( chs, &choices );
    RETVAL = wxGetSingleChoiceIndex( message, caption, n, choices,
        parent, x, y, centre, width, height );
    delete[] choices;
  OUTPUT:
    RETVAL

SV*
wxGetSingleChoiceData( message, caption, chs, dt, parent = 0, x = -1, y = -1, centre = TRUE, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    SV* dt
    Wx_Window* parent
    int x
    int y
    bool centre
    int width
    int height
  PREINIT:
    wxString* choices;
    SV** data;
    int n, n2;
    void* rt;
  CODE:
    n = _av_2_stringarray( chs, &choices );
    n2 = _av_2_svarray( dt, &data );
    if( n != n2 )
    {
      delete[] choices;
      delete[] data;
      choices = 0; data = 0; n = 0;
      croak( "supplied arrays of different size" );
    }
    rt = wxGetSingleChoiceData( message, caption, n, choices, (void**)data,
        parent, x, y, centre, width, height );
    RETVAL = rt ? (SV*)rt : &PL_sv_undef;
    delete[] choices;
    delete[] data;
  OUTPUT:
    RETVAL

wxString
wxFileSelector( message, default_path = wxEmptyString, default_filename = wxEmptyString, default_extension = wxEmptyString, wildcard = "*.*", flags = 0, parent = 0, x = -1, y = -1 )
    wxString message
    wxString default_path
    wxString default_filename
    wxString default_extension
    wxString wildcard
    int flags
    Wx_Window* parent
    int x
    int y

Wx_Colour*
wxGetColourFromUser( parent, colInit )
    Wx_Window* parent
    Wx_Colour* colInit
  CODE:
    RETVAL = new wxColour( wxGetColourFromUser( parent, *colInit ) );
  OUTPUT:
    RETVAL

long
wxGetNumberFromUser( message, prompt, caption, value, min = 0, max = 100, parent = 0, pos = wxDefaultPosition )
    wxString message
    wxString prompt
    wxString caption
    long value
    long min
    long max
    Wx_Window* parent
    Wx_Point pos
  CODE:
    RETVAL = wxGetNumberFromUser( message, prompt, caption, value, min, max, parent, pos );
  OUTPUT:
    RETVAL

wxString
wxGetPasswordFromUser( message, caption = wxGetTextFromUserPromptStr, default_value = wxEmptyString, parent = 0 )
  wxString message
  wxString caption
  wxString default_value
  Wx_Window* parent

wxString
wxGetTextFromUser( message, caption = wxGetTextFromUserPromptStr, default_value = wxEmptyString, parent = 0, x = -1, y = -1, centre = TRUE )
  wxString message
  wxString caption
  wxString default_value
  Wx_Window* parent
  int x
  int y
  bool centre

int
wxMessageBox( message, caption = "Message", style = wxOK|wxCENTRE, parent = 0, x = -1, y = -1 )
    wxString message
    wxString caption
    int style
    Wx_Window* parent
    int x
    int y

#
# Log Functions
#

MODULE=Wx_Func PACKAGE=Wx

#FIXME// unimplemented
# wxLogTrace

void
wxLogError( string )
    const char* string

void
wxLogFatalError( string )
    const char* string

void
wxLogWarning( string )
    const char* string

void
wxLogMessage( string )
    const char* string

void
wxLogVerbose( string )
    const char* string

void
wxLogSysError( string )
    const char* string

void
wxLogDebug( string )
    const char* string

void
wxLogStatusFrame( frame, string )
    Wx_Frame* frame
    const char* string
  CODE:
    wxLogStatus( frame, string );

void
wxLogStatus( string )
    const char* string
  CODE:
    wxLogStatus( string );

MODULE=Wx_Func PACKAGE=Wx PREFIX=wx

unsigned long
wxSysErrorCode()

const char*
wxSysErrorMsg( errCode = 0 )
    unsigned long errCode

const char*
wxGetTranslation( string )
    const char* string

void
wxInitAllImageHandlers()

MODULE=Wx_Func PACKAGE=Wx PREFIX=wx
