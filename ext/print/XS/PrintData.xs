#############################################################################
## Name:        PrintData.xs
## Purpose:     XS for Wx::PrintData
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 5/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cmndata.h>

MODULE=Wx PACKAGE=Wx::PrintData

Wx_PrintData*
Wx_PrintData::new()
  CODE:
    RETVAL = new wxPrintData();
  OUTPUT:
    RETVAL

void
Wx_PrintData::Destroy()
  CODE:
    delete THIS;

bool
Wx_PrintData::GetCollate()

bool
Wx_PrintData::GetColour()

wxDuplexMode
Wx_PrintData::GetDuplex()

int
Wx_PrintData::GetNoCopies()

int
Wx_PrintData::GetOrientation()

wxPaperSize
Wx_PrintData::GetPaperId()

wxString
Wx_PrintData::GetPrinterName()

wxPaperQuality
Wx_PrintData::GetQuality()

void
Wx_PrintData::SetCollate( collate )
    bool collate

void
Wx_PrintData::SetColour( colour )
    bool colour

void
Wx_PrintData::SetDuplex( mode )
    wxDuplexMode mode

void
Wx_PrintData::SetNoCopies( noCopies )
    int noCopies

void
Wx_PrintData::SetOrientation( orientation )
    int orientation

void
Wx_PrintData::SetPaperId( paperId )
    wxPaperSize paperId

void
Wx_PrintData::SetPrinterName( name )
    wxString name

void
Wx_PrintData::SetQuality( quality )
    wxPaperQuality quality

