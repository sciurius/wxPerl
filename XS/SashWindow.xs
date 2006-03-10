#############################################################################
## Name:        XS/SashWindow.xs
## Purpose:     XS for Wx::SashWindow
## Author:      Mattia Barbon
## Modified by:
## Created:     03/02/2001
## RCS-ID:      $Id: SashWindow.xs,v 1.9 2006/03/10 19:25:33 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/sashwin.h>

MODULE=Wx_Evt PACKAGE=Wx::SashEvent

wxSashEvent*
wxSashEvent::new( id = 0, edge = wxSASH_NONE )
    int id
    wxSashEdgePosition edge

wxSashEdgePosition
wxSashEvent::GetEdge()

wxRect*
wxSashEvent::GetDragRect()
  CODE:
    RETVAL = new wxRect( THIS->GetDragRect() );
  OUTPUT:
    RETVAL

wxSashDragStatus
wxSashEvent::GetDragStatus()

MODULE=Wx PACKAGE=Wx::SashWindow

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::SashWindow::new" )

wxSashWindow*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxSashWindow();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxSashWindow*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxCLIP_CHILDREN|wxSW_3D, name = wxT("sashWindow") )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxSashWindow( parent, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxSashWindow::Create( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxCLIP_CHILDREN|wxSW_3D, name = wxT("sashWindow") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

bool
wxSashWindow::GetSashVisible( edge )
    wxSashEdgePosition edge

int
wxSashWindow::GetMaximumSizeX()

int
wxSashWindow::GetMaximumSizeY()

int
wxSashWindow::GetMinimumSizeX()

int
wxSashWindow::GetMinimumSizeY()

#if !WXPERL_W_VERSION_GE( 2, 7, 0 )

bool
wxSashWindow::HasBorder( edge )
    wxSashEdgePosition edge

#endif

void
wxSashWindow::SetMaximumSizeX( max )
    int max

void
wxSashWindow::SetMaximumSizeY( max )
    int max

void
wxSashWindow::SetMinimumSizeX( min )
    int min

void
wxSashWindow::SetMinimumSizeY( min )
    int min

void
wxSashWindow::SetSashVisible( edge, visible )
    wxSashEdgePosition edge
    bool visible

#if !WXPERL_W_VERSION_GE( 2, 7, 0 )

void
wxSashWindow::SetSashBorder( edge, border )
    wxSashEdgePosition edge
    bool border

#endif
