#############################################################################
## Name:        TextEntryDialog.xs
## Purpose:     XS for Wx::TextEntryDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::TextEntryDialog

Wx_TextEntryDialog*
Wx_TextEntryDialog::new( parent, message, caption = wxGetTextFromUserPromptStr, defaultValue = wxEmptyString, style = wxOK|wxCANCEL|wxCENTRE, pos = wxDefaultPosition )
    Wx_Window* parent
    wxString message
    wxString caption
    wxString defaultValue
    long style
    Wx_Point pos

wxString
Wx_TextEntryDialog::GetValue()

void
Wx_TextEntryDialog::SetValue( string )
    wxString string

int
Wx_TextEntryDialog::ShowModal()
