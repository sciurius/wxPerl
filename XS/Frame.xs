#############################################################################
## Name:        XS/Frame.xs
## Purpose:     XS for Wx::Frame
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Frame.xs,v 1.27 2006/05/06 15:13:08 mbarbon Exp $
## Copyright:   (c) 2000-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/frame.h>
#include <wx/menu.h>
#include <wx/icon.h>
#if wxPERL_USE_MINIFRAME
#include <wx/minifram.h>
#endif
#include "cpp/frame.h"

MODULE=Wx PACKAGE=Wx::Frame

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Frame::new" )

wxFrame*
newDefault( CLASS )
    char* CLASS
  CODE:
    RETVAL = new wxPliFrame( CLASS );
  OUTPUT: RETVAL

wxFrame*
newFull( CLASS, parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr )
    char* CLASS
    wxWindow* parent
    wxWindowID id
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliFrame( CLASS , parent, id, title, pos,
         size, style, name );
  OUTPUT: RETVAL

bool
wxFrame::Create( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr )
    wxWindow* parent
    wxWindowID id
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name

#if 0

void
wxFrame::Command( id )
    int id

#endif

wxStatusBar*
wxFrame::CreateStatusBar( number = 1, style = 0, id = -1, name = wxEmptyString )
    int number
    long style
    wxWindowID id
    wxString name

wxToolBar*
wxFrame::CreateToolBar( style = wxNO_BORDER | wxTB_HORIZONTAL, id = -1, name = wxToolBarNameStr )
    long style
    wxWindowID id
    wxString name

wxPoint*
wxFrame::GetClientAreaOrigin()
  CODE:
    RETVAL = new wxPoint( THIS->GetClientAreaOrigin() );
  OUTPUT:
    RETVAL

wxIcon*
wxFrame::GetIcon()
  CODE:
    RETVAL = new wxIcon( THIS->GetIcon() );
  OUTPUT: RETVAL

wxIconBundle*
wxFrame::GetIcons()
  CODE:
    RETVAL = new wxIconBundle( THIS->GetIcons() );
  OUTPUT: RETVAL

wxMenuBar*
wxFrame::GetMenuBar()

wxStatusBar*
wxFrame::GetStatusBar()

int
wxFrame::GetStatusBarPane()

wxString
wxFrame::GetTitle()

wxToolBar*
wxFrame::GetToolBar()

void
wxFrame::Iconize( iconize )
    bool iconize

bool
wxFrame::IsIconized()

bool
wxFrame::IsMaximized()

#if defined( __WXMSW__ ) || \
 ( defined( __WXGTK__ ) ) \
 || defined( __WXPERL_FORCE__ )

bool
wxFrame::IsFullScreen()

#endif

void
wxFrame::Maximize( maximize )
    bool maximize

#if defined( __WXMAC__ ) && WXPERL_W_VERSION_GE( 2, 5, 2 ) \
    && !WXPERL_W_VERSION_GE( 2, 7, 0 )

void
wxFrame::MacSetMetalAppearance( ismetal )
    bool ismetal

#endif

wxStatusBar*
wxFrame::OnCreateStatusBar( number, style, id, name )
    int number
    long style
    wxWindowID id
    wxString name
  CODE:
    RETVAL = THIS->wxFrame::OnCreateStatusBar( number, style, id, name );
  OUTPUT: RETVAL

void
wxFrame::SetIcon( icon )
    wxIcon* icon
  CODE:
    THIS->SetIcon( *icon );

void
wxFrame::SetIcons( icons )
    wxIconBundle* icons
  C_ARGS: *icons

void
wxFrame::SetMenuBar( menubar )
    wxMenuBar* menubar

#if (WXPERL_W_VERSION_GE( 2, 4, 1 ) && !defined(__WXMOTIF__)) \
    || WXPERL_W_VERSION_GE( 2, 5, 1 )

void
wxFrame::SetShape( region )
  wxRegion* region
  C_ARGS: *region

#endif

void
wxFrame::SetStatusBar( statusBar )
    wxStatusBar* statusBar

void
wxFrame::SetTitle( title )
    wxString title

void
wxFrame::SetToolBar( toolbar )
    wxToolBar* toolbar

void
wxFrame::SetStatusText( text, number = 0 )
    wxString text
    int number

void
wxFrame::SetStatusBarPane( n )
    int n

void
wxFrame::SetStatusWidths( ... )
  PREINIT:
    int* w;
    int i;
  CODE:
    w = new int[items - 1];
    for( i = 0; i < items - 1; ++i )
    {
      w[i] = SvIV( ST( i + 1 ) );
    }
    THIS->SetStatusWidths( items - 1, w );
    delete [] w;

#if defined( __WXMSW__ ) || \
 ( defined( __WXGTK__ ) ) \
 || defined( __WXPERL_FORCE__ )

bool
wxFrame::ShowFullScreen( show, style = wxFULLSCREEN_ALL )
    bool show
    long style

#endif

MODULE=Wx PACKAGE=Wx::MiniFrame

#if wxPERL_USE_MINIFRAME

wxMiniFrame*
wxMiniFrame::new( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr )
    wxWindow* parent
    wxWindowID id
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxMiniFrame( parent, id, title, pos, size, 
        style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

#endif