#############################################################################
## Name:        ext/print/XS/PrintData.xs
## Purpose:     XS for Wx::PrintData
## Author:      Mattia Barbon
## Modified by:
## Created:     04/05/2001
## RCS-ID:      $Id: PrintData.xs,v 1.3 2004/12/21 21:12:55 mbarbon Exp $
## Copyright:   (c) 2001, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cmndata.h>

MODULE=Wx PACKAGE=Wx::PrintData

wxPrintData*
wxPrintData::new()
  CODE:
    RETVAL = new wxPrintData();
  OUTPUT:
    RETVAL

void
wxPrintData::Destroy()
  CODE:
    delete THIS;

bool
wxPrintData::GetCollate()

bool
wxPrintData::GetColour()

wxDuplexMode
wxPrintData::GetDuplex()

int
wxPrintData::GetNoCopies()

int
wxPrintData::GetOrientation()

wxPaperSize
wxPrintData::GetPaperId()

wxString
wxPrintData::GetPrinterName()

wxPrintQuality
wxPrintData::GetQuality()

void
wxPrintData::SetCollate( collate )
    bool collate

void
wxPrintData::SetColour( colour )
    bool colour

void
wxPrintData::SetDuplex( mode )
    wxDuplexMode mode

void
wxPrintData::SetNoCopies( noCopies )
    int noCopies

void
wxPrintData::SetOrientation( orientation )
    int orientation

void
wxPrintData::SetPaperId( paperId )
    wxPaperSize paperId

void
wxPrintData::SetPrinterName( name )
    wxString name

void
wxPrintData::SetQuality( quality )
    wxPrintQuality quality

