#############################################################################
## Name:        ext/print/XS/PrintPreview.xs
## Purpose:     XS for Wx::PrintPreview
## Author:      Mattia Barbon
## Modified by:
## Created:     02/06/2001
## RCS-ID:      $Id: PrintPreview.xs,v 1.4 2004/02/28 22:59:07 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>

MODULE=Wx PACKAGE=Wx::PrintPreview

Wx_PrintPreview*
Wx_PrintPreview::new( printout, printoutForPrinting, data = 0 )
    Wx_Printout* printout
    Wx_Printout* printoutForPrinting
    Wx_PrintData* data

void
Wx_PrintPreview::Destroy()
  CODE:
    delete THIS;

Wx_Window*
Wx_PrintPreview::GetCanvas()

int
Wx_PrintPreview::GetCurrentPage()

wxFrame*
Wx_PrintPreview::GetFrame()

int
Wx_PrintPreview::GetMaxPage()

int
Wx_PrintPreview::GetMinPage()

# Wx_PrintData*
# Wx_PrintPreview::GetPrintData()
#   CODE:
#     RETVAL = &THIS->GetPrintData();
#  #UTPUT:
#    RETVAL

Wx_Printout*
Wx_PrintPreview::GetPrintout()

Wx_Printout*
Wx_PrintPreview::GetPrintoutForPrinting()

bool
Wx_PrintPreview::Ok()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

bool
wxPrintPreview::PaintPage( canvas, dc )
    wxPreviewCanvas* canvas
    wxDC* dc
  C_ARGS: canvas, *dc

#else

bool
Wx_PrintPreview::PaintPage( window, dc )
    wxWindow* window
    wxDC* dc
  C_ARGS: window, *dc

#endif

bool
Wx_PrintPreview::Print( prompt )
    bool prompt

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxPrintPreview::SetCanvas( canvas )
    wxPreviewCanvas* canvas

#else

void
wxPrintPreview::SetCanvas( window )
    wxWindow* window

#endif

void
Wx_PrintPreview::SetCurrentPage( pageNum )
    int pageNum

void
Wx_PrintPreview::SetFrame( frame )
    wxFrame* frame

void
Wx_PrintPreview::SetPrintout( printout )
    Wx_Printout* printout

void
Wx_PrintPreview::SetZoom( percent )
    int percent
