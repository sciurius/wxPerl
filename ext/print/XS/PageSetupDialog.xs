#############################################################################
## Name:        PageSetupDialog.xs
## Purpose:     XS for Wx::PageSetupDialog
## Author:      Mattia Barbon
## Modified by:
## Created:      4/ 5/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/printdlg.h>

MODULE=Wx PACKAGE=Wx::PageSetupDialog

Wx_PageSetupDialog*
Wx_PageSetupDialog::new( parent, data = 0 )
    Wx_Window* parent
    Wx_PageSetupDialogData* data

void
Wx_PageSetupDialog::Destroy()
  CODE:
    delete THIS;

Wx_PageSetupDialogData*
Wx_PageSetupDialog::GetPageSetupData()
  CODE:
    RETVAL = &THIS->GetPageSetupData();
  OUTPUT:
    RETVAL

