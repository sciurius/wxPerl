#############################################################################
## Name:        View.xs
## Purpose:     XS for wxView ( Document / View Framework )
## Author:      Simon Flack
## Modified by:
## Created:     11/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2002-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::View

Wx_View*
Wx_View::new()
  CODE:
    RETVAL=new wxPliView( CLASS );
  OUTPUT:
    RETVAL

void
Wx_View::Activate( activate )
    bool activate

bool
Wx_View::Close( deleteWindow = 1 )
    bool deleteWindow

Wx_Document *
Wx_View::GetDocument()

Wx_DocManager *
Wx_View::GetDocumentManager()

Wx_Window * 
Wx_View::GetFrame()

void
Wx_View::SetFrame( frame )
    Wx_Window* frame

wxString
Wx_View::GetViewName()

void
Wx_View::OnActivateView( activate = 0, activeView, deactiveView )
    bool activate
    Wx_View* activeView
    Wx_View* deactiveView

void
Wx_View::OnChangeFilename()

bool
Wx_View::OnClose( deleteWindow = 0 )
    bool deleteWindow

bool
Wx_View::OnCreate( doc, flags = 0 )
    Wx_Document* doc
    long flags


Wx_Printout*
Wx_View::OnCreatePrintout()

void
Wx_View::OnUpdate( sender, hint = NULL )
    Wx_View* sender
    Wx_Object* hint

void
Wx_View::SetDocument( doc )
    Wx_Document* doc

void
Wx_View::SetViewName( name )
    wxString name

