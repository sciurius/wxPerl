#############################################################################
## Name:        PageSetupDialogData.xs
## Purpose:     XS for Wx::PageSetupDialogData
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 5/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cmndata.h>

MODULE=Wx PACKAGE=Wx::PageSetupDialogData

Wx_PageSetupDialogData*
Wx_PageSetupDialogData::new()

void
Wx_PageSetupDialogData::Destroy()
  CODE:
    delete THIS;

void
Wx_PageSetupDialogData::EnableHelp( flag )
    bool flag

void
Wx_PageSetupDialogData::EnableMargins( flag )
    bool flag

void
Wx_PageSetupDialogData::EnableOrientation( flag )
    bool flag

void
Wx_PageSetupDialogData::EnablePaper( flag )
    bool flag

void
Wx_PageSetupDialogData::EnablePrinter( flag )
    bool flag

bool
Wx_PageSetupDialogData::GetDefaultMinMargins()

bool
Wx_PageSetupDialogData::GetEnableMargins()

bool
Wx_PageSetupDialogData::GetEnableOrientation()

bool
Wx_PageSetupDialogData::GetEnablePaper()

bool
Wx_PageSetupDialogData::GetEnablePrinter()

bool
Wx_PageSetupDialogData::GetEnableHelp()

bool
Wx_PageSetupDialogData::GetDefaultInfo()

Wx_Point*
Wx_PageSetupDialogData::GetMarginTopLeft()
  CODE:
    RETVAL = new wxPoint( THIS->GetMarginTopLeft() );
  OUTPUT:
    RETVAL

Wx_Point*
Wx_PageSetupDialogData::GetMarginBottomRight()
  CODE:
    RETVAL = new wxPoint( THIS->GetMarginBottomRight() );
  OUTPUT:
    RETVAL

Wx_Point*
Wx_PageSetupDialogData::GetMinMarginTopLeft()
  CODE:
    RETVAL = new wxPoint( THIS->GetMinMarginTopLeft() );
  OUTPUT:
    RETVAL

Wx_Point*
Wx_PageSetupDialogData::GetMinMarginBottomRight()
  CODE:
    RETVAL = new wxPoint( THIS->GetMinMarginBottomRight() );
  OUTPUT:
    RETVAL

wxPaperSize
Wx_PageSetupDialogData::GetPaperId()

Wx_Size*
Wx_PageSetupDialogData::GetPaperSize()
  CODE:
    RETVAL = new wxSize( THIS->GetPaperSize() );
  OUTPUT:
    RETVAL

Wx_PrintData*
Wx_PageSetupDialogData::GetPrintData()
  CODE:
    RETVAL = &THIS->GetPrintData();
  OUTPUT:
    RETVAL

void
Wx_PageSetupDialogData::SetDefaultInfo( flag )
    bool flag

void
Wx_PageSetupDialogData::SetDefaultMinMargins( flag )
    bool flag

void
Wx_PageSetupDialogData::SetMarginTopLeft( point )
    Wx_Point point

void
Wx_PageSetupDialogData::SetMarginBottomRight( point )
    Wx_Point point

void
Wx_PageSetupDialogData::SetMinMarginTopLeft( point )
    Wx_Point point

void
Wx_PageSetupDialogData::SetMinMarginBottomRight( point )
    Wx_Point point

void
Wx_PageSetupDialogData::SetPaperId( id )
    wxPaperSize id

void
Wx_PageSetupDialogData::SetPaperSize( size )
    Wx_Size size

void
Wx_PageSetupDialogData::SetPrintData( printData )
    Wx_PrintData* printData
  CODE:
    THIS->SetPrintData( *printData );

