#############################################################################
## Name:        SashWindow.xs
## Purpose:     XS for Wx::SashWindow
## Author:      Mattia Barbon
## Modified by:
## Created:      3/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/sashwin.h>
#include "cpp/sashwindow.h"

MODULE=Wx_Evt PACKAGE=Wx::SashEvent

Wx_SashEvent*
Wx_SashEvent::new( id = 0, edge = wxSASH_NONE )
    int id
    wxSashEdgePosition edge

wxSashEdgePosition
Wx_SashEvent::GetEdge()

Wx_Rect*
Wx_SashEvent::GetDragRect()
  CODE:
    RETVAL = new wxRect( THIS->GetDragRect() );
  OUTPUT:
    RETVAL

wxSashDragStatus
Wx_SashEvent::GetDragStatus()

MODULE=Wx PACKAGE=Wx::SashWindow

Wx_SashWindow*
Wx_SashWindow::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxCLIP_CHILDREN|wxSW_3D, name = wxT("sashWindow") )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliSashWindow( CLASS, parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

bool
Wx_SashWindow::GetSashVisible( edge )
    wxSashEdgePosition edge

int
Wx_SashWindow::GetMaximumSizeX()

int
Wx_SashWindow::GetMaximumSizeY()

int
Wx_SashWindow::GetMinimumSizeX()

int
Wx_SashWindow::GetMinimumSizeY()

bool
Wx_SashWindow::HasBorder( edge )
    wxSashEdgePosition edge

void
Wx_SashWindow::SetMaximumSizeX( max )
    int max

void
Wx_SashWindow::SetMaximumSizeY( max )
    int max

void
Wx_SashWindow::SetMinimumSizeX( min )
    int min

void
Wx_SashWindow::SetMinimumSizeY( min )
    int min

void
Wx_SashWindow::SetSashVisible( edge, visible )
    wxSashEdgePosition edge
    bool visible

void
Wx_SashWindow::SetSashBorder( edge, border )
    wxSashEdgePosition edge
    bool border

