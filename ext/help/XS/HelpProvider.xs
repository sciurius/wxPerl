#############################################################################
## Name:        ext/help/XS/HelpProvider.xs
## Purpose:     XS for Wx::*HelpProvider
## Author:      Mattia Barbon
## Modified by:
## Created:     21/03/2001
## RCS-ID:      $Id: HelpProvider.xs,v 1.4 2004/08/04 19:38:46 mbarbon Exp $
## Copyright:   (c) 2001, 2003, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cshelp.h>

MODULE=Wx PACKAGE=Wx PREFIX=wx

wxString
wxContextId( id )
    int id

MODULE=Wx PACKAGE=Wx::HelpProvider

void
wxHelpProvider::Destroy()
  CODE:
    delete THIS;

wxHelpProvider*
wxHelpProvider::Get()
  CODE:
    RETVAL = wxHelpProvider::Get();
  OUTPUT:
    RETVAL

wxString
wxHelpProvider::GetHelp( window )
    wxWindow* window

bool
wxHelpProvider::ShowHelp( window )
    wxWindow* window

void
wxHelpProvider::AddHelp( window, text )
    wxWindow* window
    wxString text

void
wxHelpProvider::AddHelpById( id, text )
    wxWindowID id
    wxString text
  CODE:
    THIS->AddHelp( id, text );

wxHelpProvider*
Set( helpProvider )
    wxHelpProvider* helpProvider
  CODE:
    RETVAL = wxHelpProvider::Set( helpProvider );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::SimpleHelpProvider

wxSimpleHelpProvider*
wxSimpleHelpProvider::new()
  CODE:
    RETVAL = new wxSimpleHelpProvider();
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::HelpControllerHelpProvider

wxHelpControllerHelpProvider*
wxHelpControllerHelpProvider::new( hc = 0 )
    wxHelpControllerBase* hc
  CODE:
    RETVAL = new wxHelpControllerHelpProvider( hc );
  OUTPUT:
    RETVAL

void
wxHelpControllerHelpProvider::SetHelpController( hc )
    wxHelpControllerBase* hc

wxHelpControllerBase*
wxHelpControllerHelpProvider::GetHelpController()

