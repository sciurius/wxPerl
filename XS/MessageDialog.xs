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
