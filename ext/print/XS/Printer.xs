#############################################################################
## Name:        Printer.xs
## Purpose:     XS for Wx::Printer
## Author:      Mattia Barbon
## Modified by:
## Created:     29/ 5/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>
#include <wx/dc.h>

MODULE=Wx PACKAGE=Wx::Printer

Wx_Printer*
Wx_Printer::new( data = 0 )
    Wx_PrintDialogData* data

void
Wx_Printer::DESTROY()

bool
Wx_Printer::GetAbort()

void
Wx_Printer::CreateAbortWindow( parent, printout )
    Wx_Window* parent
    Wx_Printout* printout

wxPrinterError
GetLastError()
  CODE:
    RETVAL = wxPrinter::GetLastError();
  OUTPUT:
    RETVAL

bool
Wx_Printer::Print( parent, printout, prompt = TRUE )
    Wx_Window* parent
    Wx_Printout* printout
    bool prompt

Wx_DC*
Wx_Printer::PrintDialog( parent )
    Wx_Window* parent

void
Wx_Printer::ReportError( parent, printout, message )
    Wx_Window* parent
    Wx_Printout* printout
    wxString message
  CODE:
#if WXPERL_W_VERSION_GE( 2, 3 )
    THIS->ReportError( parent, printout, message );
#else
#  if wxUSE_UNICODE
    THIS->ReportError( parent, printout, (char*)message.mb_str().data() );
#  else
    THIS->ReportError( parent, printout, (char*)(const char*)message );
#  endif
#endif

bool
Wx_Printer::Setup( parent )
    Wx_Window* parent
