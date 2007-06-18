#############################################################################
## Name:        XS/FindReplaceDialog.xs
## Purpose:     XS for Wx::FindReplaceDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     07/09/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/fdrepdlg.h>

MODULE=Wx PACKAGE=Wx::FindReplaceData

wxFindReplaceData*
wxFindReplaceData::new( flags )
    int flags

void
wxFindReplaceData::Destroy()
  CODE:
    delete THIS;

wxString
wxFindReplaceData::GetFindString()

wxString
wxFindReplaceData::GetReplaceString()

int
wxFindReplaceData::GetFlags()

void
wxFindReplaceData::SetFlags( flags )
    int flags

void
wxFindReplaceData::SetFindString( find )
    wxString find

void
wxFindReplaceData::SetReplaceString( replace )
    wxString replace

MODULE=Wx PACKAGE=Wx::FindDialogEvent

int
wxFindDialogEvent::GetFlags()

wxString
wxFindDialogEvent::GetFindString()

wxString
wxFindDialogEvent::GetReplaceString()

wxFindReplaceDialog*
wxFindDialogEvent::GetDialog()

MODULE=Wx PACKAGE=Wx::FindReplaceDialog

wxFindReplaceDialog*
wxFindReplaceDialog::new( parent, data, title, style = 0 )
    wxWindow* parent
    wxFindReplaceData * data
    wxString title
    long style

wxFindReplaceData*
wxFindReplaceDialog::GetData()
  CODE:
    RETVAL = (wxFindReplaceData*)THIS->GetData();
  OUTPUT:
    RETVAL

void
wxFindReplaceDialog::SetData( data )
    wxFindReplaceData* data
