#############################################################################
## Name:        Dialog.xs
## Purpose:     XS for Wx::Dialog
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dialog.h>
#include <wx/button.h>
#include "cpp/dialog.h"

MODULE=Wx PACKAGE=Wx::Dialog

Wx_Dialog*
Wx_Dialog::new( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_DIALOG_STYLE, name = wxDialogNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new _wxDialog( CLASS, parent, id, title, pos, size, style, name );
  OUTPUT:
    RETVAL

void
Wx_Dialog::EndModal( retCode )
    int retCode

int
Wx_Dialog::GetReturnCode()

void
Wx_Dialog::Iconize( iconize )
    bool iconize

bool
Wx_Dialog::IsIconized()

bool
Wx_Dialog::IsModal()

# void
# Wx_Dialog::SetModal( flag )
#    bool flag

void
Wx_Dialog::SetReturnCode( retCode )
    int retCode

int
Wx_Dialog::ShowModal()

bool
Wx_Dialog::TransferDataFromWindow()
  CODE:
    RETVAL = THIS->wxDialog::TransferDataFromWindow();
  OUTPUT:
    RETVAL

bool
Wx_Dialog::TransferDataToWindow()
  CODE:
    RETVAL = THIS->wxDialog::TransferDataToWindow();
  OUTPUT:
    RETVAL

bool
Wx_Dialog::Validate()
  CODE:
    RETVAL = THIS->Validate();
  OUTPUT:
    RETVAL
