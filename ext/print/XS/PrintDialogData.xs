#############################################################################
## Name:        PrintDialogData.xs
## Purpose:     XS for Wx::PrintDialogData
## Author:      Mattia Barbon
## Modified by:
## Created:      2/ 6/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cmndata.h>

MODULE=Wx PACKAGE=Wx::PrintDialogData

Wx_PrintDialogData*
Wx_PrintDialogData::new()

void
Wx_PrintDialogData::Destroy()
  CODE:
    delete THIS;

void
Wx_PrintDialogData::EnableHelp( enable )
    bool enable

void
Wx_PrintDialogData::EnablePageNumbers( enable )
    bool enable

void
Wx_PrintDialogData::EnablePrintToFile( enable )
     bool enable

void
Wx_PrintDialogData::EnableSelection( enable )
    bool enable

bool
Wx_PrintDialogData::GetAllPages()

bool
Wx_PrintDialogData::GetCollate()

int
Wx_PrintDialogData::GetFromPage()

int
Wx_PrintDialogData::GetMaxPage()

int
Wx_PrintDialogData::GetMinPage()

int
Wx_PrintDialogData::GetNoCopies()

Wx_PrintData*
Wx_PrintDialogData::GetPrintData()
  CODE:
    RETVAL = &THIS->GetPrintData();
  OUTPUT:
    RETVAL

bool
Wx_PrintDialogData::GetPrintToFile()

bool
Wx_PrintDialogData::GetSelection()

int
Wx_PrintDialogData::GetToPage()

void
Wx_PrintDialogData::SetCollate( collate )
    bool collate

void
Wx_PrintDialogData::SetFromPage( page )
    int page

void
Wx_PrintDialogData::SetMaxPage( page )
    int page

void
Wx_PrintDialogData::SetMinPage( page )
    int page

void
Wx_PrintDialogData::SetNoCopies( n )
    int n

void
Wx_PrintDialogData::SetPrintData( printData )
    Wx_PrintData* printData
  CODE:
    THIS->SetPrintData( *printData );

void
Wx_PrintDialogData::SetPrintToFile( flag )
    bool flag

void
Wx_PrintDialogData::SetSelection( selection )
    bool selection

void
Wx_PrintDialogData::SetSetupDialog( flag )
    bool flag

void
Wx_PrintDialogData::SetToPage( page )
    int page
