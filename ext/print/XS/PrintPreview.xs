#############################################################################
## Name:        PrintPreview.xs
## Purpose:     XS for Wx::PrintPreview
## Author:      Mattia Barbon
## Modified by:
## Created:      2/ 6/2001
## RCS-ID:      
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
Wx_PrintPreview::DESTROY()

Wx_Window*
Wx_PrintPreview::GetCanvas()

int
Wx_PrintPreview::GetCurrentPage()

Wx_Frame*
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

bool
Wx_PrintPreview::PaintPage( window, dc )
    Wx_Window* window
    Wx_DC* dc
  CODE:
    RETVAL = THIS->PaintPage( window, *dc );
  OUTPUT:
    RETVAL

bool
Wx_PrintPreview::Print( prompt )
    bool prompt

void
Wx_PrintPreview::SetCanvas( window )
    Wx_Window* window

void
Wx_PrintPreview::SetCurrentPage( pageNum )
    int pageNum

void
Wx_PrintPreview::SetFrame( frame )
    Wx_Frame* frame

void
Wx_PrintPreview::SetPrintout( printout )
    Wx_Printout* printout

void
Wx_PrintPreview::SetZoom( percent )
    int percent
