#############################################################################
## Name:        ext/html/XS/HtmlEasyPrinting.xs
## Purpose:     XS for Wx::HtmlEasyPrinting
## Author:      Mattia Barbon
## Modified by:
## Created:     04/05/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2004, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/htmprint.h>

MODULE=Wx PACKAGE=Wx::HtmlEasyPrinting

wxHtmlEasyPrinting*
wxHtmlEasyPrinting::new( wxString name = wxT("Printing"), \
                         wxWindow* parent = 0 )

static void
wxHtmlEasyPrinting::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxHtmlEasyPrinting::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::HtmlEasyPrinting", THIS, ST(0) );
    delete THIS;

bool
wxHtmlEasyPrinting::PreviewFile( htmlFile )
    wxString htmlFile

bool
wxHtmlEasyPrinting::PreviewText( htmlText, basepath = wxEmptyString )
    wxString htmlText
    wxString basepath

bool
wxHtmlEasyPrinting::PrintFile( htmlFile )
    wxString htmlFile

bool
wxHtmlEasyPrinting::PrintText( htmlText, basepath = wxEmptyString )
    wxString htmlText
    wxString basepath

void
wxHtmlEasyPrinting::PageSetup()

void
wxHtmlEasyPrinting::SetHeader( header, pg = wxPAGE_ALL )
    wxString header
    int pg

void
wxHtmlEasyPrinting::SetFonts( normal_face, fixed_face, sizes )
    wxString normal_face
    wxString fixed_face
    SV* sizes
  PREINIT:
    int* array;
    int n = wxPli_av_2_intarray( aTHX_ sizes, &array );
  CODE:
    if( n != 7 )
    {
       delete[] array;
       croak( "Specified %d sizes, 7 wanted", n );
    }
    THIS->SetFonts( normal_face, fixed_face, array );
    delete[] array;    
    
void
wxHtmlEasyPrinting::SetFooter( header, pg = wxPAGE_ALL )
    wxString header
    int pg

wxPrintData*
wxHtmlEasyPrinting::GetPrintData()

wxPageSetupDialogData*
wxHtmlEasyPrinting::GetPageSetupData()

wxWindow*
wxHtmlEasyPrinting::GetParentWindow()

void
wxHtmlEasyPrinting::SetParentWindow( window )
    wxWindow* window
