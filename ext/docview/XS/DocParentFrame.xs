#############################################################################
## Name:        ext/docview/XS/DocParentFrame.xs
## Purpose:     XS for wxDocParentFrame ( Document / View Framework )
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: DocParentFrame.xs,v 1.2 2004/02/28 22:59:07 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::DocParentFrame

Wx_DocParentFrame *
Wx_DocParentFrame::new( manager, frame, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr)
    Wx_DocManager* manager
    wxFrame* frame
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL=new wxPliDocParentFrame(CLASS, manager, frame, id, title, pos, size, style, name);
  OUTPUT:
    RETVAL

## Some event stuff missing here

Wx_DocManager*
Wx_DocParentFrame::GetDocumentManager()

