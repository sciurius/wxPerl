#############################################################################
## Name:        MessageDialog.xs
## Purpose:     XS for Wx::MessageDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/msgdlg.h>

MODULE=Wx PACKAGE=Wx::MessageDialog

Wx_MessageDialog*
Wx_MessageDialog::new( parent, message, caption = wxMessageBoxCaptionStr, style = wxOK|wxCANCEL|wxCENTRE, pos = wxDefaultPosition )
    Wx_Window* parent
    wxString message
    wxString caption
    long style
    Wx_Point pos

int
Wx_MessageDialog::ShowModal()

MODULE=Wx PACKAGE=Wx PREFIX=wx

int
wxMessageBox( message, caption = "Message", style = wxOK|wxCENTRE, parent = 0, x = -1, y = -1 )
    wxString message
    wxString caption
    int style
    Wx_Window* parent
    int x
    int y


