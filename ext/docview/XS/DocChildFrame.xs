#############################################################################
## Name:        DocChildFrame.xs
## Purpose:     XS for wxDocChildFrame ( Document / View framwork )
## Author:      Simon Flack
## Modified by:
## Created:      11/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::DocChildFrame

Wx_DocChildFrame *
Wx_DocChildFrame::new(doc, view, frame, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr)
    Wx_Document* doc
    Wx_View* view
    Wx_Frame* frame
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL=new wxPliDocChildFrame(CLASS, doc, view, frame, id, title, pos, size, style, name);
  OUTPUT:
    RETVAL

Wx_Document *
Wx_DocChildFrame::GetDocument()

Wx_View *
Wx_DocChildFrame::GetView()

void
Wx_DocChildFrame::SetDocument( doc )
    Wx_Document* doc

void
Wx_DocChildFrame::SetView( view )
    Wx_View* view

bool
Wx_DocChildFrame::Destroy()

## Some event stuff missing here

