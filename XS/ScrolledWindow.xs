#############################################################################
## Name:        ScrolledWindow.xs
## Purpose:     XS for Wx::ScrolledWindow
## Author:      Mattia Barbon
## Modified by:
## Created:      2/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/scrolwin.h>
#include <wx/dc.h>
#include "cpp/scrolledwindow.h"

MODULE=Wx PACKAGE=Wx::ScrolledWindow

Wx_ScrolledWindow*
Wx_ScrolledWindow::new( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxHSCROLL|wxVSCROLL, name = wxT("scrolledWindow") )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliScrolledWindow( CLASS, parent, id, pos, size, style,
        name );
  OUTPUT:
    RETVAL

void
Wx_ScrolledWindow::CalcScrolledPosition( x, y )
    int x
    int y
  PREINIT:
    int xx;
    int yy;
  PPCODE:
    THIS->CalcScrolledPosition( x, y, &xx, &yy );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( xx ) ) );
    PUSHs( sv_2mortal( newSViv( yy ) ) );

void
Wx_ScrolledWindow::CalcUnscrolledPosition( x, y )
    int x
    int y
  PREINIT:
    int xx;
    int yy;
  PPCODE:
    THIS->CalcUnscrolledPosition( x, y, &xx, &yy );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( xx ) ) );
    PUSHs( sv_2mortal( newSViv( yy ) ) );

void
Wx_ScrolledWindow::EnableScrolling( xScrolling, yScrolling )
    bool xScrolling
    bool yScrolling

void
Wx_ScrolledWindow::GetScrollPixelsPerUnit()
  PREINIT:
    int xUnit;
    int yUnit;
  PPCODE:
    THIS->GetScrollPixelsPerUnit( &xUnit, &yUnit );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( xUnit ) ) );
    PUSHs( sv_2mortal( newSViv( yUnit ) ) );

void
Wx_ScrolledWindow::GetVirtualSize()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetVirtualSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

bool
Wx_ScrolledWindow::IsRetained()

void
Wx_ScrolledWindow::PrepareDC( dc )
    Wx_DC* dc
  CODE:
    THIS->PrepareDC( *dc );

void
Wx_ScrolledWindow::Scroll( x, y )
    int x
    int y

void
Wx_ScrolledWindow::SetScrollbars( ppuX, ppuY, nX, nY, xPos = 0, yPos = 0, noRefresh = FALSE )
    int ppuX
    int ppuY
    int nX
    int nY
    int xPos
    int yPos
    bool noRefresh

void
Wx_ScrolledWindow::SetTargetWindow( window )
    Wx_Window* window

void
Wx_ScrolledWindow::GetViewStart()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetViewStart( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
