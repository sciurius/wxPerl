#############################################################################
## Name:        ext/docview/XS/DocTemplate.xs
## Purpose:     XS for wxDocTemplate (Document/View Framework)
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: DocTemplate.xs,v 1.5 2004/12/21 21:12:49 mbarbon Exp $
## Copyright:   (c) 2001, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::DocTemplate


wxDocTemplate *
wxDocTemplate::new(manager, descr, filter, dir, ext, docTypeName, viewTypeName, docClassInfo = NULL, viewClassInfo = NULL, flags = wxDEFAULT_TEMPLATE_FLAGS)
    wxDocManager* manager
    wxString descr
    wxString filter
    wxString dir
    wxString ext
    wxString docTypeName
    wxString viewTypeName
    SV* docClassInfo
    SV* viewClassInfo
    long flags
  PREINIT:
    wxClassInfo *docCInfo = 0, *viewCInfo = 0;
    wxString docClassName, viewClassName;
    bool hasDocInfo, hasViewInfo;
  CODE:
    if( docClassInfo )
    {
        hasDocInfo = SvROK( docClassInfo );
        if( hasDocInfo )
        {
            docCInfo = (wxClassInfo*)wxPli_sv_2_object( aTHX_ docClassInfo,
                                                        "Wx::ClassInfo" );
        }
        else
        {
            WXSTRING_INPUT( docClassName, wxString, docClassInfo );
        }
    }

    if( viewClassInfo )
    {
        hasViewInfo = SvROK( viewClassInfo );
        if( hasViewInfo )
        {
            viewCInfo = (wxClassInfo*)wxPli_sv_2_object( aTHX_ viewClassInfo,
                                                         "Wx::ClassInfo" );
        }
        else
        {
            WXSTRING_INPUT( viewClassName, wxString, viewClassInfo );
        }
    }

    RETVAL = new wxPliDocTemplate( CLASS, manager, descr, filter, dir, ext,
                                   docTypeName, viewTypeName,
                                   docCInfo, viewCInfo, flags,
                                   docClassName, viewClassName );
  OUTPUT:
    RETVAL

wxDocument *
wxDocTemplate::CreateDocument( path, flags )
    wxString path
    long flags

wxView *
wxDocTemplate::CreateView( doc, flags )
    wxDocument* doc
    long flags

wxString
wxDocTemplate::GetDefaultExtension()

wxString
wxDocTemplate::GetDescription()

wxString
wxDocTemplate::GetDirectory()

wxDocManager *
wxDocTemplate::GetDocumentManager()

void
wxDocTemplate::SetDocumentManager( manager )
    wxDocManager* manager

wxString
wxDocTemplate::GetFileFilter()

long
wxDocTemplate::GetFlags()

wxString
wxDocTemplate::GetViewName()

wxString
wxDocTemplate::GetDocumentName()

void
wxDocTemplate::SetFileFilter( filter )
    wxString filter

void
wxDocTemplate::SetDirectory( dir )
    wxString dir

void
wxDocTemplate::SetDescription( descr )
    wxString descr

void
wxDocTemplate::SetDefaultExtension( ext )
    wxString ext

void
wxDocTemplate::SetFlags( flags )
    long flags

bool
wxDocTemplate::IsVisible()

bool
wxDocTemplate::FileMatchesTemplate( path )
    wxString path
