#############################################################################
## Name:        ext/help/XS/HelpController.xs
## Purpose:     XS for Wx::HelpController*
## Author:      Mattia Barbon
## Modified by:
## Created:     18/03/2001
## RCS-ID:      $Id: HelpController.xs,v 1.6 2006/12/02 13:08:51 mbarbon Exp $
## Copyright:   (c) 2001, 2003, 2004, 2006 Mattia Barbon
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

#if WXPERL_W_VERSION_GE( 2, 6, 3 )

wxWindow*
wxHelpControllerBase::GetParentWindow()

void
wxHelpControllerBase::SetParentWindow( parent )
    wxWindow* parent

#endif

MODULE=Wx PACKAGE=Wx::WinHelpController

#if defined( __WXMSW__ )

#include <wx/msw/helpwin.h>

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

wxWinHelpController*
wxWinHelpController::new( parent = NULL )
    wxWindow* parent

#else

wxWinHelpController*
wxWinHelpController::new()

#endif

#endif

MODULE=Wx PACKAGE=Wx::CHMHelpController

#if wxUSE_MS_HTML_HELP

#include <wx/msw/helpchm.h>

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

wxCHMHelpController*
wxCHMHelpController::new( parent = NULL )
    wxWindow* parent

#else

wxCHMHelpController*
wxCHMHelpController::new()

#endif

#endif
