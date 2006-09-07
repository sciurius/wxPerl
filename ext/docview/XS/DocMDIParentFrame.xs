#############################################################################
## Name:        ext/docview/XS/DocMDIParentFrame.xs
## Purpose:     XS for wxDocMDIParentFrame (Document/View Framework)
## Author:      Simon Flack
## Modified by:
## Created:     11/09/2002
## RCS-ID:      $Id: DocMDIParentFrame.xs,v 1.6 2006/09/07 20:33:13 mbarbon Exp $
## Copyright:   (c) 2001, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::DocMDIParentFrame

wxDocMDIParentFrame *
wxDocMDIParentFrame::new( manager, frame, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr)
    wxDocManager* manager
    wxFrame* frame
    wxWindowID id
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL=new wxPliDocMDIParentFrame(CLASS, manager, frame, id, title, pos, size, style, name);
  OUTPUT:
    RETVAL

wxDocManager*
wxDocMDIParentFrame::GetDocumentManager()

