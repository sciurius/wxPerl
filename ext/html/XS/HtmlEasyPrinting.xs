#############################################################################
## Name:        HtmlEasyPrinting.xs
## Purpose:     XS for Wx::HtmlEasyPrinting
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 5/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/htmprint.h>

MODULE=Wx PACKAGE=Wx::HtmlEasyPrinting

Wx_HtmlEasyPrinting*
Wx_HtmlEasyPrinting::new( name = "Printing", parent_frame = 0 )
    wxString name
    Wx_Frame* parent_frame

## XXX threads
void
Wx_HtmlEasyPrinting::DESTROY()

bool
Wx_HtmlEasyPrinting::PreviewFile( htmlFile )
    wxString htmlFile

bool
Wx_HtmlEasyPrinting::PreviewText( htmlText, basepath = wxEmptyString )
    wxString htmlText
    wxString basepath

bool
Wx_HtmlEasyPrinting::PrintFile( htmlFile )
    wxString htmlFile

bool
Wx_HtmlEasyPrinting::PrintText( htmlText, basepath = wxEmptyString )
    wxString htmlText
    wxString basepath

void
Wx_HtmlEasyPrinting::PrinterSetup()

void
Wx_HtmlEasyPrinting::PageSetup()

void
Wx_HtmlEasyPrinting::SetHeader( header, pg = wxPAGE_ALL )
    wxString header
    int pg

void
Wx_HtmlEasyPrinting::SetFooter( header, pg = wxPAGE_ALL )
    wxString header
    int pg

Wx_PrintData*
Wx_HtmlEasyPrinting::GetPrintData()

Wx_PageSetupDialogData*
Wx_HtmlEasyPrinting::GetPageSetupData()
