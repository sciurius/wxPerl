#############################################################################
## Name:        XS/SashWindow.xs
## Purpose:     XS for Wx::SashWindow
## Author:      Mattia Barbon
## Modified by:
## Created:      3/ 2/2001
## RCS-ID:      $Id: SashWindow.xs,v 1.7 2003/05/31 15:36:56 mbarbon Exp $
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

wxSashWindow*
wxSashWindow::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxCLIP_CHILDREN|wxSW_3D, name = wxT("sashWindow") )
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

bool
wxSashWindow::HasBorder( edge )
    wxSashEdgePosition edge

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

void
wxSashWindow::SetSashBorder( edge, border )
    wxSashEdgePosition edge
    bool border

