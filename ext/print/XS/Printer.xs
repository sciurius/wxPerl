#############################################################################
## Name:        Printer.xs
## Purpose:     XS for Wx::Printer
## Author:      Mattia Barbon
## Modified by:
## Created:     29/ 5/2001
## RCS-ID:      $Id: Printer.xs,v 1.7 2003/05/05 20:38:42 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>
#include <wx/dc.h>

MODULE=Wx PACKAGE=Wx::Printer

Wx_Printer*
Wx_Printer::new( data = 0 )
    Wx_PrintDialogData* data

## XXX threads
void
Wx_Printer::DESTROY()

bool
Wx_Printer::GetAbort()

Wx_PrintDialogData*
Wx_Printer::GetPrintDialogData()
  CODE:
    RETVAL = &THIS->GetPrintDialogData();
  OUTPUT:
    RETVAL

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
    THIS->ReportError( parent, printout, message );

bool
Wx_Printer::Setup( parent )
    Wx_Window* parent
