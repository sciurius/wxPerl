#############################################################################
## Name:        ext/help/XS/HelpController.xs
## Purpose:     XS for Wx::HelpController*
## Author:      Mattia Barbon
## Modified by:
## Created:     18/03/2001
## RCS-ID:      $Id: HelpController.xs,v 1.4 2004/08/04 19:38:46 mbarbon Exp $
## Copyright:   (c) 2001, 2003, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/helpbase.h>

MODULE=Wx PACKAGE=Wx::HelpControllerBase

void
wxHelpControllerBase::Destroy()
  CODE:
    delete THIS;

void
wxHelpControllerBase::Initialize( file )
    wxString file

bool
wxHelpControllerBase::DisplayBlock( block )
    long block

bool
wxHelpControllerBase::DisplayContents()

bool
wxHelpControllerBase::DisplayContextPopup( id )
    int id

bool
wxHelpControllerBase::DisplayTextPopup( text, pos )
    wxString text
    wxPoint pos

bool
wxHelpControllerBase::DisplaySection( section )
    wxString section

bool
wxHelpControllerBase::DisplaySectionId( section )
    long section
  CODE:
    RETVAL = THIS->DisplaySection( section );
  OUTPUT:
    RETVAL

bool
wxHelpControllerBase::KeywordSearch( keyword )
    wxString keyword

bool
wxHelpControllerBase::LoadFile( file = wxEmptyString )
    wxString file

void
wxHelpControllerBase::SetViewer( viewer, flags )
    wxString viewer
    long flags

bool
wxHelpControllerBase::Quit()

MODULE=Wx PACKAGE=Wx::HelpControllerHtml

#if wxUSE_HTML && 0

#include <wx/generic/helpwxht.h>

wxHelpControllerHtml*
wxHelpControllerHtml::new()

#endif

MODULE=Wx PACKAGE=Wx::WinHelpController

#if defined( __WXMSW__ )

#include <wx/msw/helpwin.h>

wxWinHelpController*
wxWinHelpController::new()

#endif

MODULE=Wx PACKAGE=Wx::CHMHelpController

#if wxUSE_MS_HTML_HELP

#include <wx/msw/helpchm.h>

wxCHMHelpController*
wxCHMHelpController::new()

#endif

MODULE=Wx PACKAGE=Wx::ExtHelpController

#if 0

#include <wx/generic/helpext.h>

wxExtHelpController*
wxExtHelpController::new()

#endif
