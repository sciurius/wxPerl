#############################################################################
## Name:        ext/docview/XS/DocMDIChildFrame.xs
## Purpose:     XS for wxDocMDIChildFrame (Document/View framework)
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: DocMDIChildFrame.xs,v 1.2 2004/02/29 14:30:40 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################


MODULE=Wx PACKAGE=Wx::DocMDIChildFrame

wxDocMDIChildFrame *
wxDocMDIChildFrame::new(doc, view, frame, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr)
    wxDocument* doc
    wxView* view
    wxMDIParentFrame* frame
    wxWindowID id
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL=new wxPliDocMDIChildFrame(CLASS, doc, view, frame, id, title, pos, size, style, name);
  OUTPUT:
    RETVAL

wxDocument *
wxDocMDIChildFrame::GetDocument()

wxView *
wxDocMDIChildFrame::GetView()

void
wxDocMDIChildFrame::SetDocument( doc )
    wxDocument* doc

void
wxDocMDIChildFrame::SetView( view )
    wxView* view

bool
wxDocMDIChildFrame::Destroy()

## Some event stuff missing here
