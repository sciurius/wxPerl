#############################################################################
## Name:        DocMDIChildFrame.xs
## Purpose:     XS for wxDocMDIChildFrame ( Document / View framework )
## Author:      Simon Flack
## Modified by:
## Created:      11/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################


MODULE=Wx PACKAGE=Wx::DocMDIChildFrame

Wx_DocMDIChildFrame *
Wx_DocMDIChildFrame::new(doc, view, frame, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr)
    Wx_Document* doc
    Wx_View* view
    Wx_MDIParentFrame* frame
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL=new wxPliDocMDIChildFrame(CLASS, doc, view, frame, id, title, pos, size, style, name);
  OUTPUT:
    RETVAL

Wx_Document *
Wx_DocMDIChildFrame::GetDocument()

Wx_View *
Wx_DocMDIChildFrame::GetView()

void
Wx_DocMDIChildFrame::SetDocument( doc )
    Wx_Document* doc

void
Wx_DocMDIChildFrame::SetView( view )
    Wx_View* view

bool
Wx_DocMDIChildFrame::Destroy()

## Some event stuff missing here
