#############################################################################
## Name:        Printout.xs
## Purpose:     XS for Wx::Printout & Wx::PrinterDC
## Author:      Mattia Barbon
## Modified by:
## Created:      2/ 6/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>
#include <wx/dcprint.h>
#include "cpp/printout.h"

MODULE=Wx PACKAGE=Wx::PrinterDC

Wx_PrinterDC*
Wx_PrinterDC::new( data )
    Wx_PrintData* data
  CODE:
    RETVAL = new wxPrinterDC( *data );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::Printout

Wx_Printout*
Wx_Printout::new( title = "Printout" )
    wxString title
  CODE:
    RETVAL = new wxPlPrintout( CLASS, title );
  OUTPUT:
    RETVAL

void
Wx_Printout::DESTROY()

Wx_DC*
Wx_Printout::GetDC()

void
Wx_Printout::GetPageInfo()
  PREINIT:
    int minPage, maxPage, pageFrom, pageTo;
  PPCODE:
    THIS->GetPageInfo( &minPage, &maxPage, &pageFrom, &pageTo );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( minPage ) ) );
    PUSHs( sv_2mortal( newSViv( maxPage ) ) );
    PUSHs( sv_2mortal( newSViv( pageFrom ) ) );
    PUSHs( sv_2mortal( newSViv( pageTo ) ) );

void
Wx_Printout::GetPageSizeMM()
  PREINIT:
    int w, h;
  PPCODE:
    THIS->GetPageSizeMM( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

void
Wx_Printout::GetPageSizePixels()
  PREINIT:
    int w, h;
  PPCODE:
    THIS->GetPageSizePixels( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

void
Wx_Printout::GetPPIPrinter()
  PREINIT:
    int w, h;
  PPCODE:
    THIS->GetPPIPrinter( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

void
Wx_Printout::GetPPIScreen()
  PREINIT:
    int w, h;
  PPCODE:
    THIS->GetPPIScreen( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

bool
Wx_Printout::HasPage( pageNum )
    int pageNum
  CODE:
    RETVAL = THIS->wxPrintout::HasPage( pageNum );
  OUTPUT:
    RETVAL

bool
Wx_Printout::IsPreview()

bool
Wx_Printout::OnBeginDocument( startPage, endPage )
    int startPage
    int endPage
  CODE:
    RETVAL = THIS->wxPrintout::OnBeginDocument( startPage, endPage );
  OUTPUT:
    RETVAL

void
Wx_Printout::OnEndDocument()
  CODE:
    THIS->wxPrintout::OnEndDocument();

void
Wx_Printout::OnBeginPrinting()
  CODE:
    THIS->wxPrintout::OnBeginPrinting();

void
Wx_Printout::OnEndPrinting()
  CODE:
    THIS->wxPrintout::OnEndPrinting();

void
Wx_Printout::OnPreparePrinting()
  CODE:
    THIS->wxPrintout::OnPreparePrinting();

#bool
#Wx_Printout::OnPrintPage( pageNum )
#    int pageNum
#  CODE:
#    RETVAL = THIS->wxPrintout::OnPrintPage( pageNum );
#  OUTPUT:
#    RETVAL
