#############################################################################
## Name:        SplitterWindow.xs
## Purpose:     XS for Wx::SplitterWindow
## Author:      Mattia Barbon
## Modified by:
## Created:      2/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/splitter.h>
#include "cpp/splitterwindow.h"

MODULE=Wx_Evt PACKAGE=Wx::SplitterEvent

int
Wx_SplitterEvent::GetSashPosition()

int
Wx_SplitterEvent::GetX()

int
Wx_SplitterEvent::GetY()

Wx_Window*
Wx_SplitterEvent::GetWindowBeingRemoved()

void
Wx_SplitterEvent::SetSashPosition( pos )
    int pos


MODULE=Wx PACKAGE=Wx::SplitterWindow

Wx_SplitterWindow*
Wx_SplitterWindow::new( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSP_3D, name = "splitterWindow" )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliSplitterWindow( CLASS, parent, id,
        pos, size, style, name );
  OUTPUT:
    RETVAL

int
Wx_SplitterWindow::GetMinimumPaneSize()

int
Wx_SplitterWindow::GetSashPosition()

int
Wx_SplitterWindow::GetSplitMode()

Wx_Window*
Wx_SplitterWindow::GetWindow1()

Wx_Window*
Wx_SplitterWindow::GetWindow2()

void
Wx_SplitterWindow::Initialize( window )
    Wx_Window* window

bool
Wx_SplitterWindow::IsSplit()

bool
Wx_SplitterWindow::ReplaceWindow( winOld, winNew )
    Wx_Window* winOld
    Wx_Window* winNew

void
Wx_SplitterWindow::SetSashPosition( position, redraw = TRUE )
    int position
    bool redraw

void
Wx_SplitterWindow::SetMinimumPaneSize( paneSize )
    int paneSize

void
Wx_SplitterWindow::SetSplitMode( mode )
    int mode

bool
Wx_SplitterWindow::SplitHorizontally( window1, window2, sashPosition = 0 )
    Wx_Window* window1
    Wx_Window* window2
    int sashPosition

bool
Wx_SplitterWindow::SplitVertically( window1, window2, sashPosition = 0 )
    Wx_Window* window1
    Wx_Window* window2
    int sashPosition

bool
Wx_SplitterWindow::Unsplit( toRemove = 0 )
    Wx_Window* toRemove
