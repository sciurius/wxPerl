#############################################################################
## Name:        PageSetupDialog.xs
## Purpose:     XS for Wx::XmlResource
## Author:      Mattia Barbon
## Modified by:
## Created:     27/ 7/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/xrc/xmlres.h>
#include <wx/menu.h>
#include <wx/dialog.h>
#include <wx/panel.h>
#include <wx/toolbar.h>

MODULE=Wx PACKAGE=Wx::XmlResource

Wx_XmlResource*
Wx_XmlResource::new( use_locale = TRUE )
    bool use_locale

void
Wx_XmlResource::DESTROY()

bool
Wx_XmlResource::Load( filemask )
    wxString filemask

void
Wx_XmlResource::InitAllHandlers()

void
Wx_XmlResource::AddHandler( handler )
    Wx_XmlResourceHandler* handler

void
Wx_XmlResource::ClearHandlers()

Wx_Menu*
Wx_XmlResource::LoadMenu( name )
    wxString name

Wx_MenuBar*
Wx_XmlResource::LoadMenuBar( name )
    wxString name

Wx_ToolBar*
Wx_XmlResource::LoadToolBar( parent, name )
    Wx_Window* parent
    wxString name

Wx_Dialog*
Wx_XmlResource::LoadDialog( parent, name )
    Wx_Window* parent
    wxString name

bool
Wx_XmlResource::LoadOnDialog( dialog, parent, name )
    Wx_Dialog* dialog
    Wx_Window* parent
    wxString name
  CODE:
    RETVAL = THIS->LoadDialog( dialog, parent, name );
  OUTPUT:
    RETVAL

Wx_Panel*
Wx_XmlResource::LoadPanel( parent, name )
    Wx_Window* parent
    wxString name

bool
Wx_XmlResource::LoadOnPanel( panel, parent, name )
    Wx_Panel* panel
    Wx_Window* parent
    wxString name
  CODE:
    RETVAL = THIS->LoadPanel( panel, parent, name );
  OUTPUT:
    RETVAL

bool
Wx_XmlResource::LoadFrame( frame, parent, name )
    Wx_Frame* frame
    Wx_Window* parent
    wxString name

Wx_Bitmap*
Wx_XmlResource::LoadBitmap( name )
    wxString name
  CODE:
    RETVAL = new wxBitmap( THIS->LoadBitmap( name ) );
  OUTPUT:
    RETVAL

Wx_Icon*
Wx_XmlResource::LoadIcon( name )
    wxString name
  CODE:
    RETVAL = new wxIcon( THIS->LoadIcon( name ) );
  OUTPUT:
    RETVAL

bool
Wx_XmlResource::AttachUnknownControl( name, control, parent = 0 )
    wxString name
    Wx_Window* control
    Wx_Window* parent

int
GetXMLID( str_id )
    wxChar* str_id
  CODE:
    RETVAL = wxXmlResource::GetXMLID( str_id );
  OUTPUT:
    RETVAL

long
Wx_XmlResource::GetVersion()

int
Wx_XmlResource::CompareVersion( major, minor, release, revision )
    int major
    int minor
    int release
    int revision
