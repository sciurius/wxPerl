#############################################################################
## Name:        HelpProvider.xs
## Purpose:     XS for Wx::*HelpProvider
## Author:      Mattia Barbon
## Modified by:
## Created:     21/ 3/2001
## RCS-ID:      $Id: HelpProvider.xs,v 1.3 2003/05/05 20:38:42 mbarbon Exp $
## Copyright:   (c) 2001, 2003 Mattia Barbon
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
Wx_HelpProvider::Destroy()
  CODE:
    delete THIS;

Wx_HelpProvider*
Wx_HelpProvider::Get()
  CODE:
    RETVAL = wxHelpProvider::Get();
  OUTPUT:
    RETVAL

wxString
Wx_HelpProvider::GetHelp( window )
    Wx_Window* window

bool
Wx_HelpProvider::ShowHelp( window )
    Wx_Window* window

void
Wx_HelpProvider::AddHelp( window, text )
    Wx_Window* window
    wxString text

void
Wx_HelpProvider::AddHelpById( id, text )
    wxWindowID id
    wxString text
  CODE:
    THIS->AddHelp( id, text );

Wx_HelpProvider*
Set( helpProvider )
    Wx_HelpProvider* helpProvider
  CODE:
    RETVAL = wxHelpProvider::Set( helpProvider );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::SimpleHelpProvider

Wx_SimpleHelpProvider*
Wx_SimpleHelpProvider::new()
  CODE:
    RETVAL = new wxSimpleHelpProvider();
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::HelpControllerHelpProvider

Wx_HelpControllerHelpProvider*
Wx_HelpControllerHelpProvider::new( hc = 0 )
    Wx_HelpControllerBase* hc
  CODE:
    RETVAL = new wxHelpControllerHelpProvider( hc );
  OUTPUT:
    RETVAL

void
Wx_HelpControllerHelpProvider::SetHelpController( hc )
    Wx_HelpControllerBase* hc

Wx_HelpControllerBase*
Wx_HelpControllerHelpProvider::GetHelpController()

