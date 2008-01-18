#############################################################################
## Name:        ext/print/XS/Printout.xs
## Purpose:     XS for Wx::Printout & Wx::PrinterDC
## Author:      Mattia Barbon
## Modified by:
## Created:     02/06/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2002, 2004, 2008 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/print.h>
#include <wx/dcprint.h>
#include "cpp/printout.h"

MODULE=Wx PACKAGE=Wx::PrinterDC

#if defined( __WXMSW__ )

wxPrinterDC*
wxPrinterDC::new( data )
    wxPrintData* data
  CODE:
    RETVAL = new wxPrinterDC( *data );
  OUTPUT:
    RETVAL

wxRect*
wxPrinterDC::GetPaperRect()
  CODE:
    RETVAL = new wxRect( THIS->GetPaperRect() );
  OUTPUT: RETVAL

#endif

MODULE=Wx PACKAGE=Wx::Printout

wxPrintout*
wxPrintout::new( title = wxT("Printout") )
    wxString title
  CODE:
    RETVAL = new wxPlPrintout( CLASS, title );
  OUTPUT:
    RETVAL

void
wxPrintout::Destroy()
  CODE:
    delete THIS;

wxDC*
wxPrintout::GetDC()
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );

void
wxPrintout::GetPageInfo()
  PREINIT:
    int minPage, maxPage, pageFrom, pageTo;
  PPCODE:
    THIS->wxPrintout::GetPageInfo( &minPage, &maxPage, &pageFrom, &pageTo );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( minPage ) ) );
    PUSHs( sv_2mortal( newSViv( maxPage ) ) );
    PUSHs( sv_2mortal( newSViv( pageFrom ) ) );
    PUSHs( sv_2mortal( newSViv( pageTo ) ) );

void
wxPrintout::GetPageSizeMM()
  PREINIT:
    int w, h;
  PPCODE:
    THIS->GetPageSizeMM( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

void
wxPrintout::GetPageSizePixels()
  PREINIT:
    int w, h;
  PPCODE:
    THIS->GetPageSizePixels( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

void
wxPrintout::GetPPIPrinter()
  PREINIT:
    int w, h;
  PPCODE:
    THIS->GetPPIPrinter( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

void
wxPrintout::GetPPIScreen()
  PREINIT:
    int w, h;
  PPCODE:
    THIS->GetPPIScreen( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

wxRect*
wxPrintout::GetPaperRectPixels()
  CODE:
    RETVAL = new wxRect( THIS->GetPaperRectPixels() );
  OUTPUT: RETVAL

#endif

wxString
wxPrintout::GetTitle()

bool
wxPrintout::HasPage( pageNum )
    int pageNum
  CODE:
    RETVAL = THIS->wxPrintout::HasPage( pageNum );
  OUTPUT:
    RETVAL

bool
wxPrintout::IsPreview()

bool
wxPrintout::OnBeginDocument( startPage, endPage )
    int startPage
    int endPage
  CODE:
    RETVAL = THIS->wxPrintout::OnBeginDocument( startPage, endPage );
  OUTPUT:
    RETVAL

void
wxPrintout::OnEndDocument()
  CODE:
    THIS->wxPrintout::OnEndDocument();

void
wxPrintout::OnBeginPrinting()
  CODE:
    THIS->wxPrintout::OnBeginPrinting();

void
wxPrintout::OnEndPrinting()
  CODE:
    THIS->wxPrintout::OnEndPrinting();

void
wxPrintout::OnPreparePrinting()
  CODE:
    THIS->wxPrintout::OnPreparePrinting();

#bool
#wxPrintout::OnPrintPage( pageNum )
#    int pageNum
#  CODE:
#    RETVAL = THIS->wxPrintout::OnPrintPage( pageNum );
#  OUTPUT:
#    RETVAL

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

void
wxPrintout::FitThisSizeToPaper( imageSize )
    wxSize imageSize

void
wxPrintout::FitThisSizeToPage( imageSize )
    wxSize imageSize

void
wxPrintout::FitThisSizeToPageMargins( imageSize, pageSetupData )
    wxSize imageSize
    wxPageSetupDialogData* pageSetupData
  C_ARGS: imageSize, *pageSetupData

void
wxPrintout::MapScreenSizeToPaper()

void
wxPrintout::MapScreenSizeToPage()

void
wxPrintout::MapScreenSizeToPageMargins( pageSetupData )
    wxPageSetupDialogData* pageSetupData
  C_ARGS: *pageSetupData

void
wxPrintout::MapScreenSizeToDevice()

wxRect*
wxPrintout::GetLogicalPaperRect()
  CODE:
    RETVAL = new wxRect( THIS->GetLogicalPaperRect() );
  OUTPUT: RETVAL

wxRect*
wxPrintout::GetLogicalPageRect()
  CODE:
    RETVAL = new wxRect( THIS->GetLogicalPageRect() );
  OUTPUT: RETVAL

wxRect*
wxPrintout::GetLogicalPageMarginsRect( pageSetupData )
    wxPageSetupDialogData* pageSetupData
  CODE:
    RETVAL = new wxRect( THIS->GetLogicalPageMarginsRect( *pageSetupData ) );
  OUTPUT: RETVAL

void
wxPrintout::SetLogicalOrigin( x, y )
    wxCoord x
    wxCoord y

void
wxPrintout::OffsetLogicalOrigin( xoff, yoff )
    wxCoord xoff
    wxCoord yoff

#endif
