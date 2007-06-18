#############################################################################
## Name:        ext/print/XS/PrintPreview.xs
## Purpose:     XS for Wx::PrintPreview
## Author:      Mattia Barbon
## Modified by:
## Created:     02/06/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001, 2004-2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>

MODULE=Wx PACKAGE=Wx::PrintPreview

wxPrintPreview*
wxPrintPreview::new( printout, printoutForPrinting, data = 0 )
    wxPrintout* printout
    wxPrintout* printoutForPrinting
    wxPrintData* data

void
wxPrintPreview::Destroy()
  CODE:
    delete THIS;

wxWindow*
wxPrintPreview::GetCanvas()

int
wxPrintPreview::GetCurrentPage()

wxFrame*
wxPrintPreview::GetFrame()

int
wxPrintPreview::GetMaxPage()

int
wxPrintPreview::GetMinPage()

wxPrintout*
wxPrintPreview::GetPrintout()

wxPrintout*
wxPrintPreview::GetPrintoutForPrinting()

bool
wxPrintPreview::Ok()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

bool
wxPrintPreview::PaintPage( canvas, dc )
    wxPreviewCanvas* canvas
    wxDC* dc
  C_ARGS: canvas, *dc

#else

bool
wxPrintPreview::PaintPage( window, dc )
    wxWindow* window
    wxDC* dc
  C_ARGS: window, *dc

#endif

bool
wxPrintPreview::Print( prompt )
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
wxPrintPreview::SetCurrentPage( pageNum )
    int pageNum

void
wxPrintPreview::SetFrame( frame )
    wxFrame* frame

void
wxPrintPreview::SetPrintout( printout )
    wxPrintout* printout

void
wxPrintPreview::SetZoom( percent )
    int percent
