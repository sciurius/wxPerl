#############################################################################
## Name:        HtmlHelpController.xs
## Purpose:     XS for Wx::HtmlHelpController
## Author:      Mattia Barbon
## Modified by:
## Created:     21/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/helpctrl.h>

#if WXPERL_W_VERSION_GE( 2, 3, 2 ) && defined(__WXMSW__)

#include <wx/msw/helpbest.h>

MODULE=Wx PACKAGE=Wx::BestHelpController

Wx_BestHelpController*
Wx_BestHelpController::new()
    long style
  CODE:
    RETVAL = new wxBestHelpController();
  OUTPUT:
    RETVAL

#endif

MODULE=Wx PACKAGE=Wx::HtmlHelpController

Wx_HtmlHelpController*
Wx_HtmlHelpController::new( style = wxHF_DEFAULTSTYLE )
    long style
  CODE:
    RETVAL = new wxHtmlHelpController( style );
  OUTPUT:
    RETVAL

bool
Wx_HtmlHelpController::AddBook( book, show_wait )
     wxString book
     bool show_wait

void
Wx_HtmlHelpController::Display( x )
    wxString x

void
Wx_HtmlHelpController::DisplayId( id )
    int id
  CODE:
    THIS->Display( id );

void
Wx_HtmlHelpController::DisplayContents()

void
Wx_HtmlHelpController::DisplayIndex()

bool
Wx_HtmlHelpController::KeywordSearch( keyword )
    wxString keyword

void
Wx_HtmlHelpController::ReadCustomization( cfg, path = wxEmptyString )
     Wx_ConfigBase* cfg
     wxString path

void
Wx_HtmlHelpController::SetTempDir( path )
    wxString path

void
Wx_HtmlHelpController::SetTitleFormat( format )
    wxString format

void
Wx_HtmlHelpController::UseConfig( config, path = wxEmptyString )
    Wx_ConfigBase* config
    wxString path

void
Wx_HtmlHelpController::WriteCustomization( cfg, path = wxEmptyString )
     Wx_ConfigBase* cfg
     wxString path


