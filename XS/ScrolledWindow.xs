#############################################################################
## Name:        XS/ScrolledWindow.xs
## Purpose:     XS for Wx::ScrolledWindow
## Author:      Mattia Barbon
## Modified by:
## Created:     02/12/2000
## RCS-ID:      $Id: ScrolledWindow.xs,v 1.9 2003/06/04 20:38:43 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/scrolwin.h>
#include <wx/dc.h>
#include "cpp/scrolledwindow.h"

MODULE=Wx PACKAGE=Wx::ScrolledWindow

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::ScrolledWindow::new" )

wxScrolledWindow*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxPliScrolledWindow( CLASS );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

Wx_ScrolledWindow*
newFull( CLASS, parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxHSCROLL|wxVSCROLL, name = wxT("scrolledWindow") )
    PlClassName CLASS
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

bool
wxScrolledWindow::Create( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxHSCROLL|wxVSCROLL, name = wxT("scrolledWindow") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

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
wxScrolledWindow::SetScrollRate( xstep, ystep )
    int xstep
    int ystep

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
