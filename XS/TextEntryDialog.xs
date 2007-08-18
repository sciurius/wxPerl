#############################################################################
## Name:        XS/TextEntryDialog.xs
## Purpose:     XS for Wx::TextEntryDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2001, 2004, 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/textdlg.h>

MODULE=Wx PACKAGE=Wx::TextEntryDialog

wxTextEntryDialog*
wxTextEntryDialog::new( parent, message, caption = wxGetTextFromUserPromptStr, defaultValue = wxEmptyString, style = wxTextEntryDialogStyle, pos = wxDefaultPosition )
    wxWindow* parent
    wxString message
    wxString caption
    wxString defaultValue
    long style
    wxPoint pos

wxString
wxTextEntryDialog::GetValue()

void
wxTextEntryDialog::SetValue( string )
    wxString string

int
wxTextEntryDialog::ShowModal()

MODULE=Wx PACKAGE=Wx::PasswordEntryDialog

#if WXPERL_W_VERSION_GE( 2, 6, 0 )

wxPasswordEntryDialog*
wxPasswordEntryDialog::new( parent, message, caption = wxGetPasswordFromUserPromptStr, defaultValue = wxEmptyString, style = wxTextEntryDialogStyle, pos = wxDefaultPosition )
    wxWindow* parent
    wxString message
    wxString caption
    wxString defaultValue
    long style
    wxPoint pos

#endif

MODULE=Wx PACKAGE=Wx::NumberEntryDialog

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

#include <wx/numdlg.h>

wxNumberEntryDialog*
wxNumberEntryDialog::new( parent, message, prompt, caption, value, min, max, pos )
    wxWindow* parent
    wxString message
    wxString prompt
    wxString caption
    long value
    long min
    long max
    wxPoint pos

long
wxNumberEntryDialog::GetValue()

#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

long
wxGetNumberFromUser( message, prompt, caption, value, min = 0, max = 100, parent = 0, pos = wxDefaultPosition )
    wxString message
    wxString prompt
    wxString caption
    long value
    long min
    long max
    wxWindow* parent
    wxPoint pos
  CODE:
    RETVAL = wxGetNumberFromUser( message, prompt, caption, value, min, max, parent, pos );
  OUTPUT:
    RETVAL

wxString
wxGetPasswordFromUser( message, caption = wxGetTextFromUserPromptStr, default_value = wxEmptyString, parent = 0 )
  wxString message
  wxString caption
  wxString default_value
  wxWindow* parent

wxString
wxGetTextFromUser( message, caption = wxGetTextFromUserPromptStr, default_value = wxEmptyString, parent = 0, x = -1, y = -1, centre = true )
  wxString message
  wxString caption
  wxString default_value
  wxWindow* parent
  int x
  int y
  bool centre




