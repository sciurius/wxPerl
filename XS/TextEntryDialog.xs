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

#include <wx/textdlg.h>

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

MODULE=Wx PACKAGE=Wx PREFIX=wx

long
wxGetNumberFromUser( message, prompt, caption, value, min = 0, max = 100, parent = 0, pos = wxDefaultPosition )
    wxString message
    wxString prompt
    wxString caption
    long value
    long min
    long max
    Wx_Window* parent
    Wx_Point pos
  CODE:
    RETVAL = wxGetNumberFromUser( message, prompt, caption, value, min, max, parent, pos );
  OUTPUT:
    RETVAL

wxString
wxGetPasswordFromUser( message, caption = wxGetTextFromUserPromptStr, default_value = wxEmptyString, parent = 0 )
  wxString message
  wxString caption
  wxString default_value
  Wx_Window* parent

wxString
wxGetTextFromUser( message, caption = wxGetTextFromUserPromptStr, default_value = wxEmptyString, parent = 0, x = -1, y = -1, centre = TRUE )
  wxString message
  wxString caption
  wxString default_value
  Wx_Window* parent
  int x
  int y
  bool centre




