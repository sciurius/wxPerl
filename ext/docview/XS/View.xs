#############################################################################
## Name:        ext/docview/XS/View.xs
## Purpose:     XS for wxView (Document/View Framework)
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002-2004, 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::View

wxView*
wxView::new()
  CODE:
    RETVAL=new wxPliView( CLASS );
  OUTPUT:
    RETVAL

void
wxView::Activate( activate )
    bool activate

bool
wxView::Close( deleteWindow = 1 )
    bool deleteWindow

wxDocument *
wxView::GetDocument()

wxDocManager *
wxView::GetDocumentManager()

wxWindow * 
wxView::GetFrame()

void
wxView::SetFrame( frame )
    wxWindow* frame

wxString
wxView::GetViewName()

void
wxView::OnActivateView( activate = 0, activeView, deactiveView )
    bool activate
    wxView* activeView
    wxView* deactiveView

void
wxView::OnChangeFilename()

bool
wxView::OnClose( deleteWindow = 0 )
    bool deleteWindow

bool
wxView::OnCreate( doc, flags = 0 )
    wxDocument* doc
    long flags

#if wxPERL_USE_PRINTING_ARCHITECTURE

wxPrintout*
wxView::OnCreatePrintout()

#endif

void
wxView::OnUpdate( sender, hint = NULL )
    wxView* sender
    wxObject* hint

void
wxView::SetDocument( doc )
    wxDocument* doc

void
wxView::SetViewName( name )
    wxString name

#!sub OnDraw
#!sub OnClosingDocument
