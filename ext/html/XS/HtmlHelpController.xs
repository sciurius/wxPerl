#############################################################################
## Name:        HtmlHelpController.xs
## Purpose:     XS for Wx::HtmlHelpController
## Author:      Mattia Barbon
## Modified by:
## Created:     21/ 3/2001
## RCS-ID:      $Id: HtmlHelpController.xs,v 1.5 2003/05/05 20:38:42 mbarbon Exp $
## Copyright:   (c) 2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/helpctrl.h>

#if defined(__WXMSW__)
#if wxPERL_USE_BESTHELP

#include <wx/msw/helpbest.h>
#undef THIS

MODULE=Wx PACKAGE=Wx::BestHelpController

Wx_BestHelpController*
Wx_BestHelpController::new()
  CODE:
    RETVAL = new wxBestHelpController();
  OUTPUT:
    RETVAL

#endif
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


