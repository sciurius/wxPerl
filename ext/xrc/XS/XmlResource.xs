#############################################################################
## Name:        ext/xrc/XS/XmlResource.xs
## Purpose:     XS for Wx::XmlResource
## Author:      Mattia Barbon
## Modified by:
## Created:     27/07/2001
## RCS-ID:      $Id: XmlResource.xs,v 1.9 2004/02/28 22:59:07 mbarbon Exp $
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/xrc/xmlres.h>
#include <wx/menu.h>
#include <wx/dialog.h>
#include <wx/panel.h>
#include <wx/toolbar.h>
#include <wx/frame.h>
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::XmlResource

Wx_XmlResource*
Wx_XmlResource::new( flags = wxXRC_USE_LOCALE )
    int flags

## XXX threads
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

wxMenu*
Wx_XmlResource::LoadMenu( name )
    wxString name

wxMenuBar*
Wx_XmlResource::LoadMenuBar( name )
    wxString name

wxMenuBar*
wxXmlResource::LoadMenuBarOnParent( parent, name )
    wxWindow* parent
    wxString name
  CODE:
    RETVAL = THIS->LoadMenuBar( parent, name );
  OUTPUT: RETVAL

wxToolBar*
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

void
wxXmlResource::LoadFrame( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wfrm_wwin_s, LoadOnFrame )
        MATCH_REDISP( wxPliOvl_wwin_s, LoadFrame2 )
    END_OVERLOAD( "Wx::XmlResource::LoadFrame" )

wxFrame*
wxXmlResource::LoadFrame2( parent, name )
    wxWindow* parent
    wxString name
  CODE:
    RETVAL = THIS->LoadFrame( parent, name );
  OUTPUT: RETVAL

bool
wxXmlResource::LoadOnFrame( frame, parent, name )
    wxFrame* frame
    wxWindow* parent
    wxString name
  CODE:
    RETVAL = THIS->LoadFrame( frame, parent, name );
  OUTPUT: RETVAL

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
wxXmlResource::GetFlags()

void
wxXmlResource::SetFlags( flags )
    int flags

int
GetXRCID( str_id )
    wxChar* str_id
  CODE:
    RETVAL = wxXmlResource::GetXRCID( str_id );
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

##Wx_XmlResource*
##Get()
##  CODE:
##    RETVAL = wxXmlResource::Get();
##  OUTPUT:
##    RETVAL

##void
##Wx_XmlResource::Set( res )
##    Wx_XmlResource* res
##  CODE:
##    wxXmlResource::Set( res );

## void
## wxXmlResource::UpdateResources()

void
AddSubclassFactory( wxXmlSubclassFactory *factory )
  CODE:
    wxPli_detach_object( aTHX_ ST(0) ); // avoid destructor
    wxXmlResource::AddSubclassFactory( factory );
