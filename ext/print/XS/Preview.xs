#############################################################################
## Name:        ext/print/XS/Preview.xs
## Purpose:     XS for Wx::PreviewCanvas, Frame & ControlBar
## Author:      Mattia Barbon
## Modified by:
## Created:     02/06/2001
## RCS-ID:      $Id: Preview.xs,v 1.7 2004/11/09 21:07:07 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>

MODULE=Wx PACKAGE=Wx::PreviewControlBar

wxPreviewControlBar*
wxPreviewControlBar::new( preview, buttons, parent, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("panel") )
    wxPrintPreview* preview
    long buttons
    wxWindow* parent
    wxPoint pos
    wxSize size
    long style
    wxString name

wxPrintPreview*
wxPreviewControlBar::GetPrintPreview()
  CODE:
    RETVAL = (wxPrintPreview*)THIS->GetPrintPreview();
  OUTPUT:
    RETVAL

int
wxPreviewControlBar::GetZoomControl()

void
wxPreviewControlBar::SetZoomControl( zoom )
    int zoom

MODULE=Wx PACKAGE=Wx::PreviewCanvas

wxPreviewCanvas*
wxPreviewCanvas::new( preview, parent, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("canvas") )
    wxPrintPreview* preview
    wxWindow* parent
    wxPoint pos
    wxSize size
    long style
    wxString name

MODULE=Wx PACKAGE=Wx::PreviewFrame

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxPreviewFrame*
wxPreviewFrame::new( preview, parent, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxT("frame") )
    wxPrintPreview* preview
    wxWindow* parent
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name

#else

wxPreviewFrame*
wxPreviewFrame::new( preview, parent, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxT("frame") )
    wxPrintPreview* preview
    wxFrame* parent
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name

#endif

void
wxPreviewFrame::Initialize()

