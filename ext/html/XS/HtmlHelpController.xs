#############################################################################
## Name:        ext/html/XS/HtmlHelpController.xs
## Purpose:     XS for Wx::HtmlHelpController
## Author:      Mattia Barbon
## Modified by:
## Created:     21/03/2001
## RCS-ID:      $Id: HtmlHelpController.xs,v 1.7 2004/12/21 21:12:53 mbarbon Exp $
## Copyright:   (c) 2001, 2003-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/helpctrl.h>

#if defined(__WXMSW__)
#if wxPERL_USE_BESTHELP

#include <wx/msw/helpbest.h>
#undef THIS

MODULE=Wx PACKAGE=Wx::BestHelpController

wxBestHelpController*
wxBestHelpController::new()
  CODE:
    RETVAL = new wxBestHelpController();
  OUTPUT:
    RETVAL

#endif
#endif

MODULE=Wx PACKAGE=Wx::HtmlHelpController

wxHtmlHelpController*
wxHtmlHelpController::new( style = wxHF_DEFAULTSTYLE )
    long style
  CODE:
    RETVAL = new wxHtmlHelpController( style );
  OUTPUT:
    RETVAL

bool
wxHtmlHelpController::AddBook( book, show_wait )
     wxString book
     bool show_wait

void
wxHtmlHelpController::Display( x )
    wxString x

void
wxHtmlHelpController::DisplayId( id )
    int id
  CODE:
    THIS->Display( id );

void
wxHtmlHelpController::DisplayContents()

void
wxHtmlHelpController::DisplayIndex()

bool
wxHtmlHelpController::KeywordSearch( keyword )
    wxString keyword

void
wxHtmlHelpController::ReadCustomization( cfg, path = wxEmptyString )
     wxConfigBase* cfg
     wxString path

void
wxHtmlHelpController::SetTempDir( path )
    wxString path

void
wxHtmlHelpController::SetTitleFormat( format )
    wxString format

void
wxHtmlHelpController::UseConfig( config, path = wxEmptyString )
    wxConfigBase* config
    wxString path

void
wxHtmlHelpController::WriteCustomization( cfg, path = wxEmptyString )
     wxConfigBase* cfg
     wxString path


