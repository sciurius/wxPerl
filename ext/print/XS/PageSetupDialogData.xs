#############################################################################
## Name:        ext/print/XS/PageSetupDialogData.xs
## Purpose:     XS for Wx::PageSetupDialogData
## Author:      Mattia Barbon
## Modified by:
## Created:     04/05/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cmndata.h>

MODULE=Wx PACKAGE=Wx::PageSetupDialogData

wxPageSetupDialogData*
wxPageSetupDialogData::new()

void
wxPageSetupDialogData::Destroy()
  CODE:
    delete THIS;

void
wxPageSetupDialogData::EnableHelp( flag )
    bool flag

void
wxPageSetupDialogData::EnableMargins( flag )
    bool flag

void
wxPageSetupDialogData::EnableOrientation( flag )
    bool flag

void
wxPageSetupDialogData::EnablePaper( flag )
    bool flag

void
wxPageSetupDialogData::EnablePrinter( flag )
    bool flag

bool
wxPageSetupDialogData::GetDefaultMinMargins()

bool
wxPageSetupDialogData::GetEnableMargins()

bool
wxPageSetupDialogData::GetEnableOrientation()

bool
wxPageSetupDialogData::GetEnablePaper()

bool
wxPageSetupDialogData::GetEnablePrinter()

bool
wxPageSetupDialogData::GetEnableHelp()

bool
wxPageSetupDialogData::GetDefaultInfo()

wxPoint*
wxPageSetupDialogData::GetMarginTopLeft()
  CODE:
    RETVAL = new wxPoint( THIS->GetMarginTopLeft() );
  OUTPUT:
    RETVAL

wxPoint*
wxPageSetupDialogData::GetMarginBottomRight()
  CODE:
    RETVAL = new wxPoint( THIS->GetMarginBottomRight() );
  OUTPUT:
    RETVAL

wxPoint*
wxPageSetupDialogData::GetMinMarginTopLeft()
  CODE:
    RETVAL = new wxPoint( THIS->GetMinMarginTopLeft() );
  OUTPUT:
    RETVAL

wxPoint*
wxPageSetupDialogData::GetMinMarginBottomRight()
  CODE:
    RETVAL = new wxPoint( THIS->GetMinMarginBottomRight() );
  OUTPUT:
    RETVAL

wxPaperSize
wxPageSetupDialogData::GetPaperId()

wxSize*
wxPageSetupDialogData::GetPaperSize()
  CODE:
    RETVAL = new wxSize( THIS->GetPaperSize() );
  OUTPUT:
    RETVAL

wxPrintData*
wxPageSetupDialogData::GetPrintData()
  CODE:
    RETVAL = &THIS->GetPrintData();
  OUTPUT:
    RETVAL

void
wxPageSetupDialogData::SetDefaultInfo( flag )
    bool flag

void
wxPageSetupDialogData::SetDefaultMinMargins( flag )
    bool flag

void
wxPageSetupDialogData::SetMarginTopLeft( point )
    wxPoint point

void
wxPageSetupDialogData::SetMarginBottomRight( point )
    wxPoint point

void
wxPageSetupDialogData::SetMinMarginTopLeft( point )
    wxPoint point

void
wxPageSetupDialogData::SetMinMarginBottomRight( point )
    wxPoint point

void
wxPageSetupDialogData::SetPaperId( id )
    wxPaperSize id

void
wxPageSetupDialogData::SetPaperSize( size )
    wxSize size

void
wxPageSetupDialogData::SetPrintData( printData )
    wxPrintData* printData
  CODE:
    THIS->SetPrintData( *printData );

