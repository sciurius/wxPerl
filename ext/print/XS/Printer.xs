#############################################################################
## Name:        ext/print/XS/Printer.xs
## Purpose:     XS for Wx::Printer
## Author:      Mattia Barbon
## Modified by:
## Created:     29/05/2001
## RCS-ID:      $Id: Printer.xs,v 1.10 2004/12/21 21:12:55 mbarbon Exp $
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>
#include <wx/dc.h>

MODULE=Wx PACKAGE=Wx::Printer

wxPrinter*
wxPrinter::new( data = 0 )
    wxPrintDialogData* data

## XXX threads
void
wxPrinter::DESTROY()

bool
wxPrinter::GetAbort()

wxPrintDialogData*
wxPrinter::GetPrintDialogData()
  CODE:
    RETVAL = &THIS->GetPrintDialogData();
  OUTPUT:
    RETVAL

void
wxPrinter::CreateAbortWindow( parent, printout )
    wxWindow* parent
    wxPrintout* printout

wxPrinterError
GetLastError()
  CODE:
    RETVAL = wxPrinter::GetLastError();
  OUTPUT:
    RETVAL

bool
wxPrinter::Print( parent, printout, prompt = true )
    wxWindow* parent
    wxPrintout* printout
    bool prompt

wxDC*
wxPrinter::PrintDialog( parent )
    wxWindow* parent

void
wxPrinter::ReportError( parent, printout, message )
    wxWindow* parent
    wxPrintout* printout
    wxString message
  CODE:
    THIS->ReportError( parent, printout, message );

bool
wxPrinter::Setup( parent )
    wxWindow* parent
