#############################################################################
## Name:        PrintDialog.xs
## Purpose:     XS for Wx::PrintDialog
## Author:      Mattia Barbon
## Modified by:
## Created:      2/ 6/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/printdlg.h>
#include <wx/dc.h>

MODULE=Wx PACKAGE=Wx::PrintDialog

Wx_PrintDialog*
Wx_PrintDialog::new( parent, data = 0 )
    Wx_Window* parent
    Wx_PrintDialogData* data

Wx_PrintDialogData*
Wx_PrintDialog::GetPrintDialogData()
  CODE:
    RETVAL = new wxPrintDialogData( THIS->GetPrintDialogData() );
  OUTPUT:
    RETVAL

Wx_DC*
Wx_PrintDialog::GetPrintDC()
