#############################################################################
## Name:        XS/Notebook.xs
## Purpose:     XS for Wx::Notebook
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Notebook.xs,v 1.11 2003/12/13 17:13:29 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/notebook.h>

MODULE=Wx_Evt PACKAGE=Wx::NotebookEvent

wxNotebookEvent*
wxNotebookEvent::new( eventType = wxEVT_NULL, id = 0, sel = -1, oldSel = -1 )
    wxEventType eventType
    int id
    int sel
    int oldSel

#if WXPERL_W_VERSION_LE( 2, 5, 0 )

int
wxNotebookEvent::GetOldSelection()

int
wxNotebookEvent::GetSelection()

void
wxNotebookEvent::SetOldSelection( sel )
    int sel

void
wxNotebookEvent::SetSelection( oldSel )
    int oldSel

#endif

MODULE=Wx PACKAGE=Wx::Notebook

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Notebook::new" )

wxNotebook*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxNotebook();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxNotebook*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("notebook") )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxNotebook( parent, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxNotebook::Create( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("notebook") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

#if WXPERL_W_VERSION_LE( 2, 5, 0 )

bool
wxNotebook::AddPage( page, text, select = FALSE, imageId = -1 )
    wxWindow* page
    wxString text
    bool select
    int imageId

void
wxNotebook::AdvanceSelection( forward = TRUE )
    bool forward

bool
wxNotebook::DeleteAllPages()

bool
wxNotebook::DeletePage( page )
    int page

wxImageList*
wxNotebook::GetImageList()
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), FALSE );

wxWindow*
wxNotebook::GetPage( page )
    int page

int
wxNotebook::GetPageCount()

int
wxNotebook::GetPageImage( page )
    int page

wxString
wxNotebook::GetPageText( page )
    int page

int
wxNotebook::GetSelection()

bool
wxNotebook::InsertPage( index, page, text, select = FALSE, imageId = -1 )
    int index
    wxWindow* page
    wxString text
    bool select
    int imageId

bool
wxNotebook::RemovePage( page )
    int page

void
wxNotebook::SetImageList( imagelist )
    wxImageList* imagelist

bool
wxNotebook::SetPageImage( page, image )
    int page
    int image

bool
wxNotebook::SetPageText( page, text )
    int page
    wxString text

int
wxNotebook::SetSelection( page )
    int page

#endif

int
wxNotebook::GetRowCount()

#if !defined( __WXMOTIF__ ) && !defined( __WXGTK__ ) || \
  defined( __WXPERL_FORCE__ )

void
wxNotebook::SetPadding( padding )
    wxSize padding

void
wxNotebook::SetPageSize( padding )
    wxSize padding

#endif
