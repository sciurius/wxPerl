#############################################################################
## Name:        ext/docview/XS/Document.xs
## Purpose:     XS for wxDocument (Document/View Framework)
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: Document.xs,v 1.6 2004/12/21 21:12:49 mbarbon Exp $
## Copyright:   (c) 2001, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################


MODULE=Wx PACKAGE=Wx::Document

wxDocument*
wxDocument::new()
  CODE:
    RETVAL=new wxPliDocument( CLASS );
  OUTPUT:
    RETVAL

bool
wxDocument::DeleteContents()

bool
wxDocument::Close()

bool
wxDocument::OnCloseDocument()

void
wxDocument::NotifyClosing()

SV*
wxDocument::GetViews()
  CODE:
    AV* arrViews = wxPli_objlist_2_av( aTHX_ THIS->GetViews() );
    RETVAL = newRV_noinc( (SV*)arrViews  );
  OUTPUT: RETVAL

bool
wxDocument::DeleteAllViews()

wxView*
wxDocument::GetFirstView()

wxDocManager*
wxDocument::GetDocumentManager()

wxDocTemplate*
wxDocument::GetDocumentTemplate()

wxString
wxDocument::GetDocumentName()

bool
wxDocument::OnNewDocument()

bool
wxDocument::Save()

bool
wxDocument::SaveAs()

bool
wxDocument::OnSaveDocument( file )
	wxString file

bool
wxDocument::OnOpenDocument( file )
	wxString file

bool
wxDocument::GetDocumentSaved()

void
wxDocument::SetDocumentSaved( saved )
    bool saved

bool
wxDocument::Revert()

bool
wxDocument::GetPrintableName( buf )
	wxString buf

wxWindow*
wxDocument::GetDocumentWindow()

wxCommandProcessor*
wxDocument::OnCreateCommandProcessor()

void
wxDocument::SetCommandProcessor( processor )
    wxCommandProcessor* processor

bool
wxDocument::OnSaveModified()

bool
wxDocument::IsModified( )

void
wxDocument::Modify( modify )
	bool modify

bool
wxDocument::AddView( view )
	wxView* view

bool
wxDocument::RemoveView( view )
	wxView* view

bool
wxDocument::OnCreate( path, flags )
	wxString path
	long flags

void
wxDocument::OnChangedViewList()

void
wxDocument::UpdateAllViews(sender = NULL, hint = NULL)
	wxView* sender
	wxObject* hint

void
wxDocument::SetFilename(filename, notifyViews = false)
	wxString filename
	bool notifyViews

wxString
wxDocument::GetFilename()

void
wxDocument::SetTitle( title )
    wxString title

wxString
wxDocument::GetTitle()

void
wxDocument::SetDocumentName( name )
    wxString name

void
wxDocument::SetDocumentTemplate( templ )
    wxDocTemplate* templ
