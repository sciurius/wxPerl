#############################################################################
## Name:        ext/docview/XS/DocMDIParentFrame.xs
## Purpose:     XS for wxDocMDIParentFrame ( Document / View Framework )
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: DocMDIParentFrame.xs,v 1.3 2004/02/28 22:59:07 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::DocMDIParentFrame

Wx_DocMDIParentFrame *
Wx_DocMDIParentFrame::new( manager, frame = (wxFrame*) NULL, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr)
    Wx_DocManager* manager
    wxFrame* frame
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL=new wxPliDocMDIParentFrame(CLASS, manager, frame, id, title, pos, size, style, name);
  OUTPUT:
    RETVAL

Wx_DocManager*
Wx_DocMDIParentFrame::GetDocumentManager()

