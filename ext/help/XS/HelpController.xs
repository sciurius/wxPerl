#############################################################################
## Name:        HelpController.xs
## Purpose:     XS for Wx::HelpController*
## Author:      Mattia Barbon
## Modified by:
## Created:     18/ 3/2001
## RCS-ID:      $Id: HelpController.xs,v 1.3 2003/05/05 20:38:42 mbarbon Exp $
## Copyright:   (c) 2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/helpbase.h>

MODULE=Wx PACKAGE=Wx::HelpControllerBase

void
Wx_HelpControllerBase::Destroy()
  CODE:
    delete THIS;

void
Wx_HelpControllerBase::Initialize( file )
    wxString file

bool
Wx_HelpControllerBase::DisplayBlock( block )
    long block

bool
Wx_HelpControllerBase::DisplayContents()

bool
Wx_HelpControllerBase::DisplayContextPopup( id )
    int id

bool
Wx_HelpControllerBase::DisplayTextPopup( text, pos )
    wxString text
    Wx_Point pos

bool
Wx_HelpControllerBase::DisplaySection( section )
    wxString section

bool
Wx_HelpControllerBase::DisplaySectionId( section )
    long section
  CODE:
    RETVAL = THIS->DisplaySection( section );
  OUTPUT:
    RETVAL

bool
Wx_HelpControllerBase::KeywordSearch( keyword )
    wxString keyword

bool
Wx_HelpControllerBase::LoadFile( file = wxEmptyString )
    wxString file

void
Wx_HelpControllerBase::SetViewer( viewer, flags )
    wxString viewer
    long flags

bool
Wx_HelpControllerBase::Quit()

MODULE=Wx PACKAGE=Wx::HelpControllerHtml

#if wxUSE_HTML && 0

#include <wx/generic/helpwxht.h>

Wx_HelpControllerHtml*
Wx_HelpControllerHtml::new()

#endif

MODULE=Wx PACKAGE=Wx::WinHelpController

#if defined( __WXMSW__ )

#include <wx/msw/helpwin.h>

Wx_WinHelpController*
Wx_WinHelpController::new()

#endif

MODULE=Wx PACKAGE=Wx::CHMHelpController

#if wxUSE_MS_HTML_HELP

#include <wx/msw/helpchm.h>

Wx_CHMHelpController*
Wx_CHMHelpController::new()

#endif

MODULE=Wx PACKAGE=Wx::ExtHelpController

#if 0

#include <wx/generic/helpext.h>

Wx_ExtHelpController*
Wx_ExtHelpController::new()

#endif
