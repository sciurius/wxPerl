#############################################################################
## Name:        XS/SplitterWindow.xs
## Purpose:     XS for Wx::SplitterWindow
## Author:      Mattia Barbon
## Modified by:
## Created:      2/12/2000
## RCS-ID:      $Id: SplitterWindow.xs,v 1.8 2003/05/27 20:10:29 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%{
#include <wx/splitter.h>
%}

%module{Wx};

%name{Wx::SplitterEvent} class wxSplitterEvent
{
    wxSplitterEvent( wxEventType type = wxEVT_NULL,
                     wxSplitterWindow* window = NULL );

    int GetSashPosition();
    int GetX();
    int GetY();
    wxWindow* GetWindowBeingRemoved();
    void SetSashPosition( int pos );
};

%{
#define wxSplitterWindowNameStr wxT("splitter")
%}

%name{Wx::SplitterWindow} class wxSplitterWindow
{
    wxSplitterWindow( wxWindow* parent, wxWindowID id = -1,
                      const wxPoint& pos = wxDefaultPosition,
                      const wxSize& size = wxDefaultSize,
                      long style = wxSP_3D,
                      wxString name = wxSplitterWindowNameStr )
        %code{%    RETVAL = new wxSplitterWindow( parent, id, pos, size,
                       style, name );
                   wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};

    int GetMinimumPaneSize();
    int GetSashPosition();
    int GetSplitMode();
    wxWindow* GetWindow1();
    wxWindow* GetWindow2();

    void Initialize( wxWindow* window );

    bool IsSplit();

    bool ReplaceWindow( wxWindow* winOld, wxWindow* winNew );

    void SetSashPosition( int position, bool redraw = true );
    void SetMinimumPaneSize( int paneSize );
    void SetSplitMode( int mode );

    bool SplitHorizontally( wxWindow* window1, wxWindow* window2,
                            int sashPosition = 0 );
    bool SplitVertically( wxWindow* window1, wxWindow* window2,
                          int sashPosition = 0 );
    bool Unsplit( wxWindow* toRemove = NULL );
};
