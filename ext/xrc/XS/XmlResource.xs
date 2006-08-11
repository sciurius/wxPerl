#############################################################################
## Name:        ext/xrc/XS/XmlResource.xs
## Purpose:     XS for Wx::XmlResource
## Author:      Mattia Barbon
## Modified by:
## Created:     27/07/2001
## RCS-ID:      $Id: XmlResource.xs,v 1.12 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2001-2004, 2006 Mattia Barbon
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

wxXmlResource*
wxXmlResource::new( flags = wxXRC_USE_LOCALE )
    int flags

static void
wxXmlResource::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxXmlResource::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::XmlResource", THIS, ST(0) );
    delete THIS;

bool
wxXmlResource::Load( filemask )
    wxString filemask

void
wxXmlResource::InitAllHandlers()

void
wxXmlResource::AddHandler( handler )
    wxXmlResourceHandler* handler

void
wxXmlResource::ClearHandlers()

wxMenu*
wxXmlResource::LoadMenu( name )
    wxString name

wxMenuBar*
wxXmlResource::LoadMenuBar( name )
    wxString name

wxMenuBar*
wxXmlResource::LoadMenuBarOnParent( parent, name )
    wxWindow* parent
    wxString name
  CODE:
    RETVAL = THIS->LoadMenuBar( parent, name );
  OUTPUT: RETVAL

wxToolBar*
wxXmlResource::LoadToolBar( parent, name )
    wxWindow* parent
    wxString name

wxDialog*
wxXmlResource::LoadDialog( parent, name )
    wxWindow* parent
    wxString name

bool
wxXmlResource::LoadOnDialog( dialog, parent, name )
    wxDialog* dialog
    wxWindow* parent
    wxString name
  CODE:
    RETVAL = THIS->LoadDialog( dialog, parent, name );
  OUTPUT:
    RETVAL

wxPanel*
wxXmlResource::LoadPanel( parent, name )
    wxWindow* parent
    wxString name

bool
wxXmlResource::LoadOnPanel( panel, parent, name )
    wxPanel* panel
    wxWindow* parent
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

wxBitmap*
wxXmlResource::LoadBitmap( name )
    wxString name
  CODE:
    RETVAL = new wxBitmap( THIS->LoadBitmap( name ) );
  OUTPUT:
    RETVAL

wxIcon*
wxXmlResource::LoadIcon( name )
    wxString name
  CODE:
    RETVAL = new wxIcon( THIS->LoadIcon( name ) );
  OUTPUT:
    RETVAL

bool
wxXmlResource::AttachUnknownControl( name, control, parent = 0 )
    wxString name
    wxWindow* control
    wxWindow* parent

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
wxXmlResource::GetVersion()

int
wxXmlResource::CompareVersion( major, minor, release, revision )
    int major
    int minor
    int release
    int revision

##wxXmlResource*
##Get()
##  CODE:
##    RETVAL = wxXmlResource::Get();
##  OUTPUT:
##    RETVAL

##void
##wxXmlResource::Set( res )
##    wxXmlResource* res
##  CODE:
##    wxXmlResource::Set( res );

## void
## wxXmlResource::UpdateResources()

void
AddSubclassFactory( wxXmlSubclassFactory *factory )
  CODE:
    wxPli_detach_object( aTHX_ ST(0) ); // avoid destructor
    wxXmlResource::AddSubclassFactory( factory );
