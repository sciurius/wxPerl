#############################################################################
## Name:        Notebook.xs
## Purpose:     XS for Wx::Notebook
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/notebook.h>

MODULE=Wx_Evt PACKAGE=Wx::NotebookEvent

Wx_NotebookEvent*
Wx_NotebookEvent::new( eventType = wxEVT_NULL, id = 0, sel = -1, oldSel = -1 )
    wxEventType eventType
    int id
    int sel
    int oldSel

int
Wx_NotebookEvent::GetOldSelection()

int
Wx_NotebookEvent::GetSelection()

void
Wx_NotebookEvent::SetOldSelection( sel )
    int sel

void
Wx_NotebookEvent::SetSelection( oldSel )
    int oldSel

MODULE=Wx PACKAGE=Wx::Notebook

Wx_Notebook*
Wx_Notebook::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("notebook") )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliNotebook( CLASS, parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

bool
Wx_Notebook::AddPage( page, text, select = FALSE, imageId = -1 )
    Wx_Window* page
    wxString text
    bool select
    int imageId

void
Wx_Notebook::AdvanceSelection( forward = TRUE )
    bool forward

bool
Wx_Notebook::DeleteAllPages()

bool
Wx_Notebook::DeletePage( page )
    int page

Wx_ImageList*
Wx_Notebook::GetImageList()

Wx_Window*
Wx_Notebook::GetPage( page )
    int page

int
Wx_Notebook::GetPageCount()

int
Wx_Notebook::GetPageImage( page )
    int page

wxString
Wx_Notebook::GetPageText( page )
    int page

int
Wx_Notebook::GetRowCount()

int
Wx_Notebook::GetSelection()

bool
Wx_Notebook::InsertPage( index, page, text, select = FALSE, imageId = -1 )
    int index
    Wx_Window* page
    wxString text
    bool select
    int imageId

bool
Wx_Notebook::RemovePage( page )
    int page

void
Wx_Notebook::SetImageList( imagelist )
    Wx_ImageList* imagelist

#if !defined( __WXMOTIF__ ) && !defined( __WXGTK__ ) || \
  defined( __WXPERL_FORCE__ )

void
Wx_Notebook::SetPadding( padding )
    Wx_Size padding

void
Wx_Notebook::SetPageSize( padding )
    Wx_Size padding

#endif

bool
Wx_Notebook::SetPageImage( page, image )
    int page
    int image

bool
Wx_Notebook::SetPageText( page, text )
    int page
    wxString text

int
Wx_Notebook::SetSelection( page )
    int page
