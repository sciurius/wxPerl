#############################################################################
## Name:        FindReplaceDialog.xs
## Purpose:     XS for Wx::FindReplaceDialog
## Author:      Mattia Barbon
## Modified by:
## Created:      7/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

#include <wx/fdrepdlg.h>

MODULE=Wx PACKAGE=Wx::FindReplaceData

Wx_FindReplaceData*
Wx_FindReplaceData::new( flags )
    int flags

void
Wx_FindReplaceData::Destroy()
  CODE:
    delete THIS;

wxString
Wx_FindReplaceData::GetFindString()

wxString
Wx_FindReplaceData::GetReplaceString()

int
Wx_FindReplaceData::GetFlags()

void
Wx_FindReplaceData::SetFlags( flags )
    int flags

void
Wx_FindReplaceData::SetFindString( find )
    wxString find

void
Wx_FindReplaceData::SetReplaceString( replace )
    wxString replace

MODULE=Wx PACKAGE=Wx::FindDialogEvent

int
Wx_FindDialogEvent::GetFlags()

wxString
Wx_FindDialogEvent::GetFindString()

wxString
Wx_FindDialogEvent::GetReplaceString()

Wx_FindReplaceDialog*
Wx_FindDialogEvent::GetDialog()

MODULE=Wx PACKAGE=Wx::FindReplaceDialog

Wx_FindReplaceDialog*
Wx_FindReplaceDialog::new( parent, data, title, style )
    Wx_Window* parent
    Wx_FindReplaceData * data
    wxString title
    long style

Wx_FindReplaceData*
Wx_FindReplaceDialog::GetData()
  CODE:
    RETVAL = (Wx_FindReplaceData*)THIS->GetData();
  OUTPUT:
    RETVAL

void
Wx_FindReplaceDialog::SetData( data )
    Wx_FindReplaceData* data

#endif
