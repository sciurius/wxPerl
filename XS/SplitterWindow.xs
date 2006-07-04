#############################################################################
## Name:        XS/SplitterWindow.xs
## Purpose:     XS for Wx::SplitterWindow
## Author:      Mattia Barbon
## Modified by:
## Created:     02/12/2000
## RCS-ID:      $Id: SplitterWindow.xs,v 1.12 2006/07/04 18:06:03 mbarbon Exp $
## Copyright:   (c) 2000-2003, 2005 Mattia Barbon
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
    %name{newDefault}
    wxSplitterWindow()
        %code{%    RETVAL = new wxSplitterWindow();
                   wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};

    %name{newFull}
    wxSplitterWindow( wxWindow* parent, wxWindowID id = -1,
                      const wxPoint& pos = wxDefaultPosition,
                      const wxSize& size = wxDefaultSize,
                      long style = wxSP_3D,
                      wxString name = wxSplitterWindowNameStr )
        %code{%    RETVAL = new wxSplitterWindow( parent, id, pos, size,
                       style, name );
                   wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};

    bool Create( wxWindow* parent, wxWindowID id = -1,
                 const wxPoint& pos = wxDefaultPosition,
                 const wxSize& size = wxDefaultSize,
                 long style = wxSP_3D,
                 wxString name = wxSplitterWindowNameStr );

    int GetMinimumPaneSize();
    int GetSashPosition();
    int GetSplitMode();
    wxWindow* GetWindow1();
    wxWindow* GetWindow2();

    void Initialize( wxWindow* window );

    bool IsSplit();

    bool ReplaceWindow( wxWindow* winOld, wxWindow* winNew );

#if WXPERL_W_VERSION_GE( 2, 5, 4 )
    void SetFocusIgnoringChildren();
#endif
    void SetSashPosition( int position, bool redraw = true );
    void SetMinimumPaneSize( int paneSize );
    void SetSplitMode( int mode );

    bool SplitHorizontally( wxWindow* window1, wxWindow* window2,
                            int sashPosition = 0 );
    bool SplitVertically( wxWindow* window1, wxWindow* window2,
                          int sashPosition = 0 );
    bool Unsplit( wxWindow* toRemove = NULL );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
    void SetSashGravity( double gravity );
    double GetSashGravity();
#endif
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    int GetSashSize();
    void SetSashSize( int width );
#endif
};

%{

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::SplitterWindow::new" )

%}