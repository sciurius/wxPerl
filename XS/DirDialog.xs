#############################################################################
## Name:        DirDialog.xs
## Purpose:     XS for Wx::DirDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dirdlg.h>

MODULE=Wx PACKAGE=Wx::DirDialog

Wx_DirDialog*
Wx_DirDialog::new( parent, message = wxFileSelectorPromptStr, defaultPath = wxEmptyString, style = 0, pos = wxDefaultPosition )
    Wx_Window* parent
    wxString message
    wxString defaultPath
    long style
    Wx_Point pos

wxString
Wx_DirDialog::GetPath()

wxString
Wx_DirDialog::GetMessage()

long
Wx_DirDialog::GetStyle()

void
Wx_DirDialog::SetMessage( message )
    wxString message

void
Wx_DirDialog::SetPath( path )
    wxString path

void
Wx_DirDialog::SetStyle( style )
    long style

int
Wx_DirDialog::ShowModal()
