#############################################################################
## Name:        ext/print/XS/Preview.xs
## Purpose:     XS for Wx::PreviewCanvas, Frame & ControlBar
## Author:      Mattia Barbon
## Modified by:
## Created:     02/06/2001
## RCS-ID:      $Id: Preview.xs,v 1.4 2004/02/28 22:59:07 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>

MODULE=Wx PACKAGE=Wx::PreviewControlBar

Wx_PreviewControlBar*
Wx_PreviewControlBar::new( preview, buttons, parent, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("panel") )
    Wx_PrintPreview* preview
    long buttons
    Wx_Window* parent
    Wx_Point pos
    Wx_Size size
    long style
    wxString name

Wx_PrintPreview*
Wx_PreviewControlBar::GetPrintPreview()
  CODE:
    RETVAL = (Wx_PrintPreview*)THIS->GetPrintPreview();
  OUTPUT:
    RETVAL

int
Wx_PreviewControlBar::GetZoomControl()

void
Wx_PreviewControlBar::SetZoomControl( zoom )
    int zoom

MODULE=Wx PACKAGE=Wx::PreviewCanvas

Wx_PreviewCanvas*
Wx_PreviewCanvas::new( preview, parent, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("canvas") )
    Wx_PrintPreview* preview
    Wx_Window* parent
    Wx_Point pos
    Wx_Size size
    long style
    wxString name

MODULE=Wx PACKAGE=Wx::PreviewFrame

Wx_PreviewFrame*
Wx_PreviewFrame::new( preview, parent, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxT("frame") )
    Wx_PrintPreview* preview
    wxFrame* parent
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name

void
Wx_PreviewFrame::Initialize()

