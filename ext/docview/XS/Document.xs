#############################################################################
## Name:        Document.xs
## Purpose:     XS for wxDocument ( Document / View Framework )
## Author:      Simon Flack
## Modified by:
## Created:      11/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################


MODULE=Wx PACKAGE=Wx::Document

Wx_Document*
Wx_Document::new()
  CODE:
    RETVAL=new wxPliDocument( CLASS );
  OUTPUT:
    RETVAL

bool
Wx_Document::DeleteContents()

bool
Wx_Document::Close()

bool
Wx_Document::OnCloseDocument()

bool
Wx_Document::DeleteAllViews()

Wx_View*
Wx_Document::GetFirstView()

Wx_DocManager*
Wx_Document::GetDocumentManager()

Wx_DocTemplate*
Wx_Document::GetDocumentTemplate()

wxString
Wx_Document::GetDocumentName()

bool
Wx_Document::OnNewDocument()

bool
Wx_Document::Save()

bool
Wx_Document::SaveAs()

bool
Wx_Document::OnSaveDocument( file )
	wxString file

bool
Wx_Document::OnOpenDocument( file )
	wxString file

bool
Wx_Document::Revert()

bool
Wx_Document::GetPrintableName( buf )
	wxString buf

Wx_Window*
Wx_Document::GetDocumentWindow()

Wx_CommandProcessor*
Wx_Document::OnCreateCommandProcessor()

void
Wx_Document::SetCommandProcessor( processor )
    Wx_CommandProcessor* processor

bool
Wx_Document::OnSaveModified()

bool
Wx_Document::IsModified( )

void
Wx_Document::Modify( modify )
	bool modify

bool
Wx_Document::AddView( view )
	Wx_View* view

bool
Wx_Document::RemoveView( view )
	Wx_View* view

bool
Wx_Document::OnCreate( path, flags )
	wxString path
	long flags

void
Wx_Document::OnChangedViewList()

void
Wx_Document::UpdateAllViews(sender = NULL, hint = NULL)
	Wx_View* sender
	Wx_Object* hint

void
Wx_Document::SetFilename(filename, notifyViews = FALSE)
	wxString filename
	bool notifyViews

wxString
Wx_Document::GetFilename()

void
Wx_Document::SetTitle( title )
    wxString title

wxString
Wx_Document::GetTitle()

void
Wx_Document::SetDocumentName( name )
    wxString name

void
Wx_Document::SetDocumentTemplate( templ )
    Wx_DocTemplate* templ
