#############################################################################
## Name:        DoxTemplate.xs
## Purpose:     XS for wxDocTemplate ( Document / View Framework )
## Author:      Simon Flack
## Modified by:
## Created:      11/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::DocTemplate


Wx_DocTemplate *
Wx_DocTemplate::new(manager, descr, filter, dir, ext, docTypeName, viewTypeName, docClassInfo = NULL, viewClassInfo = NULL, flags = wxDEFAULT_TEMPLATE_FLAGS)
    Wx_DocManager* manager
    wxString descr
    wxString filter
    wxString dir
    wxString ext
    wxString docTypeName
    wxString viewTypeName
    Wx_ClassInfo* docClassInfo
    Wx_ClassInfo* viewClassInfo
    long flags
  CODE:
    RETVAL=new wxPliDocTemplate(CLASS, manager, descr, filter, dir, ext, docTypeName, viewTypeName, docClassInfo, viewClassInfo, flags);
  OUTPUT:
    RETVAL

Wx_Document *
Wx_DocTemplate::CreateDocument( path, flags )
    wxString path
    long flags

Wx_View *
Wx_DocTemplate::CreateView( doc, flags )
    Wx_Document* doc
    long flags

wxString
Wx_DocTemplate::GetDefaultExtension()

wxString
Wx_DocTemplate::GetDescription()

wxString
Wx_DocTemplate::GetDirectory()

Wx_DocManager *
Wx_DocTemplate::GetDocumentManager()

void
Wx_DocTemplate::SetDocumentManager( manager )
    Wx_DocManager* manager

wxString
Wx_DocTemplate::GetFileFilter()

long
Wx_DocTemplate::GetFlags()

wxString
Wx_DocTemplate::GetViewName()

wxString
Wx_DocTemplate::GetDocumentName()

void
Wx_DocTemplate::SetFileFilter( filter )
    wxString filter

void
Wx_DocTemplate::SetDirectory( dir )
    wxString dir

void
Wx_DocTemplate::SetDescription( descr )
    wxString descr

void
Wx_DocTemplate::SetDefaultExtension( ext )
    wxString ext

void
Wx_DocTemplate::SetFlags( flags )
    long flags

bool
Wx_DocTemplate::IsVisible()

bool
Wx_DocTemplate::FileMatchesTemplate( path )
    wxString path
