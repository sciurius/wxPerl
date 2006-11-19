#############################################################################
## Name:        XS/DirDialog.xs
## Purpose:     XS for Wx::DirDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     27/11/2000
## RCS-ID:      $Id: DirDialog.xs,v 1.9 2006/11/19 16:06:44 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dirdlg.h>

MODULE=Wx PACKAGE=Wx::DirDialog

wxDirDialog*
wxDirDialog::new( parent, message = wxFileSelectorPromptStr, defaultPath = wxEmptyString, style = 0, pos = wxDefaultPosition )
    wxWindow* parent
    wxString message
    wxString defaultPath
    long style
    wxPoint pos

wxString
wxDirDialog::GetPath()

wxString
wxDirDialog::GetMessage()

#if WXPERL_W_VERSION_LT( 2, 7, 0 )

long
wxDirDialog::GetStyle()

#endif

void
wxDirDialog::SetMessage( message )
    wxString message

void
wxDirDialog::SetPath( path )
    wxString path

#if WXPERL_W_VERSION_LT( 2, 7, 0 )

void
wxDirDialog::SetStyle( style )
    long style

#endif

int
wxDirDialog::ShowModal()

MODULE=Wx PACKAGE=Wx PREFIX=wx

wxString
wxDirSelector( message, default_path = wxEmptyString, style = 0, pos = wxDefaultPosition, parent = 0 )
    wxString message
    wxString default_path
    long style
    wxPoint pos
    wxWindow* parent
