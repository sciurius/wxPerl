#############################################################################
## Name:        ProgressDialog.xs
## Purpose:     XS for Wx::ProgressDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     29/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/progdlg.h>

MODULE=Wx PACKAGE=Wx::ProgressDialog

Wx_ProgressDialog*
Wx_ProgressDialog::new( title, message, maximum = 100, parent = 0, style = wxPD_AUTO_HIDE|wxPD_APP_MODAL )
    wxString title
    wxString message
    int maximum
    Wx_Window* parent
    long style
  CODE:
    RETVAL = new wxProgressDialog( title, message, maximum, parent, style );
  OUTPUT:
    RETVAL

bool
Wx_ProgressDialog::Update( value = -1, newmsg = wxEmptyString )
    int value
    wxString newmsg

void
Wx_ProgressDialog::Resume()
