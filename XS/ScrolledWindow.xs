#############################################################################
## Name:        XS/ScrolledWindow.xs
## Purpose:     XS for Wx::ScrolledWindow
## Author:      Mattia Barbon
## Modified by:
## Created:     02/12/2000
## RCS-ID:      $Id: ScrolledWindow.xs,v 1.14 2006/09/07 20:45:28 mbarbon Exp $
## Copyright:   (c) 2000-2003, 2005-2006 Mattia Barbon
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

wxScrolledWindow*
newFull( CLASS, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxHSCROLL|wxVSCROLL, name = wxT("scrolledWindow") )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliScrolledWindow( CLASS, parent, id, pos, size, style,
        name );
  OUTPUT:
    RETVAL

bool
wxScrolledWindow::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxHSCROLL|wxVSCROLL, name = wxT("scrolledWindow") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

void
wxScrolledWindow::CalcScrolledPosition( x, y )
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
wxScrolledWindow::CalcUnscrolledPosition( x, y )
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
wxScrolledWindow::EnableScrolling( xScrolling, yScrolling )
    bool xScrolling
    bool yScrolling

void
wxScrolledWindow::GetScrollPixelsPerUnit()
  PREINIT:
    int xUnit;
    int yUnit;
  PPCODE:
    THIS->GetScrollPixelsPerUnit( &xUnit, &yUnit );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( xUnit ) ) );
    PUSHs( sv_2mortal( newSViv( yUnit ) ) );

void
wxScrolledWindow::GetVirtualSize()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetVirtualSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

bool
wxScrolledWindow::IsRetained()

void
wxScrolledWindow::PrepareDC( dc )
    wxDC* dc
  CODE:
    THIS->PrepareDC( *dc );

void
wxScrolledWindow::Scroll( x, y )
    int x
    int y

void
wxScrolledWindow::SetScrollbars( ppuX, ppuY, nX, nY, xPos = 0, yPos = 0, noRefresh = false )
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
wxScrolledWindow::SetTargetWindow( window )
    wxWindow* window

void
wxScrolledWindow::GetViewStart()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetViewStart( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
